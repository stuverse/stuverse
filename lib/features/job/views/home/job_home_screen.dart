import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/job/cubit/add_edit/manage_job_cubit.dart';
import 'package:stuverse/features/job/job.dart';

import '../../cubit/home/job_home_cubit.dart';
import '../../widgets/job_list_tile.dart';

class JobHomeScreen extends StatefulWidget {
  const JobHomeScreen({super.key});

  @override
  State<JobHomeScreen> createState() => _JobHomeScreenState();
}

class _JobHomeScreenState extends State<JobHomeScreen> {
  @override
  void initState() {
    context.read<JobHomeCubit>().getJobHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BgGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: getMainAppbar(actions: [
          IconButton(
            onPressed: () {
              context.push(JobRoutes.jobAddEdit);
            },
            icon: const Icon(Icons.add),
          ),
        ]),
        body: BlocListener<ManageJobCubit, ManageJobState>(
          listener: (context, state) {
            if (state is ManageJobSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));

              context.read<JobHomeCubit>().getJobHomeData();

              context.go(JobRoutes.jobHome);
            }
            if (state is ManageJobError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          child: SafeArea(
            child: Padding(
              padding: context.paddingHorzWithTop,
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<JobHomeCubit>().getJobHomeData();
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: BlocConsumer<JobHomeCubit, JobHomeState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is JobHomeSuccess) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Find Your Dream',
                                      style: context.headlineLarge!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  Text('Job With Us ',
                                      style: context.headlineLarge!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              20.heightBox,
                              BannerCard(
                                title: 'AI Pick✨',
                                description:
                                    'Let AI pick a job for you based on your skills and experience',
                                buttonText: "Pick for me",
                                onTap: () {
                                  context.push(JobRoutes.jobAiSearch);
                                },
                              ),
                              10.heightBox,
                              Material(
                                child: InkWell(
                                  onTap: () {
                                    context.push(JobRoutes.jobSearch);
                                  },
                                  child: IgnorePointer(
                                    ignoring: true,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search),
                                        hintText: 'Search jobs here.....',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              10.heightBox,
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer
                                    .withOpacity(0.3),
                                elevation: 5,
                                child: ListTile(
                                    onTap: () {
                                      context.push(JobRoutes.jobMaterials);
                                    },
                                    leading: Icon(
                                      Icons.article_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                    ),
                                    title: Text(
                                      'Explore Materials',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      'Explore job materials to prepare for your dream job, interviews, and more.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                    )),
                              ),
                              10.heightBox,
                              Row(
                                children: [
                                  Text(
                                    'Featured Jobs',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Spacer(),
                                  TextButton.icon(
                                    onPressed: () {
                                      context.push(JobRoutes.jobSearch);
                                    },
                                    label: Text(
                                      'Show all',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                    ),
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Column(children: [
                                for (var post in state.latestJobs)
                                  JobListTile(post: post),
                              ]),
                              Row(
                                children: [
                                  Text(
                                    'Best Internship Jobs',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Spacer(),
                                  TextButton.icon(
                                    onPressed: () {
                                      context.push(JobRoutes.jobSearch);
                                    },
                                    label: Text(
                                      'Show all',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                    ),
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Column(children: [
                                for (var post in state.bestInternships)
                                  JobListTile(post: post),
                              ]),
                            ].defaultListAnimation(),
                          );
                        }
                        return Center(
                          child: LinearProgressIndicator(),
                        );
                      }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
