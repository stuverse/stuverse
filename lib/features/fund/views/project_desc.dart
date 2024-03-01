import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

class ProjectDescScreen extends StatefulWidget {
  const ProjectDescScreen({super.key});

  @override
  State<ProjectDescScreen> createState() => _ProjectDescScreenState();
}

class _ProjectDescScreenState extends State<ProjectDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradient(
          child: SafeArea(
              child: Padding(
        padding: const EdgeInsets.all(15),
      ))),
    );
  }
}
