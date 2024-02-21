import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/job/widgets/job_list_tile.dart';

import '../cubit/home/job_home_cubit.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Jobs"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  context.read<JobHomeCubit>().getJobHomeData(search: value);
                },
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search jobs here.....',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<JobHomeCubit, JobHomeState>(
                  builder: (context, state) {
                if (state is JobHomeSuccess) {
                  return Column(
                    children: [
                      for (final post in state.postList) JobListTile(post: post)
                    ],
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
    );
  }
}
