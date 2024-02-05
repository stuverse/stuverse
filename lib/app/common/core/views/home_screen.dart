import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.read<CoreCubit>().state.user;
    return SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        state.mapOrNull(
          failure: (state) {
            context.showErrorMessage(message: state.message);
          },
        );
      },
      builder: (context, state) {
        return state.maybeMap(
          loaded: (state) => RefreshIndicator(
            onRefresh: () async {
              context.read<HomeCubit>().getHomeData();
            },
            child: ListView.separated(
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: context.paddingHorzWith(0.02),
                    child: ThreadCard(
                      thread: state.threads[index],
                    ),
                  );
                },
                separatorBuilder: (ctx, int) {
                  return Divider();
                },
                itemCount: state.threads.length),
          ),
          orElse: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    ));
  }
}
