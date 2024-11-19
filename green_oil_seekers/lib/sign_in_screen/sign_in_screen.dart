import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_oil_seekers/auth_button.dart';

import 'package:green_oil_seekers/nav_bar.dart';
import 'package:green_oil_seekers/sign_in_screen/email_text_field.dart';
import 'package:green_oil_seekers/sign_in_screen/forgot_password_screen.dart';
import 'package:green_oil_seekers/sign_in_screen/password_sigin.dart';
import 'package:green_oil_seekers/sign_up_screen/sign_up_screen.dart';
import 'package:green_oil_seekers/sign_up_screen/verify_email_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Global key to track and validate the form
  final _form = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';
  bool _isLoading = false;

  // Function to handle SignIn
  void _signIn() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      try {
        final userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        // Force reload to update verification status
        await userCredential.user?.reload();
        final user = FirebaseAuth.instance.currentUser;

        if (user != null && user.emailVerified) {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const NavBar(wantedPage: 0),
              ),
            );
          }
        } else {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const VerifyEmailScreen(),
              ),
            );
          }
        }
      } on FirebaseAuthException catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? 'Authentication failed.')),
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
      resizeToAvoidBottomInset: false, // Prevents resizing on keyboard open
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40), // Space at top

            // Logo image at top center
            Image.asset(
              "assets/icon/logo.png",
              width: 60,
            ),

            const SizedBox(height: 8),

            // Title text
            Text(
              "Sign in",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            const SizedBox(height: 3),

            // Subtitle or welcoming text
            Text(
              "Be Recycled by join us today!",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            const SizedBox(height: 50),

            // Sign-In form with input fields
            Form(
              key: _form,
              child: Column(
                children: [
                  // Email input field
                  EmailTextField(
                    label: 'Email Address',
                    onSaved: (newValue) {
                      _enteredEmail = newValue!;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Password input field
                  PasswordSigin(
                    onSaved: (newValue) {
                      _enteredPassword = newValue!;
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // "Forgot Password" option
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Add forgot password logic here
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Sign-in button
            AuthButton(
              onPressed: _isLoading ? () {} : _signIn,
              vertical: _isLoading ? 15 : 13,
              horizontal: _isLoading ? 165 : 145,
              child: _isLoading
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            // "Sign Up" option if the user doesn't have an account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t Have an account?",
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    // Navigate to the Sign-Up screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign up",
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
