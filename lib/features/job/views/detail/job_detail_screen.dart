// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/job/cubit/add_edit/manage_job_cubit.dart';
import 'package:stuverse/features/job/job.dart';

import '../../models/job_post.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key, required this.post});
  final JobPost post;

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  @override
  void initState() {
    context.read<SkillCubit>().getSkills();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Job details"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                context.push(
                  JobRoutes.jobAddEdit,
                  extra: widget.post,
                );
              },
              icon: const Icon(Icons.create_outlined),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete Job"),
                        content: const Text(
                            "Are you sure you want to delete this job?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context
                                  .read<ManageJobCubit>()
                                  .deleteJob(id: widget.post.id!);
                              context.go(JobRoutes.jobHome);
                            },
                            child: const Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("No"),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.delete_outline),
            )
          ]),
      extendBodyBehindAppBar: true,
      body: BgGradient(
        child: SafeArea(
          child: Padding(
            padding: context.paddingHorzWithTop,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: BlocConsumer<SkillCubit, SkillState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is SkillSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              widget.post.image ?? ""),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.post.title ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        "${widget.post.companyName} - ${widget.post.place}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color: context
                                                    .colorScheme.onBackground
                                                    .withOpacity(0.7)),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceVariant
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                            )),
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.business_center,
                                              size: 17,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                                "${CommonUtils.toTitleCase(widget.post.jobType ?? "")} - ${CommonUtils.toTitleCase(widget.post.jobLocationType ?? "")}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurfaceVariant)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                            const SizedBox(
                              height: 15,
                            ),
                            Divider(),
                            const SizedBox(height: 5),
                            Text(
                              "Skills Required:",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(
                                widget.post.skills?.length ?? 0,
                                (index) => Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      )),
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    widget.post.skills![index].name ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Job Description:",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            CustomMarkdownBody(
                                inputText: widget.post.description ?? ""),
                            100.heightBox
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: ElevatedButton(
                    onPressed: () async {
                      context.push(CommonRoutes.webView,
                          extra: widget.post.url);
                    },
                    child: Text(
                      "Apply Now",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(180, 50),
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
