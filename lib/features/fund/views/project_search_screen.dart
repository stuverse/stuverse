import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/fund/widgets/project_card.dart';

import '../cubit/home/fund_home_cubit.dart';

class ProjectSearchScreen extends StatefulWidget {
  const ProjectSearchScreen({super.key});

  @override
  State<ProjectSearchScreen> createState() => _ProjectSearchScreenState();
}

class _ProjectSearchScreenState extends State<ProjectSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Projects"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BgGradient(
        child: Column(
          children: [
            130.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                onChanged: (value) {
                  context.read<FundHomeCubit>().getProjects(
                        search: value,
                      );
                },
                decoration: InputDecoration(
                  hintText: "Search projects",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FundHomeCubit, FundHomeState>(
              builder: (context, state) {
                if (state is FundHomeInitial) {
                  return Expanded(
                    child: Column(
                      children: [
                        Center(
                            child: Image.asset(
                          AppImages.fundraisingOnboarding,
                          height: context.height * 0.5,
                        )),
                        const Center(
                            child: Text(
                          "Search for projects",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ],
                    ),
                  );
                }
                if (state is FundHomeSuccess) {
                  return Expanded(
                      child: Column(
                    children: [
                      for (final project in state.project)
                        ProjectCard(
                          project: project,
                        )
                    ],
                  ));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
