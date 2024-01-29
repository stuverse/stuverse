import 'package:flutter/material.dart';

class MentorHomeScreen extends StatelessWidget {
  const MentorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(
        child: Text(
          'Mentor Home Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
