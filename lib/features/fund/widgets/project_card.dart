import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/fund/models/projects.dart';
import 'package:stuverse/features/fund/routes/fund_routes.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
  });

  final Projects project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  // color: Theme.of(context).colorScheme.surfaceVariant,

                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: project.images,
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        );
                      },
                      imageUrl: project.images,
                      height: double.maxFinite,
                      width: double.maxFinite,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 35,
                  right: 35,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.primaryContainer),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  style: context.titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'By : ${project.user.name}',
                                  textAlign: TextAlign.center,
                                  style:
                                      context.textTheme.bodyMedium!.copyWith(),
                                ),
                                Text(
                                  'Target Amount : \$${project.targetAmount}',
                                  textAlign: TextAlign.center,
                                  style:
                                      context.textTheme.bodyMedium!.copyWith(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              icon: Icon(
                                Icons.chevron_right,
                                color: context.colorScheme.onSecondary,
                              ),
                              onPressed: () {
                                context.push(
                                  FundRoutes.projectDesc,
                                  extra: project,
                                );
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.secondary),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
