import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_oil_seekers/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:green_oil_seekers/sign_up_screen/verify_email_screen.dart';
import 'package:green_oil_seekers/sign_in_screen/email_text_field.dart';
import 'package:green_oil_seekers/sign_up_screen/phone_text_field.dart';
import 'package:green_oil_seekers/sign_up_screen/name_text_field.dart';
import 'package:green_oil_seekers/sign_up_screen/password_signup.dart';
import 'package:green_oil_seekers/sign_in_screen/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Global key to track and validate the form
  final _form = GlobalKey<FormState>();

  var _enteredName = '';
  var _enteredNameCompany = '';
  var _enteredPhone = '';
  var _enteredEmail = '';
  var _enteredPassword = '';
  bool _isLoading = false;

  // Function to handle account creation
  void _createAccount() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      try {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        await userCredential.user!.sendEmailVerification();

        await FirebaseFirestore.instance
            .collection('seeker')
            .doc(userCredential.user!.uid)
            .set({
          'Name': _enteredName.trim(),
          'Company Name': _enteredNameCompany.trim(),
          'Phone': _enteredPhone.trim(),
          'Email': _enteredEmail.trim(),
        });

        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const VerifyEmailScreen(),
            ),
          );
        }
      } on FirebaseAuthException catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message ?? 'Authentication failed.'),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false; // Stop loading
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Avoid bottom inset adjustments
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10), // Spacing at top

            // Logo image at top center
            Image.asset(
              "assets/icon/logo.png",
              width: 60,
            ),

            const SizedBox(height: 8),

            // Screen title
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            const SizedBox(height: 3),

            // Subtitle
            Text(
              "Be Recycled by join us today!",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            const SizedBox(height: 50), // Space before form

            // Sign-Up form with input fields
            Form(
              key: _form,
              child: Column(
                children: [
                  // Name input field
                  NameTextField(
                    label: 'Person Name (Required)',
                    onSaved: (newValue) {
                      _enteredName = newValue!;
                    },
                  ),
                  const SizedBox(height: 15),
                  NameTextField(
                    label: 'Company Name (Required)',
                    onSaved: (newValue) {
                      _enteredNameCompany = newValue!;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Phone number input field
                  PhoneTextField(
                    onSaved: (newValue) {
                      _enteredPhone = newValue!;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Email input field with label
                  EmailTextField(
                    label: 'Email Address (Required)',
                    onSaved: (newValue) {
                      _enteredEmail = newValue!;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Password input field with label
                  PasswordSignup(
                    onSaved: (newValue) {
                      _enteredPassword = newValue!;
                    },
                  ),
                ],
              ),
            ),

            const Spacer(), // Fills remaining space to push button to the bottom

            // Sign-Up button
            AuthButton(
              onPressed: _isLoading ? () {} : _createAccount,
              vertical: _isLoading ? 15 : 13,
              horizontal: _isLoading ? 165 : 139.7,
              child: _isLoading
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
            ),

            const SizedBox(height: 10),

            // Sign-in option with navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    // Navigate back to Sign-in screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
