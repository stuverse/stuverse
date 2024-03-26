import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/cubit/vote/vote_cubit.dart';
import 'package:stuverse/features/forum/forum.dart';

import '../../views/thread/thread_add_edit_screen.dart';

class ThreadCard extends StatelessWidget {
  const ThreadCard({
    super.key,
    required this.thread,
    this.isDetailScreen = false,
    this.isCommunityScreen = false,
    this.isSkeleton = false,
    this.commentFocusNode,
  });

  final Thread thread;
  final bool isDetailScreen;
  final FocusNode? commentFocusNode;
  final bool isCommunityScreen;
  final bool isSkeleton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isDetailScreen) {
          context.push(
            ForumRoutes.threadDetail.replaceFirst(":id", thread.id.toString()),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.5,
                backgroundColor:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                child: isSkeleton
                    ? null
                    : CircleAvatar(
                        radius: 18,
                        backgroundImage: CachedNetworkImageProvider(
                            isCommunityScreen
                                ? thread.author?.image ?? ""
                                : thread.community?.image ?? ""),
                      ),
              ),
              10.widthBox,
              if (isCommunityScreen)
                Text(
                  thread.author?.name ?? "",
                  style: context.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "t/${thread.community?.name}",
                      style: context.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${CommonUtils.getFirstLetter(thread.author?.type ?? "u")}/${thread.author?.username}",
                      style: context.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              Spacer(),
              Align(
                heightFactor: 0.8,
                alignment: Alignment.bottomCenter,
                child: Text(
                  CommonUtils.relativeTime(thread.updatedAt),
                  style: context.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              5.widthBox,
              PopupMenuButton(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("Edit"),
                    value: "edit",
                    onTap: () {
                      context.push(
                        ForumRoutes.threadAddEdit,
                        extra: ThreadAddEditScreenProps(
                          thread: thread,
                          communityId: thread.community!.id!,
                        ),
                      );
                    },
                  ),
                ];
              }),
            ],
          ),
          10.heightBox,
          Text(
            thread.title ?? "",
            style: context.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          5.heightBox,
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(
              min(thread.tags!.length, 3),
              (index) => ThreadTagChip(tag: thread.tags![index]),
            ),
          ),
          5.heightBox,
          if (thread.content != null && thread.content!.isNotEmpty)
            Text(
              thread.content!,
              style: context.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          if (thread.content != null && thread.content!.isNotEmpty) 5.heightBox,
          if (thread.image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: isSkeleton
                  ? Container(
                      width: double.infinity,
                      height: context.minSize * 0.8,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.1),
                    )
                  : CachedNetworkImage(
                      placeholder: (context, url) {
                        return Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        );
                      },
                      imageUrl: thread.image!,
                      width: double.infinity,
                      height: context.minSize * 0.8,
                      fit: BoxFit.cover,
                    ),
            ),
          10.heightBox,
          Row(
            children: [
              BlocProvider<VoteCubit>(
                create: (context) => VoteCubit(),
                child: VoteChip(
                  vote: thread.vote,
                  threadId: thread.id!,
                ),
              ),
              10.widthBox,
              ChoiceChip(
                onSelected: (value) {
                  if (isDetailScreen) {
                    commentFocusNode?.requestFocus();
                  } else {
                    context.push(ForumRoutes.threadDetail, extra: thread);
                  }
                },
                selected: false,
                side: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.2),
                  width: 0.5,
                ),
                label: Row(
                  children: [
                    SvgPicture.asset(
                      ForumImages.commentSVG,
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onBackground,
                          BlendMode.srcIn),
                    ),
                    5.widthBox,
                    Text(
                      CommonUtils.formatNumberEnglish(
                        thread.commentsCount ?? 0,
                      ),
                      style: context.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ).onTap(() => {
                    if (isDetailScreen)
                      {
                        commentFocusNode?.requestFocus(),
                      }
                  }),
              Spacer(),
              Chip(
                side: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.2),
                  width: 0.5,
                ),
                label: Row(
                  children: [
                    SvgPicture.asset(
                      ForumImages.shareSVG,
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onBackground,
                          BlendMode.srcIn),
                    ),
                    // 5.widthBox,
                    // Text(
                    //   CommonUtils.formatNumberEnglish(
                    //     thread.shareCount ?? 0,
                    //   ),
                    //   style: context.bodyMedium!.copyWith(
                    //     color: Theme.of(context).colorScheme.onBackground,
                    //   ),
                    // ),
                  ],
                ),
              ).onTap(
                () => Share.share(
                  "See this thread on Stuverse🤩: ${thread.title}\n${thread.content}\n${baseUrl + THREAD_DETAIL_LINK_DEEP.replaceFirst("<id>", thread.id.toString())}",
                  subject: 'Share this thread',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
