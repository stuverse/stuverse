// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

import '../../models/job_post.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key, required this.post});
  final JobPost post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 200,
                            width: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(),
                                image: DecorationImage(
                                    image: NetworkImage(post.image),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            post.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "${post.companyName} - ${post.place}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      )),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.business_center,
                                size: 25,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text("${post.jobType} - ${post.jobLocationType}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider(),
                      const SizedBox(height: 5),
                      CustomMarkdownBody(inputText: post.description),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  context.push(CommonRoutes.webView, extra: post.url);
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
                  foregroundColor: Theme.of(context).colorScheme.onBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
