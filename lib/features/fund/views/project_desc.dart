import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/fund/models/projects.dart';

class ProjectDescScreen extends StatefulWidget {
  const ProjectDescScreen({super.key, required this.project});

  final Projects project;

  @override
  State<ProjectDescScreen> createState() => _ProjectDescScreenState();
}

class _ProjectDescScreenState extends State<ProjectDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BgGradient(
          child: SafeArea(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Hero(
                tag: widget.project.images,
                child: Image.network(
                  widget.project.images,
                )),
          )
        ]),
      ))),
    );
  }
}
