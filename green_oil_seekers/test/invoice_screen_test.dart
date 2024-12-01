import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';

import 'package:green_oil_seekers/models/offer.dart';

import 'package:green_oil_seekers/schedule_screen/invoice_screen.dart';

void main() {
  testWidgets('Render InvoiceScreen UI', (WidgetTester tester) async {
    final sampleOffer = Offer(
      orderID: '1234567890',
      oilType: OilType.motorOil,
      oilQuantity: 15.0,
      oilPrice: 75.0,
      arrivalDate: DateTime.now(),
      orderStatus: OrderStatus.completed,
      customerInfo: CustomerInfo(
        name: 'John Doe',
        companyName: 'Green Company',
        phoneNumber: '1234567890',
        image: '',
        providerEmail: 'provider@example.com',
        seekerEmail: 'seeker@example.com',
      ),
      location: Location(
        latitude: 21.3333442,
        longitude: 39.3093763,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(home: InvoiceScreen(offer: sampleOffer)),
    );

    // Verify UI elements

    expect(find.text('Invoice ID'), findsOneWidget);

    expect(find.textContaining('1234567890'), findsOneWidget);

    expect(find.text('Order Details'), findsOneWidget);

    expect(find.text('SHARE INVOICE'), findsOneWidget);
  });

  testWidgets('Generate Invoice PDF', (WidgetTester tester) async {
    final sampleOffer = Offer(
      orderID: '1234567890',
      oilType: OilType.motorOil,
      oilQuantity: 15.0,
      oilPrice: 75.0,
      arrivalDate: DateTime.now(),
      orderStatus: OrderStatus.completed,
      customerInfo: CustomerInfo(
        name: 'John Doe',
        companyName: 'Green Company',
        phoneNumber: '1234567890',
        image: '',
        providerEmail: 'provider@example.com',
        seekerEmail: 'seeker@example.com',
      ),
      location: Location(
        latitude: 21.3333442,
        longitude: 39.3093763,
      ),
    );
    await tester.pumpWidget(
      MaterialApp(home: InvoiceScreen(offer: sampleOffer)),
    );

    // Access the state of InvoiceScreen

    final state = tester.state<InvoiceScreenState>(
      find.byType(InvoiceScreen),
    );
    // Mock Printing.sharePdf

    await tester.runAsync(() async {
      try {
        await state
            .generateInvoicePDF(tester.element(find.byType(InvoiceScreen)));
      } catch (e) {
        fail('PDF generation failed with error: $e');
      }
    });

    // Verify loading state changes
    expect(state.loading, false);
  });
}
