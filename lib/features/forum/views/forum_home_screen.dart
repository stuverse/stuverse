import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

import '../widgets/community/community_mini_card.dart';

class ForumHomeScreen extends StatefulWidget {
  const ForumHomeScreen({super.key});

  @override
  State<ForumHomeScreen> createState() => _ForumHomeScreenState();
}

class _ForumHomeScreenState extends State<ForumHomeScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController;
  @override
  void initState() {
    context.read<ForumHomeCubit>().getHomeData();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BgGradient(
      child: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              onTap: (value) {
                context.read<ForumHomeCubit>().getHomeData();
              },
              tabs: const [
                Tab(
                  text: "Threads",
                ),
                Tab(
                  text: "Communites",
                ),
              ],
            ),
            Expanded(
              child: BlocConsumer<ForumHomeCubit, ForumHomeState>(
                listener: (context, state) {
                  if (state is ForumHomeError) {
                    context.showErrorMessage(
                      message: state.message,
                      duration: 3.seconds,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ForumHomeLoaded) {
                    return RefreshIndicator.adaptive(
                      onRefresh: () async {
                        context.read<ForumHomeCubit>().getHomeData();
                      },
                      child: TabBarView(controller: _tabController, children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              20.heightBox,
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
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              _getTitleRow(
                                title: "Popular Communities",
                                onSeeAll: () {},
                              ),
                              _getCommunityView(state.popularCommunities),
                              _getTitleRow(
                                title: "Your Communities",
                                onSeeAll: () {},
                              ),
                              _getCommunityView(state.yourCommunities),
                            ],
                          ),
                        ),
                      ]),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _getCommunityView(List<Community> communities) {
    return SizedBox(
      key: UniqueKey(),
      height: 230,
      child: PageView.builder(
        key: UniqueKey(),
        scrollDirection: Axis.horizontal,
        itemCount: (communities.length / 2).ceil(),
        controller: PageController(
          viewportFraction: 0.92,
          initialPage: 0,
        ),
        itemBuilder: (context, index) {
          final int firstIndex = index * 2; // Adjust the index to skip pages
          final int secondIndex = firstIndex + 1;
          final bool hasNextCommunity = secondIndex < communities.length;

          return Column(
            key: UniqueKey(),
            children: [
              BlocProvider(
                key: UniqueKey(),
                create: (context) => CommunityManageCubit(),
                child: CommunityMiniCard(
                  key: UniqueKey(),
                  community: communities[firstIndex],
                ),
              ),
              10.heightBox,
              if (hasNextCommunity)
                BlocProvider(
                  key: UniqueKey(),
                  create: (context) => CommunityManageCubit(),
                  child: CommunityMiniCard(
                    key: UniqueKey(),
                    community: communities[secondIndex],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Row _getTitleRow({
    required String title,
    required VoidCallback onSeeAll,
  }) {
    return Row(
      children: [
        Padding(
          padding: context.paddingHorz,
          child: Text(
            title,
            style: context.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        Spacer(),
        //see all text button
        TextButton(
          onPressed: onSeeAll,
          style: TextButton.styleFrom(
            textStyle: context.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          child: Text(
            "See All",
          ),
        ),
      ],
    );
  }
}
