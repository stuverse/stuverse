import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final thread in state.threads)
                    Column(
                      children: [
                        Padding(
                          padding: context.paddingHorz,
                          child: ThreadCard(
                            thread: thread,
                          ),
                        ),
                        Divider()
                      ],
                    ),
                ].defaultListAnimation(),
              ),
            ),
          ),
          orElse: () => Skeletonizer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var i = 0; i < 5; i++)
                    Column(
                      children: [
                        Padding(
                          padding: context.paddingHorz,
                          child: ThreadCard(
                            thread: Thread(
                              id: 0,
                              title: 'This is' * (i.isEven ? 1 : 2),
                              author: ThreadAuthor(
                                id: 0,
                                username: 'basha',
                                email: '',
                                image: '',
                              ),
                              content: 'This is' * (i.isEven ? 6 : 2),
                              community: ThreadCommunity(
                                id: 0,
                                name: 'test',
                                image: '',
                              ),
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                              tags: [],
                              image: i.isOdd
                                  ? 'https://picsum.photos/200/300'
                                  : null,
                            ),
                          ),
                        ),
                        Divider()
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
