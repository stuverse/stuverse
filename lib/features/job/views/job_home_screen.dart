import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/job/job.dart';

import '../cubit/home/job_home_cubit.dart';
import '../widgets/job_list_tile.dart';

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
    return Scaffold(
      body: BgGradient(
        child: SafeArea(
          child: Padding(
            padding: context.paddingHorz,
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
                        final first3Posts = state.postList.take(3).toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Find Your Dream',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                    Text('Job With Us ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    context.push(JobRoutes.jobAddEdit);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    width: 55,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.3),
                                        border: Border.all()),
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Text(
                                  'Featured Jobs',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Spacer(),
                                TextButton.icon(
                                  onPressed: () {
                                    context.push(JobRoutes.jobSearch);
                                  },
                                  label: Text(
                                    'Show all',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
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
                              for (var post in first3Posts)
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
    );
  }
}
