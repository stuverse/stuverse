import 'package:flutter/material.dart';

class ForumHomeScreen extends StatelessWidget {
  const ForumHomeScreen({super.key});
  static const String routeName = '/forum';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(
        child: Text(
          'Forum Home Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
