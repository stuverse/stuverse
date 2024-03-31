import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/job/cubit/search/job_search_cubit.dart';
import 'package:stuverse/features/job/models/job_post.dart';
import 'package:stuverse/features/job/widgets/job_list_tile.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final _searchController = TextEditingController();

  List jobLocationChoices = [
    JOB_LOCATION_TYPE.HYBRID,
    JOB_LOCATION_TYPE.ONSITE,
    JOB_LOCATION_TYPE.REMOTE,
  ];
  List jobTypeChoices = [
    JOB_TYPE.CONTRACT,
    JOB_TYPE.FULL_TIME,
    JOB_TYPE.INTERNSHIP,
    JOB_TYPE.PART_TIME,
    JOB_TYPE.TEMPORARY,
  ];

  String? selectedLocation;
  String? selectedType;
  @override
  void initState() {
    getJobs();
    super.initState();
  }

  void getJobs() {
    context.read<JobSearchCubit>().searchJobs(
          search: _searchController.text,
          location: selectedLocation,
          type: selectedType,
        );
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          getJobs();
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
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text("Select Your Choices"),
                                    content:
                                        StatefulBuilder(builder: (context, sS) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Select Job Type",
                                                  style: context.titleMedium),
                                              Spacer(),
                                              TextButton.icon(
                                                onPressed: () {
                                                  setState(() {
                                                    selectedType = null;
                                                  });
                                                  sS(() {});
                                                  getJobs();
                                                },
                                                icon: const Icon(Icons.clear),
                                                label: const Text("Clear"),
                                              ),
                                            ],
                                          ),
                                          Wrap(
                                            spacing: 10,
                                            runSpacing: 6.0,
                                            children: List.generate(
                                              jobTypeChoices.length,
                                              (index) {
                                                return ChoiceChip(
                                                  selectedColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .tertiaryContainer,
                                                  label: Text(
                                                      jobTypeChoices[index]),
                                                  selected: selectedType ==
                                                      jobTypeChoices[index],
                                                  onSelected: (value) {
                                                    setState(() =>
                                                        selectedType =
                                                            jobTypeChoices[
                                                                index]);
                                                    sS(() {});
                                                    getJobs();
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text("Select Job Location",
                                                  style: context.titleMedium),
                                              Spacer(),
                                              TextButton.icon(
                                                onPressed: () {
                                                  setState(() {
                                                    selectedLocation = null;
                                                  });
                                                  sS(() {});
                                                  getJobs();
                                                },
                                                icon: const Icon(Icons.clear),
                                                label: const Text("Clear"),
                                              ),
                                            ],
                                          ),
                                          Wrap(
                                            spacing: 10,
                                            runSpacing: 6.0,
                                            children: List.generate(
                                              jobLocationChoices.length,
                                              (index) {
                                                return ChoiceChip(
                                                  selectedColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .tertiaryContainer,
                                                  label: Text(
                                                      jobLocationChoices[
                                                          index]),
                                                  selected: selectedLocation ==
                                                      jobLocationChoices[index],
                                                  onSelected: (value) {
                                                    setState(() =>
                                                        selectedLocation =
                                                            jobLocationChoices[
                                                                index]);
                                                    sS(() {});
                                                    getJobs();
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text(
                                          "Okay",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
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
                        if (selectedType != null || selectedLocation != null)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  ((selectedType != null ? 1 : 0) +
                                          (selectedLocation != null ? 1 : 0))
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
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
