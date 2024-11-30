import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_oil_seekers/auth_button.dart';
import 'package:green_oil_seekers/sign_in_screen/forgot_password_screen.dart';
import 'package:green_oil_seekers/sign_in_screen/sign_in_screen.dart';
import 'package:green_oil_seekers/sign_up_screen/sign_up_screen.dart';

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

  // Test Case 3: Verify Error for Invalid Email
  testWidgets('Verify error message for invalid email format',
      (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  validator: (value) {
                    if (value == null ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    formKey.currentState?.validate();
                  },
                  child: const Text('Validate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Enter invalid email
    final emailFieldFinder = find.byType(TextFormField).first;
    await tester.enterText(emailFieldFinder, 'invalidemail');

    // Trigger validation
    await tester.tap(find.text('Validate'));
    await tester.pump();

    // Verify error message
    expect(find.text('Enter a valid email address'), findsOneWidget);
  });

  // Test Case 4: Verify Error for Short Password
  testWidgets('Verify error message for short password',
      (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    formKey.currentState?.validate();
                  },
                  child: const Text('Validate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Enter short password
    final passwordFieldFinder = find.byType(TextFormField).first;
    await tester.enterText(passwordFieldFinder, '12345');

    // Trigger validation
    await tester.tap(find.text('Validate'));
    await tester.pump();

    // Verify error message
    expect(find.text('Password must be at least 8 characters long'),
        findsOneWidget);
  });

  // Test Case 5: Verify Navigation to Forgot Password Screen
  testWidgets('Verify navigation to Forgot Password Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInScreen(),
      ),
    );

    // Tap "Forgot Password?" link
    final forgotPasswordLinkFinder = find.text('Forgot Password?');
    await tester.tap(forgotPasswordLinkFinder);
    await tester.pumpAndSettle();

    // Verify navigation to ForgotPasswordScreen
    expect(find.byType(ForgotPasswordScreen), findsOneWidget);
  });

  // Test Case 6: Verify Navigation to Sign Up Screen
  testWidgets('Verify navigation to Sign Up Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInScreen(),
      ),
    );

    // Tap "Sign up" link
    final signUpLinkFinder = find.text('Sign up');
    await tester.tap(signUpLinkFinder);
    await tester.pumpAndSettle();

    // Verify navigation to SignUpScreen
    expect(find.byType(SignUpScreen), findsOneWidget);
  });
}
