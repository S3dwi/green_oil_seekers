import 'package:green_oil_seekers/auth_button.dart';
import 'package:green_oil_seekers/models/offer.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({
    super.key,
    required this.offer,
  });

  final Offer offer;

  @override
  State<StatefulWidget> createState() {
    return _InvoiceScreenState();
  }
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  bool _loading = false; // Default loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 38),
            Text(
              "Invoice",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 30,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 45),
            Card(
              elevation: 2,
              color: Theme.of(context).colorScheme.onPrimary,
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailItem(
                      'Invoice ID',
                      widget.offer.orderID
                          .substring(widget.offer.orderID.length - 10),
                      context,
                    ),
                    const Divider(),
                    buildDetailItem(
                      'Date of issue',
                      DateFormat('MMMM d, y').format(DateTime.now()),
                      context,
                    ),
                    const Divider(),
                    buildDetailItem(
                      'Contact Details',
                      'greenOil@gmail.com',
                      context,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2,
              color: Theme.of(context).colorScheme.onPrimary,
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailItem(
                        'Oil Type', getOrderType(widget.offer), context),
                    const Divider(),
                    buildDetailItem(
                      'Customer Name',
                      widget.offer.customerInfo.name,
                      context,
                    ),
                    const Divider(),
                    buildDetailItem(
                      'Company Name',
                      widget.offer.customerInfo.companyName,
                      context,
                    ),
                    const Divider(),
                    buildDetailItem(
                      'Estimated Quantity',
                      '${widget.offer.oilQuantity.toStringAsFixed(1)}L',
                      context,
                    ),
                    const Divider(),
                    buildDetailItem(
                      'Oil Price',
                      '${widget.offer.oilPrice.toStringAsFixed(1)} SR',
                      context,
                    ),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              widget.offer.customerInfo.providerEmail,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Seeker Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          Expanded(
                            child: Text(
                              widget.offer.customerInfo.seekerEmail,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            AuthButton(
              onPressed: _loading
                  ? () {}
                  : () async {
                      await _generateInvoicePDF(context);
                    },
              vertical: _loading ? 15 : 13,
              horizontal: _loading ? 165 : 89.7,
              child: _loading
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Text(
                      'SHARE INVOICE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDetailItem(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateInvoicePDF(BuildContext context) async {
    final pdf = pw.Document();

    setState(() {
      _loading = true;
    });

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Text(
                'Invoice',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              _buildPDFSection(
                'Invoice ID',
                widget.offer.orderID
                    .substring(widget.offer.orderID.length - 10),
              ),
              _buildPDFSection(
                'Date of issue',
                DateFormat('MMMM d, y').format(DateTime.now()),
              ),
              _buildPDFSection(
                'Contact Details',
                'greenOil@gmail.com',
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Order Details',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              _buildPDFSection(
                'Oil Type',
                getOrderType(widget.offer),
              ),
              _buildPDFSection(
                'Customer Name',
                widget.offer.customerInfo.name,
              ),
              _buildPDFSection(
                'Company Name',
                widget.offer.customerInfo.companyName,
              ),
              _buildPDFSection(
                'Estimated Quantity',
                '${widget.offer.oilQuantity.toStringAsFixed(1)}L',
              ),
              _buildPDFSection(
                'Oil Price',
                '${widget.offer.oilPrice.toStringAsFixed(1)} SR',
              ),
              _buildPDFSection(
                'Customer Email',
                widget.offer.customerInfo.providerEmail,
              ),
              _buildPDFSection(
                'Seeker Email',
                widget.offer.customerInfo.seekerEmail,
              ),
            ],
          );
        },
      ),
    );
    try {
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: 'invoice ${widget.offer.orderID.substring(
          widget.offer.orderID.length - 10,
        )}.pdf',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate PDF: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false; // Stop loading
        });
      }
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

String getOrderType(Offer offer) {
  if (offer.oilType == OilType.cookingOil) {
    return "Cooking Oil";
  } else if (offer.oilType == OilType.motorOil) {
    return "Motor Oil";
  } else if (offer.oilType == OilType.lubricating) {
    return "Lubricating Oil";
  } else {
    return "ERROR";
  }
}
