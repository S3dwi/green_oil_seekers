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
  final _form = GlobalKey<FormState>();

  var _enteredName = '';
  var _enteredNameCompany = '';
  var _enteredPhone = '';
  var _enteredEmail = '';
  var _enteredPassword = '';
  bool _isLoading = false;

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
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allow scrolling on smaller screens
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20), // Space at top

                // Logo
                Image.asset(
                  "assets/icon/logo.png",
                  width: 60,
                ),

                const SizedBox(height: 10),

                // Title
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),

                const SizedBox(height: 5),

                // Subtitle
                Text(
                  "Be Recycled by join us today!",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),

                const SizedBox(height: 40), // Space before form

                // Sign-up Form
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      // Name Field
                      NameTextField(
                        label: 'Person Name (Required)',
                        onSaved: (newValue) {
                          _enteredName = newValue!;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Company Name Field
                      NameTextField(
                        label: 'Company Name (Required)',
                        onSaved: (newValue) {
                          _enteredNameCompany = newValue!;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Phone Field
                      PhoneTextField(
                        onSaved: (newValue) {
                          _enteredPhone = newValue!;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Email Field
                      EmailTextField(
                        label: 'Email Address (Required)',
                        onSaved: (newValue) {
                          _enteredEmail = newValue!;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Password Field
                      PasswordSignup(
                        onSaved: (newValue) {
                          _enteredPassword = newValue!;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Sign Up Button
                AuthButton(
                  onPressed: _isLoading ? (){} : _createAccount,
                  vertical: 13,
                  horizontal: 140,
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

                const SizedBox(height: 20),

                // Navigate to Sign In
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
        ),
      ),
    );
  }
}
