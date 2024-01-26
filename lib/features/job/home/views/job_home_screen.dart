import 'package:flutter/material.dart';

class JobHomeScreen extends StatelessWidget {
  const JobHomeScreen({super.key});
  static const String routeName = '/job';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(
        child: Text(
          'Job Home Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
