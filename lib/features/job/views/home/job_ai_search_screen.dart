import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:stuverse/app/app.dart';

import '../../cubit/ai_search/job_ai_search_cubit.dart';
import '../../widgets/job_list_tile.dart';

class JobAiSearchScreen extends StatefulWidget {
  const JobAiSearchScreen({super.key});

  @override
  State<JobAiSearchScreen> createState() => _JobAiSearchScreenState();
}

class _JobAiSearchScreenState extends State<JobAiSearchScreen> {
  late ConfettiController _controller;
  @override
  void initState() {
    super.initState();

    _controller = ConfettiController(duration: const Duration(seconds: 1));
    context.read<JobAiSearchCubit>().getBestJobsAI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Job Pick"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BgGradient(
        child: BlocConsumer<JobAiSearchCubit, JobAiSearchState>(
          listener: (context, state) {
            if (state is JobAiSearchSuccess) {
              if (state.result.bestJob != null) {
                _controller.play();
              }
            }
            if (state is JobAiSearchError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          builder: (context, state) {
            if (state is JobAiSearchSuccess) {
              if (state.result.bestJob == null) {
                return Padding(
                  padding: context.paddingHorzWithTop,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.jobPostingOnboarding,
                        height: context.height * 0.3,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        state.result.reason ?? "",
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: context.paddingHorzWithTop,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      130.heightBox,
                      Text(
                        state.result.reason ?? "",
                        style: context.textTheme.titleMedium,
                      ),
                      20.heightBox,
                      ConfettiWidget(
                          confettiController: _controller,
                          blastDirectionality: BlastDirectionality.explosive,
                          maxBlastForce: 25,
                          child: JobListTile(post: state.result.bestJob!)),
                    ],
                  ),
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  AppImages.aiLottie,
                  height: context.height * 0.3,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("AI Thinking...", style: context.textTheme.headlineMedium),
              ],
            );
          },
        ),
      ),
    );
  }
}
