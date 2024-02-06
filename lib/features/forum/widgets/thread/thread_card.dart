import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/cubit/vote/vote_cubit.dart';
import 'package:stuverse/features/forum/forum.dart';

import 'thread_tag_chip.dart';
import 'vote_chip.dart';

class ThreadCard extends StatelessWidget {
  const ThreadCard({
    super.key,
    required this.thread,
    this.isDetailScreen = false,
    this.commentFocusNode,
  });

  final Thread thread;
  final bool isDetailScreen;
  final FocusNode? commentFocusNode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isDetailScreen) {
          context.push(
            ForumRoutes.threadDetail,
            extra: thread,
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
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(thread.community?.image ?? ""),
                ),
              ),
              10.widthBox,
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
              IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
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
              child: Image.network(
                thread.image!,
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
                    5.widthBox,
                    Text(
                      CommonUtils.formatNumberEnglish(
                        thread.shareCount ?? 0,
                      ),
                      style: context.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
