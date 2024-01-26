import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'signin_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.replace(SignInScreen.routeName);
              },
              child: Text('Go to Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
