import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/cubit/vote/vote_cubit.dart';
import 'package:stuverse/features/forum/forum.dart';

class ThreadCard extends StatelessWidget {
  const ThreadCard({
    super.key,
    required this.thread,
    this.showAuthor = true,
  });

  final Thread thread;
  final bool showAuthor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingHorzWith(0.035),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(thread.community?.image ?? ""),
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
                  if (showAuthor)
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
          Text(
            thread.content ?? "",
            style: context.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          5.heightBox,
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
                      AppImages.commentSVG,
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
              ),
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
                      AppImages.shareSVG,
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

class VoteChip extends StatefulWidget {
  const VoteChip({
    super.key,
    required this.vote,
    required this.threadId,
  });
  final ThreadVote? vote;
  final int threadId;

  @override
  State<VoteChip> createState() => _VoteChipState();
}

class _VoteChipState extends State<VoteChip> with TickerProviderStateMixin {
  bool isUpVoted = false;
  bool isDownVoted = false;

  AnimationController? _upVoteAnimationController;
  AnimationController? _downVoteAnimationController;

  Animation<Color?>? _upVoteColorAnimation;
  Animation<Color?>? _downVoteColorAnimation;

  late Animation<double> _upVoteJumpAnimation;
  late Animation<double> _downVoteJumpAnimation;

  late int voteCount;

  @override
  void initState() {
    voteCount = widget.vote?.totalVotes ?? 0;
    switch (widget.vote?.value) {
      case 1:
        isUpVoted = true;
        isDownVoted = false;
        break;
      case -1:
        isUpVoted = false;
        isDownVoted = true;
        break;
      default:
        isUpVoted = false;
        isDownVoted = false;
    }

    setState(() {});

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _upVoteAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _downVoteAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _upVoteJumpAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -20), // Jump up
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -20, end: 0), // Come back down
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: _upVoteAnimationController!,
      curve: Curves.easeInOut,
    ));

    _downVoteJumpAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 20), // Jump down
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 20, end: 0), // Come back up
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: _downVoteAnimationController!,
      curve: Curves.easeInOut,
    ));

    _upVoteColorAnimation = ColorTween(
      begin: Theme.of(context).colorScheme.onBackground,
      end: Theme.of(context).colorScheme.secondaryContainer,
    ).animate(_upVoteAnimationController!);

    _downVoteColorAnimation = ColorTween(
      begin: Theme.of(context).colorScheme.onBackground,
      end: Theme.of(context).colorScheme.error,
    ).animate(_downVoteAnimationController!);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _upVoteAnimationController?.dispose();
    _downVoteAnimationController?.dispose();
    super.dispose();
  }

  void _toggleUpVote() {
    HapticFeedback.lightImpact();
    if (isDownVoted) {
      voteCount++;
    }
    setState(() {
      isUpVoted = !isUpVoted;
      isDownVoted = false;
      if (isUpVoted) {
        voteCount++;
        _upVoteAnimationController?.reset();
        _upVoteAnimationController?.forward();
      } else {
        voteCount--;
        _upVoteAnimationController?.reverse();
      }
    });
  }

  void _toggleDownVote() {
    HapticFeedback.lightImpact();
    if (isUpVoted) {
      voteCount--;
    }
    setState(() {
      isDownVoted = !isDownVoted;
      isUpVoted = false;
      if (isDownVoted) {
        voteCount--;
        _downVoteAnimationController?.reset();
        _downVoteAnimationController?.forward();
      } else {
        voteCount++;
        _downVoteAnimationController?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
          width: 1,
        ),
      ),
      padding: context.paddingHorzWith(0.02),
      child: Row(
        children: [
          Padding(
              padding: context.paddingOnlyWith(
                top: 8,
                bottom: 8,
              ),
              child: Row(
                children: [
                  AnimatedBuilder(
                      animation: _upVoteJumpAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                              0, isUpVoted ? _upVoteJumpAnimation.value : 0),
                          child: SvgPicture.asset(
                            isUpVoted ? AppImages.upSolidSVG : AppImages.upSVG,
                            height: 20,
                            width: 20,
                            colorFilter: ColorFilter.mode(
                              isUpVoted
                                  ? _upVoteColorAnimation!.value!
                                  : Theme.of(context).colorScheme.onBackground,
                              BlendMode.srcIn,
                            ),
                          ),
                        );
                      }),
                  5.widthBox,
                  AnimatedBuilder(
                      animation: isUpVoted
                          ? _upVoteColorAnimation!
                          : _downVoteColorAnimation!,
                      builder: (context, child) {
                        return Text(
                          CommonUtils.formatNumberEnglish(
                            (voteCount),
                          ),
                          style: context.bodyMedium!.copyWith(
                            color: isUpVoted
                                ? _upVoteColorAnimation!.value!
                                : _downVoteColorAnimation!.value!,
                          ),
                        );
                      }),
                ],
              )).onTap(() {
            context.read<VoteCubit>().voteThread(
                  threadId: widget.threadId,
                  vote: 1,
                );
            _toggleUpVote();
          }),
          BlocListener<VoteCubit, VoteState>(
            listener: (context, state) {
              state.mapOrNull(
                error: (e) {
                  context.showErrorMessage(
                    message: e.message,
                  );
                  if (e.vote == 1) {
                    _toggleUpVote();
                  } else {
                    _toggleDownVote();
                  }
                },
              );
            },
            child: 5.widthBox,
          ),
          Padding(
              padding: context.paddingOnlyWith(
                top: 8,
                bottom: 8,
              ),
              child: Row(
                children: [
                  5.widthBox,
                  AnimatedBuilder(
                    animation: _downVoteColorAnimation!,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                            0, isDownVoted ? _downVoteJumpAnimation.value : 0),
                        child: SvgPicture.asset(
                          isDownVoted
                              ? AppImages.downSolidSVG
                              : AppImages.downSVG,
                          height: 20,
                          width: 20,
                          colorFilter: ColorFilter.mode(
                            isDownVoted
                                ? _downVoteColorAnimation!.value!
                                : Theme.of(context).colorScheme.onBackground,
                            BlendMode.srcIn,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )),
        ],
      ).onTap(() {
        context.read<VoteCubit>().voteThread(
              threadId: widget.threadId,
              vote: -1,
            );
        _toggleDownVote();
      }),
    );
  }
}
