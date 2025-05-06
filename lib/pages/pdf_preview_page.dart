import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice_course.dart';
import 'package:markaz_umaza_invoice_generator/models/profile.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_generator.dart';
import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';
import 'package:markaz_umaza_invoice_generator/themes/my_themes.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends ConsumerWidget {
  PdfPreviewPage({
    super.key,
    required this.profile,
    this.receipt,
    required this.invoice,
    required this.sender,
    required this.recipient,
    required this.invoiceCourses,
  });

  final Profile profile;
  final Receipt? receipt;
  final Invoice invoice;
  final Sender sender;
  final Recipient recipient;
  final Map<int, InvoiceCourse> invoiceCourses;

  late AppTheme themeMode;

  Color? getTheme(BuildContext context, AppTheme themeMode, bool isInvoice) {
    switch (themeMode) {
      case AppTheme.light:
        return MyThemes.tertiaryLight;
      case AppTheme.dark:
        return Theme.of(context).appBarTheme.backgroundColor;
      default:
        return isInvoice ? MyThemes.primaryRed : MyThemes.primaryPurple;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    themeMode = ref.watch(themeProvider);
    bool isInvoice = receipt == null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getTheme(context, themeMode, isInvoice),
        title: const Text("PDF Preview"),
      ),
      body: PdfPreview(
          actionBarTheme: PdfActionBarTheme(
            height: 70,
            backgroundColor: getTheme(context, themeMode, isInvoice),
          ),
          build: (context) => PdfGenerator.generatePdf(
                profile: profile,
                receipt: receipt,
                invoice: invoice,
                sender: sender,
                recipient: recipient,
                invoiceCourses: invoiceCourses,
              )),
    );
  }
}
