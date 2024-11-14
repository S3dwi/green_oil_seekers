import 'package:flutter/material.dart';
import 'package:green_oil_seekers/primary_button.dart';
import 'package:green_oil_seekers/sign_in_screen/sign_in_screen.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/email.png",
              height: 200,
            ),
            const SizedBox(height: 40),
            Text(
              'Please check your email for the verification link.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              onPressed: () {
                // Send verification email here
                // FirebaseAuth.instance.currentUser?.sendEmailVerification();
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => SignInScreen(),
                //   ),
                // );
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: 'Resend Email',
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {
                //Navigate to Sign In screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              },
              child: Text(
                "BACK TO SIGN IN",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.primary,
                  shadows: [
                    Shadow(
                      color: Theme.of(context).colorScheme.primary,
                      // Match background color to create "gap"
                      offset: const Offset(0, -5),
                      // Adjust vertical offset to control space
                    ),
                  ],
                  decorationThickness: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
