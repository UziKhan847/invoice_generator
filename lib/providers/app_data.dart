import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/main.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final appData = ChangeNotifierProvider<AppData>((ref) => AppData());

const selectSenders =
    "sender_id, name, street, city, province, zip, phone, email, e_transfer, business_number";
const selectRecipients =
    "recipient_id, name, street, city, province, zip, phone, email";
const selectInvoices =
    "invoice_id, invoice_date, due_date, subtotal, hst, total, senders($selectSenders), recipients($selectRecipients), invoice_courses(courses(course_id, name, cost, cost_frequency), quantity, amount)";
const selectReceipts =
    "receipt_id, receipt_date, paid, invoices($selectInvoices)";

class AppData extends ChangeNotifier {
  late PostgrestList receiptData;
  late List<Receipt> receipts;
  late PostgrestList newReceipt;
  late PostgrestList invoiceCourseIds;

  late PostgrestList invoiceData;
  late List<Invoice> invoices;
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
  late PostgrestList newInvoiceCourse;

  //Fetch Data Methods
  Future<void> getData() async {
    try {
      receiptData = await supabase
          .from("receipts")
          .select(selectReceipts)
          .eq('is_deleted', false)
          .order("receipt_id", ascending: true);

      invoiceData = await supabase
          .from("invoices")
          .select(selectInvoices)
          .eq('is_deleted', false)
          .order("invoice_id", ascending: true);

      senderData = await supabase
          .from("senders")
          .select(selectSenders)
          .eq('is_deleted', false)
          .order("sender_id", ascending: true);

      recipientData = await supabase
          .from("recipients")
          .select(selectRecipients)
          .eq('is_deleted', false)
          .order("recipient_id", ascending: true);

      courseData = await supabase
          .from("courses")
          .select('course_id, name, cost, cost_frequency')
          .eq('is_deleted', false)
          .order("course_id", ascending: true);

      receipts = receiptData.map(Receipt.fromJson).toList();

      invoices = invoiceData.map(Invoice.fromJson).toList();

      senders = senderData.map(Sender.fromJson).toList();

      recipients = recipientData.map(Recipient.fromJson).toList();

      courses = courseData.map(Course.fromJson).toList();
    } catch (e) {
      rethrow;
    }
  }

  //Insert Data Methods

  //Receipt
  Future<void> insertReceipt({
    required BuildContext context,
    required String receiptDate,
    required double paid,
    required int invoiceId,
  }) async {
    try {
      newReceipt = await supabase.from("receipts").insert(
        {
          if (receiptDate.isNotEmpty) 'receipt_date': receiptDate,
          'paid': paid,
          'invoice_id': invoiceId,
        },
      ).select(selectReceipts);

      receipts.add(Receipt.fromJson(newReceipt[0]));

      notifyListeners();

      if (context.mounted) {
        context.showSnackBar('Successfully Added a Receipt');
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('$e', isError: true);
      }
    }
  }

  Future<void> deleteReceipt(
      {required BuildContext context, required int receiptId}) async {
    try {
      await supabase
          .from('receipts')
          .update({'is_deleted': true}).eq('receipt_id', receiptId);

      receipts.removeWhere((e) => e.receiptId == receiptId);

      notifyListeners();

      if (context.mounted) {
        context.showSnackBar('Successfully Deleted Receipt');
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('$e', isError: true);
      }
    }
  }

  //Invoice
  Future<void> insertInvoice({
    required BuildContext context,
    required String invoiceDate,
    required String dueDate,
    required Map<int, double> quantities,
    required Map<int, double> amounts,
    required double subtotal,
    required int senderId,
    required int recipientId,
    required Map<int, Course> selectedCourses,
  }) async {
    try {
      invoiceIdData = await supabase.from("invoices").insert(
        {
          if (invoiceDate.isNotEmpty) 'invoice_date': invoiceDate,
          'due_date': dueDate.isNotEmpty ? dueDate : null,
          'subtotal': subtotal,
          'sender_id': senderId,
          'recipient_id': recipientId
        },
      ).select("invoice_id");

      newInvoiceId = invoiceIdData[0]['invoice_id'];

      for (int i = 0; i < selectedCourses.length; i++) {
        await supabase.from("invoice_courses").insert({
          'invoice_id': newInvoiceId,
          'course_id': selectedCourses[i]!.courseId,
          'quantity': quantities[i],
          'amount': amounts[i]
        });
      }

      newInvoice = await supabase
          .from('invoices')
          .select(selectInvoices)
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

  Future<void> deleteInvoice(
      {required BuildContext context, required int invoiceId}) async {
    try {
      await supabase
          .from('invoices')
          .update({'is_deleted': true}).eq('invoice_id', invoiceId);

      invoices.removeWhere((e) => e.invoiceId == invoiceId);

      notifyListeners();

      if (context.mounted) {
        context.showSnackBar('Successfully Deleted Invoice');
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('$e', isError: true);
      }
    }
  }

  //Sender
  Future<void> insertSender(
      {required BuildContext context,
      required String name,
      required String street,
      required String city,
      required String prov,
      required String zip,
      required String phone,
      required String email,
      required String eTransfer,
      required String businessNumber}) async {
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
          'e_transfer': eTransfer,
          'business_number': businessNumber
        },
      ).select(selectSenders);

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

  Future<void> deleteSender(
      {required BuildContext context, required int senderId}) async {
    try {
      await supabase
          .from('senders')
          .update({'is_deleted': true}).eq('sender_id', senderId);

      senders.removeWhere((e) => e.senderId == senderId);

      notifyListeners();

      if (context.mounted) {
        context.showSnackBar('Successfully Deleted Sender');
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
      ).select(selectRecipients);

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

  Future<void> deleteRecipient(
      {required BuildContext context, required int recipientId}) async {
    try {
      await supabase
          .from('recipients')
          .update({'is_deleted': true}).eq('recipient_id', recipientId);

      recipients.removeWhere((e) => e.recipientId == recipientId);

      notifyListeners();

      if (context.mounted) {
        context.showSnackBar('Successfully Deleted Recipient');
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('$e', isError: true);
      }
    }
  }

  //Courses
  Future<void> insertCourse({
    required BuildContext context,
    required String name,
    required double cost,
    required String frequency,
  }) async {
    try {
      newCourse = await supabase.from("courses").insert(
        {
          'name': name,
          'cost': cost,
          'cost_frequency': frequency,
        },
      ).select('course_id, name, cost, cost_frequency');

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

  // Future<void> updateCourse({
  //   required BuildContext context,
  //   required int courseId,
  //   required String name,
  //   required double cost,
  //   required String frequency,
  // }) async {
  //   try {
  //     newCourse = await supabase
  //         .from("courses")
  //         .update(
  //           {
  //             'name': name,
  //             'cost': cost,
  //             'cost_frequency': frequency,
  //           },
  //         )
  //         .eq('course_id', courseId)
  //         .select('course_id, name, cost, cost_frequency');

  //     courses.removeWhere((e) => e.courseId == courseId);

  //     courses.add(Course.fromJson(newCourse[0]));

  //     courses.sort((a, b) => a.courseId.compareTo(b.courseId));

  //     notifyListeners();

  //     if (context.mounted) {
  //       context.showSnackBar('Successfully Added Course');
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       context.showSnackBar('$e', isError: true);
  //     }
  //   }
  // }

  Future<void> deleteCourse(
      {required BuildContext context, required int courseId}) async {
    try {
      await supabase
          .from('courses')
          .update({'is_deleted': true}).eq('course_id', courseId);

      courses.removeWhere((e) => e.courseId == courseId);

      notifyListeners();

      if (context.mounted) {
        context.showSnackBar('Successfully Deleted Course');
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('$e', isError: true);
      }
    }
  }
}
