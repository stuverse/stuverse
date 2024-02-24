import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

import '../../widgets/community/community_mini_card.dart';

class CommunityDetailScreen extends StatefulWidget {
  const CommunityDetailScreen({super.key, required this.community});

  final Community community;

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  @override
  void initState() {
    if (widget.community.id != null)
      context.read<CommunityDetailCubit>().getCommunityThreads(
            communityId: widget.community.id!,
          );

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradient(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              centerTitle: true,
              title: Text(widget.community.name ?? ""),
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [StretchMode.blurBackground],
                background: Image.network(
                  widget.community.image ?? "",
                  fit: BoxFit.cover,
                  color: context.theme.brightness == Brightness.dark
                      ? context.colorScheme.tertiary.withOpacity(0.7)
                      : context.colorScheme.background.withOpacity(0.5),
                  colorBlendMode: context.theme.brightness == Brightness.dark
                      ? BlendMode.darken
                      : BlendMode.lighten,
                ),
              ),
              actions: [
                // Share
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: context.paddingHorzWithTop,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommunityMiniCard(
                          community: widget.community,
                          isDetail: true,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    heightFactor: 0.8,
                    child: Padding(
                      padding: context.paddingHorz,
                      child: BlocBuilder<CommunityDetailCubit,
                          CommunityDetailState>(
                        builder: (context, state) {
                          if (state is CommunityDetailLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is CommunityDetailLoaded) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.threads.length,
                              itemBuilder: (context, index) {
                                return ThreadCard(
                                  thread: state.threads[index],
                                  isCommunityScreen: true,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: context.colorScheme.onBackground
                                      .withOpacity(0.1),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text("No threads found"),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
