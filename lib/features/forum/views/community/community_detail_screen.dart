import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/forum/views/thread/thread_add_edit_screen.dart';

import '../../widgets/community/community_mini_card.dart';

class CommunityDetailScreen extends StatefulWidget {
  const CommunityDetailScreen({super.key, required this.communityId});

  final int? communityId;

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  late final User? user;
  bool isMember = false;
  bool isModerator = false;
  @override
  void initState() {
    if (widget.communityId != null)
      context.read<CommunityDetailCubit>().getCommunity(
            communityId: widget.communityId!,
          );
    else
      context.go(CommonRoutes.notFound);

    user = context.read<CoreCubit>().state.user;

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradient(
        child: BlocConsumer<CommunityDetailCubit, CommunityDetailState>(
          listenWhen: (previous, current) {
            return previous.communityStatus != current.communityStatus;
          },
          buildWhen: (previous, current) {
            return previous.communityStatus != current.communityStatus;
          },
          listener: (context, state) {
            if (state.communityStatus == APIStatus.success) {
              log("message: ${state.community?.name}");
              if (user != null) {
                isModerator =
                    state.community!.moderators!.contains(user?.id ?? -1);
                isMember = state.community!.members!.contains(user?.id ?? -1);
                setState(() {});
              }
            }

            if (state.community == APIStatus.error) {
              context.showMessage(
                message: state.message ?? "Error fetching community",
              );
            }
          },
          builder: (context, state) {
            if (state.communityStatus == APIStatus.success) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: true,
                    centerTitle: true,
                    title: Text(state.community?.name ?? ""),
                    expandedHeight: 200,
                    leading: IconButton(
                      onPressed: () {
                        context.canPop()
                            ? context.pop()
                            : context.go(ForumRoutes.forumHome);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: [StretchMode.blurBackground],
                      background: CachedNetworkImage(
                        placeholder: (context, url) {
                          return Container(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          );
                        },
                        imageUrl: state.community?.image ?? "",
                        fit: BoxFit.cover,
                        color: context.theme.brightness == Brightness.dark
                            ? context.colorScheme.tertiary.withOpacity(0.7)
                            : context.colorScheme.background.withOpacity(0.5),
                        colorBlendMode:
                            context.theme.brightness == Brightness.dark
                                ? BlendMode.darken
                                : BlendMode.lighten,
                      ),
                    ),
                    actions: [
                      // Share
                      IconButton(
                        onPressed: () {
                          Share.share(
                              "Join this community on Stuverse: ${state.community?.name}\n${state.community?.description}\nJoin now: ${baseUrl + COMMUNITY_JOIN_LINK_DEEP.replaceFirst("<id>", state.community?.id.toString() ?? "NA")}",
                              subject: 'Join this community');
                        },
                        icon: const Icon(Icons.share),
                      ),
                      if (user != null &&
                          (state.community!.moderators?.contains(user!.id) ??
                              false))
                        PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) {
                            return [
                              // if (isModerator)

                              PopupMenuItem(
                                child: Text("Add Thread"),
                                onTap: () {
                                  context.push(
                                    ForumRoutes.threadAddEdit,
                                    extra: ThreadAddEditScreenProps(
                                        communityId: state.community!.id!),
                                  );
                                },
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  context.push(
                                      ForumRoutes.communityMembersManageScreen,
                                      extra: state.community!.id!);
                                },
                                child: Text("Manage Members"),
                              ),
                            ];
                          },
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
                                community: state.community!,
                                isDetail: true,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: context.paddingHorz,
                          child: BlocConsumer<CommunityDetailCubit,
                              CommunityDetailState>(
                            listenWhen: (previous, current) {
                              return previous.threadsStatus !=
                                  current.threadsStatus;
                            },
                            buildWhen: (previous, current) {
                              return previous.threadsStatus !=
                                  current.threadsStatus;
                            },
                            listener: (context, state) {
                              if (state.threadsStatus == APIStatus.error) {
                                context.showMessage(
                                  message:
                                      state.message ?? "Error fetching threads",
                                );
                              }
                            },
                            builder: (context, state) {
                              return getThreadUI(state);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget getThreadUI(CommunityDetailState state) {
    if (state.threadsStatus == APIStatus.success) {
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
            color: context.colorScheme.onBackground.withOpacity(0.1),
          );
        },
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
