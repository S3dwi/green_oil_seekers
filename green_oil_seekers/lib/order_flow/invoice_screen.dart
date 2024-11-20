import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoiceScreen extends StatelessWidget {
  final String invoiceId;
  final String userEmail;
  final String customerName;
  final String oilType;
  final String companyName;
  final int quantity;
  final String customerContactInfo;
  final String companyContactInfo;
  final DateTime dateOfIssue;
  final String orderId;

  const InvoiceScreen({
    super.key,
    required this.invoiceId,
    required this.userEmail,
    required this.customerName,
    required this.oilType,
    required this.companyName,
    required this.quantity,
    required this.customerContactInfo,
    required this.companyContactInfo,
    required this.dateOfIssue,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Invoice',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/GreenOilLogo.png',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildDetailRow(context, 'Invoice ID', invoiceId),
                    _buildDivider(),
                    _buildDetailRow(
                        context, 'Date of issue', _formatDate(dateOfIssue)),
                    _buildDivider(),
                    _buildDetailRow(context, 'Contact Details', userEmail),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildDetailRow(context, 'Oil Type', oilType),
                    _buildDivider(),
                    _buildDetailRow(context, 'Customer Name', customerName),
                    _buildDivider(),
                    _buildDetailRow(context, 'Company Name', companyName),
                    _buildDivider(),
                    _buildDetailRow(
                        context, 'Estimated Quantity', '${quantity}L'),
                    _buildDivider(),
                    _buildDetailRow(
                        context, 'Customer Contact Info', customerContactInfo),
                    _buildDivider(),
                    _buildDetailRow(
                        context, 'Company Contact Info', companyContactInfo),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _generateInvoicePDF(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'SHARE INVOICE',
                style: TextStyle(color: colorScheme.onPrimary, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (label == 'Invoice ID') ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: invoiceId));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invoice ID copied')),
                  );
                },
                child: const Icon(Icons.copy, size: 16, color: Colors.grey),
              ),
            ]
          ],
        ),
      ],
    );
  }

  Divider _buildDivider() => Divider(color: Colors.grey.shade300);

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  Future<void> _generateInvoicePDF(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Text('Invoice',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              _buildPDFSection('Invoice ID', invoiceId),
              _buildPDFSection('Date of issue', _formatDate(dateOfIssue)),
              _buildPDFSection('Contact Details', userEmail),
              pw.SizedBox(height: 20),
              pw.Text('Order Details',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              _buildPDFSection('Oil Type', oilType),
              _buildPDFSection('Customer Name', customerName),
              _buildPDFSection('Company Name', companyName),
              _buildPDFSection('Estimated Quantity', '${quantity}L'),
              _buildPDFSection('Customer Contact Info', customerContactInfo),
              _buildPDFSection('Company Contact Info', companyContactInfo),
            ],
          );
        },
      ),
    );

    try {
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: 'invoice_$invoiceId.pdf',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate PDF: $e')),
      );
    }
  }

  pw.Widget _buildPDFSection(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('$label: $value', style: const pw.TextStyle(fontSize: 14)),
        pw.SizedBox(height: 4),
      ],
    );
  }
}
