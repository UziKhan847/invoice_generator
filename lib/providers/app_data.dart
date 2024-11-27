import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/main.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final appData = ChangeNotifierProvider<AppData>((ref) {
  return AppData();
});

class AppData extends ChangeNotifier {
  late PostgrestList invoiceData;
  late List<Invoice> invoices;
  late PostgrestList invoiceId;
  late PostgrestList invoiceIdData;
  late int newInvoiceId;
  late PostgrestList newInvoice;

  late PostgrestList senderData;
  late List<Sender> senders;
  late PostgrestList newSender;

  late PostgrestList recipientData;
  late List<Recipient> recipients;
  late PostgrestList newRecipient;

  late PostgrestList courseData;
  late List<Course> courses;
  late PostgrestList newCourse;

  //Fetch Data Methods
  Future<void> getData() async {
    try {
      invoiceData = await supabase
          .from("invoices")
          .select("*, senders(*), recipients(*), courses(*)")
          .order("invoice_id", ascending: true);

      senderData = await supabase
          .from("senders")
          .select()
          .order("sender_id", ascending: true);

      recipientData = await supabase
          .from("recipients")
          .select()
          .order("recipient_id", ascending: true);

      courseData = await supabase
          .from("courses")
          .select()
          .order("course_id", ascending: true);

      invoices = invoiceData.map(Invoice.fromJson).toList();
      senders = senderData.map(Sender.fromJson).toList();
      recipients = recipientData.map(Recipient.fromJson).toList();
      courses = courseData.map(Course.fromJson).toList();

      print("SUCCESS!");
    } catch (e) {
      print(e);
    }
  }

  //Insert Data Methods
  Future<void> insertInvoice({
    required BuildContext context,
    required String invoiceDate,
    required String? dueDate,
    required double subtotal,
    required int senderId,
    required int recipientId,
    required Map<int, Course> selectedCourses,
  }) async {
    try {
      invoiceIdData = invoiceDate.isEmpty
          ? await supabase.from("invoices").insert(
              {
                'due_date': dueDate,
                'subtotal': subtotal,
                'sender_id': senderId,
                'recipient_id': recipientId
              },
            ).select("invoice_id")
          : await supabase.from("invoices").insert(
              {
                'invoice_date': invoiceDate,
                'due_date': dueDate,
                'subtotal': subtotal,
                'sender_id': senderId,
                'recipient_id': recipientId
              },
            ).select("invoice_id");

      newInvoiceId = invoiceIdData[0]['invoice_id'];

      for (int i = 0; i < selectedCourses.length; i++) {
        await supabase.from("invoice_courses").insert({
          'invoice_id': newInvoiceId,
          'course_id': selectedCourses[i]!.courseId
        });
      }

      newInvoice = await supabase
          .from('invoices')
          .select("*, senders(*), recipients(*), courses(*)")
          .eq('invoice_id', newInvoiceId);

      invoices.add(Invoice.fromJson(newInvoice[0]));

      notifyListeners();

      if (context.mounted) {
        context.showSnackBar('Successfully Added an Invocie');
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('$e', isError: true);
      }
    }
  }

  //Sender
  Future<void> insertSender({
    required BuildContext context,
    required String name,
    required String street,
    required String city,
    required String prov,
    required String zip,
    required String phone,
    required String email,
    required String eTransfer,
  }) async {
    try {
      newSender = await supabase.from("senders").insert(
        {
          'name': name,
          'street': street,
          'city': city,
          'province': prov,
          'zip': zip,
          'phone': phone,
          'email': email,
          'e_transer': eTransfer
        },
      ).select();

      senders.add(Sender.fromJson(newSender[0]));

      notifyListeners();

      if (context.mounted) {
        context.showSnackBar('Successfully Added a Sender');
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('$e', isError: true);
      }
    }
  }

  //Recipient
  Future<void> insertRecipeint({
    required BuildContext context,
    required String name,
    required String street,
    required String city,
    required String prov,
    required String zip,
    required String phone,
    required String email,
  }) async {
    try {
      newRecipient = await supabase.from("recipients").insert(
        {
          'name': name,
          'street': street,
          'city': city,
          'province': prov,
          'zip': zip,
          'phone': phone,
          'email': email,
        },
      ).select();

      recipients.add(Recipient.fromJson(newRecipient[0]));

      notifyListeners();

      if (context.mounted) {
        context.showSnackBar('Successfully Added a Recipient');
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('$e', isError: true);
      }
    }
  }

  //Course
  Future<void> insertCourse({
    required BuildContext context,
    required String name,
    required double cost,
    required String frequency,
    required int quantity,
  }) async {
    try {
      newCourse = await supabase.from("courses").insert(
        {
          'name': name,
          'cost': cost,
          'cost_frequency': frequency,
          'quantity': quantity
        },
      ).select();

      courses.add(Course.fromJson(newCourse[0]));

      notifyListeners();

      if (context.mounted) {
        context.showSnackBar('Successfully Added Course');
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('$e', isError: true);
      }
    }
  }
}
