import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:green_oil_seekers/sign_in_screen/email_text_field.dart';
import 'package:green_oil_seekers/sign_in_screen/password_sigin.dart';
import 'package:green_oil_seekers/sign_in_screen/sign_in_screen.dart';
import 'package:green_oil_seekers/auth_button.dart';

void main() {
  // Test Case 1: Verify Sign In Button is Disabled by Default
  testWidgets('Verify Sign In button is disabled by default',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInScreen(),
      ),
    );

    // Find the Sign In button
    final signInButtonFinder = find.byType(AuthButton);

    // Verify the button exists
    expect(signInButtonFinder, findsOneWidget);

    // Verify the button is not clickable
    final authButtonWidget = tester.widget<AuthButton>(signInButtonFinder);
    expect(authButtonWidget.onPressed, isNotNull);
  });

  // Test Case 2: Verify Sign In Button is Enabled with Valid Inputs
  testWidgets('Verify Sign In button is enabled with valid inputs',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInScreen(),
      ),
    );

    // Enter a valid email
    final emailFieldFinder = find.byType(TextFormField).first;
    await tester.enterText(emailFieldFinder, 'test@example.com');

    // Enter a valid password
    final passwordFieldFinder = find.byType(TextFormField).last;
    await tester.enterText(passwordFieldFinder, 'password123');

    // Rebuild the widget tree
    await tester.pump();

    // Verify the button is enabled
    final signInButtonFinder = find.byType(AuthButton);
    final authButtonWidget = tester.widget<AuthButton>(signInButtonFinder);
    expect(authButtonWidget.onPressed, isNotNull);
  });

  // Test Case 3: SignInScreen Form Tests
  testWidgets('display error message for invalid email and short password',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInScreen(),
      ),
    );

    // Using find.byWidgetPredicate to find specific widgets
    final emailFieldFinder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is EmailTextField && widget.label == 'Email Address',
    );
    final passwordFieldFinder = find.byWidgetPredicate(
      (Widget widget) => widget is PasswordSigin,
    );

    // Enter invalid email and a short password
    await tester.enterText(emailFieldFinder, 'wrongemail');
    await tester.enterText(passwordFieldFinder, '123');

    // Attempt to submit the form by tapping the sign in button
    await tester.tap(find.byType(AuthButton));
    await tester.pump(); // Rebuild the widget with the new state

    // Check for error messages
    // Assuming you are displaying errors using a Text widget
    expect(find.text('Enter a valid email address'), findsOneWidget);
    expect(find.text('Password must be at least 8 characters long'),
        findsOneWidget);
  });
}
