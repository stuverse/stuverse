import 'dart:developer';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/forum/utils/forum_utils.dart';

import '../../cubit/comment/comment_cubit.dart';

class ThreadDetailScreen extends StatefulWidget {
  const ThreadDetailScreen(
      {super.key, required this.thread, this.onThreadUpdate});
  final Thread thread;
  final Function(Thread thread)? onThreadUpdate;

  @override
  State<ThreadDetailScreen> createState() => _ThreadDetailScreenState();
}

class _ThreadDetailScreenState extends State<ThreadDetailScreen> {
  final commentController = TextEditingController();
  final commentFocusNode = FocusNode();
  final scrollController = ScrollController();

  double? _tapPosition;

  final ValueNotifier<TreeNode<ThreadComment>?> replyToNotifier =
      ValueNotifier(null);

  TreeNode<ThreadComment>? currentNode;

  @override
  void initState() {
    context.read<CommentCubit>().getComments(threadId: widget.thread.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          SvgPicture.asset(
            AppImages.searchSVG,
            height: 20,
            width: 20,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onBackground,
              BlendMode.srcIn,
            ),
          ),
          //more actions
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          ),
          (0.02 * context.minSize).widthBox
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BgGradient(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: context.paddingHorzWith(0.02),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        ThreadCard(
                          thread: widget.thread,
                          isDetailScreen: true,
                        ),
                        10.heightBox,
                        Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.3),
                          thickness: 0.5,
                        ),
                        10.heightBox,
                        BlocConsumer<CommentCubit, CommentState>(
                          listener: (context, state) {
                            state.mapOrNull(
                              error: (value) {
                                context.showErrorMessage(
                                    message: value.message);
                              },
                            );
                          },
                          builder: (context, state) {
                            return state.maybeMap(
                              success: (value) {
                                return Column(
                                  children: [
                                    TreeView.simple(
                                      onTreeReady: (controller) {
                                        final rootNode = controller.tree;
                                        controller.expandAllChildren(rootNode,
                                            recursive: true);
                                        if (currentNode != null &&
                                            _tapPosition != null) {
                                          log("Scrolling to current node");

                                          scrollController.animateTo(
                                              _tapPosition! + 100,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                          controller.scrollToItem(currentNode!);
                                        }
                                      },
                                      // scrollController: treeScrollController,
                                      indentation: Indentation(
                                        style: IndentStyle.roundJoint,
                                        thickness: 0.3,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.4),
                                      ),
                                      tree: ForumUtils.threadCommentToTreeNode(
                                          ThreadComment(
                                              id: 0,
                                              content: "Root",
                                              children: value.comments)),
                                      expansionBehavior: ExpansionBehavior.none,
                                      shrinkWrap: true,
                                      showRootNode: false,
                                      // expansionIndicatorBuilder: (context, node) {
                                      //   return ChevronIndicator.upDown(
                                      //     tree: tree,
                                      //     alignment: Alignment.bottomCenter,
                                      //     padding: EdgeInsets.only(
                                      //       right: 5,
                                      //       bottom: 23,
                                      //     ),
                                      //   );
                                      // },
                                      builder: (context, node) => CommentCard(
                                        onReply: (node) {
                                          commentFocusNode.requestFocus();
                                          replyToNotifier.value = node;
                                        },
                                        comment: node,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              orElse: () => Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                        100.heightBox,
                      ],
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: replyToNotifier,
                  builder: (context, value, child) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                      ),
                      padding:
                          context.paddingHorzWithVertical(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          if (replyToNotifier.value != null)
                            Padding(
                              padding: context.paddingHorzWith(0.02),
                              child: Row(
                                children: [
                                  Text(
                                    "Replying to ${value?.data?.author?.username ?? "User"}",
                                    style: context.bodyMedium!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      replyToNotifier.value = null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: commentController,
                                  focusNode: commentFocusNode,
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    hintText: "Write a comment...",
                                    hintStyle: context.bodyMedium!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ),
                              10.widthBox,
                              BlocConsumer<CommentCubit, CommentState>(
                                listener: (context, state) {
                                  state.mapOrNull(
                                    commentAddFailed: (value) {
                                      context.showErrorMessage(
                                          message: value.message);
                                    },
                                    commentAdded: (value) {
                                      context
                                          .read<CommentCubit>()
                                          .getCommentSilently(
                                            threadId: widget.thread.id!,
                                          );
                                    },
                                  );
                                },
                                builder: (context, state) {
                                  return state.maybeMap(
                                    commentAdding: (value) =>
                                        CircularProgressIndicator(),
                                    orElse: () => IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: () {
                                        if (commentController.text.isNotEmpty) {
                                          context
                                              .read<CommentCubit>()
                                              .addComment(
                                                threadId: widget.thread.id!,
                                                content: commentController.text,
                                                parentId: value?.data?.id,
                                              );
                                          commentController.clear();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          currentNode = replyToNotifier.value;
                                          replyToNotifier.value = null;
                                          _tapPosition = scrollController
                                              .position.pixels
                                              .toDouble();
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}