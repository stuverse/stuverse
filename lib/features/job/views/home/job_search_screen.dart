import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/job/cubit/search/job_search_cubit.dart';
import 'package:stuverse/features/job/widgets/job_list_tile.dart';

import '../../cubit/home/job_home_cubit.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final _searchController = TextEditingController();
  int _choiceIndex = 0;
  List jobChoices = ["On-site", "Remote", "Hybrid"];
  @override
  void initState() {
    context.read<JobSearchCubit>().searchJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Jobs"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BgGradient(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: 'jobSearch',
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              context
                                  .read<JobSearchCubit>()
                                  .searchJobs(search: value);
                            },
                            controller: _searchController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search jobs here.....',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        10.widthBox,
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Select Your Choices"),
                                    content: StatefulBuilder(
                                      builder: (context, setState) {
                                        return Wrap(
                                          spacing: 10,
                                          runSpacing: 6.0,
                                          children: List.generate(
                                            jobChoices.length,
                                            (index) {
                                              return ChoiceChip(
                                                selectedColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryContainer,
                                                label: Text(jobChoices[index]),
                                                selected: _choiceIndex == index,
                                                onSelected: (value) {
                                                  setState(() =>
                                                      _choiceIndex = index);
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Okay",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: context.colorScheme.primaryContainer,
                            ),
                            child: Icon(
                              Icons.sort,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<JobSearchCubit, JobSearchState>(
                    builder: (context, state) {
                  if (state is JobSearchSuccess) {
                    return Column(
                      children: [
                        for (final post in state.postList)
                          JobListTile(post: post)
                      ],
                    );
                  }
                  if (state is JobSearchInitial) {
                    return const Center(
                      child: Text("Search for jobs"),
                    );
                  }
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                }),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
