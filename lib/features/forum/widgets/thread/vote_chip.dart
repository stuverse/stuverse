import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stuverse/app/app.dart';

import '../../cubit/vote/vote_cubit.dart';
import '../../forum.dart';

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
      duration: const Duration(milliseconds: 300),
    );

    _downVoteAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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
        widget.vote?.value = 1;
        widget.vote?.totalVotes = voteCount;
        _upVoteAnimationController?.reset();
        _upVoteAnimationController?.forward();
      } else {
        voteCount--;
        widget.vote?.value = 0;
        widget.vote?.totalVotes = voteCount;
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
        widget.vote?.value = -1;
        widget.vote?.totalVotes = voteCount;
        _downVoteAnimationController?.reset();
        _downVoteAnimationController?.forward();
      } else {
        voteCount++;
        widget.vote?.value = 0;
        widget.vote?.totalVotes = voteCount;
        _downVoteAnimationController?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
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
                              offset: Offset(0,
                                  isUpVoted ? _upVoteJumpAnimation.value : 0),
                              child: SvgPicture.asset(
                                isUpVoted
                                    ? ForumImages.upSolidSVG
                                    : ForumImages.upSVG,
                                height: 20,
                                width: 20,
                                colorFilter: ColorFilter.mode(
                                  isUpVoted
                                      ? Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                  BlendMode.srcIn,
                                ),
                              ),
                            );
                          }),
                      5.widthBox,
                      Text(
                        CommonUtils.formatNumberEnglish(
                          (voteCount),
                        ),
                        style: context.bodyMedium!.copyWith(
                          color: isUpVoted
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : isDownVoted
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
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
                        animation: _downVoteJumpAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0,
                                isDownVoted ? _downVoteJumpAnimation.value : 0),
                            child: SvgPicture.asset(
                              isDownVoted
                                  ? ForumImages.downSolidSVG
                                  : ForumImages.downSVG,
                              height: 20,
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                isDownVoted
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                BlendMode.srcIn,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )).onTap(() {
                context.read<VoteCubit>().voteThread(
                      threadId: widget.threadId,
                      vote: -1,
                    );
                _toggleDownVote();
              }),
            ],
          )),
    );
  }
}
