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
