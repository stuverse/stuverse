import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/fund/models/projects.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
  });

  final Projects project;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.maxFinite,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: project.images,
                child: Image.network(
                  project.images,
                  height: double.maxFinite,
                  width: double.maxFinite,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: context.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.5,
                  ),
                  Text(
                    'Target Amount',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '\$ ${project.targetAmount}',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
