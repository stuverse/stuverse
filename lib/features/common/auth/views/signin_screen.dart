import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'signup_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static const String routeName = '/signin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.replace(SignUpScreen.routeName);
              },
              child: Text('Go to Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
