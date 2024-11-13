import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  late PostgrestList senderData;
  late List<Sender> senders;

  late PostgrestList recipientData;
  late List<Recipient> recipients;

  late PostgrestList courseData;
  late List<Course> courses;

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

  Future<void> getInvoiceId() async {
    await supabase
    .from("invoices")
    .select("invoice_id");
  }


  //Insert Data Methods
  Future<void> insertInvoice() async {}

  Future<void> insertSender() async {}

  Future<void> insertRecipient() async {}

  Future<void> insertCourse() async {}
}
