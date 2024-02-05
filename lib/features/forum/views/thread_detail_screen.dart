import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/forum/utils/forum_utils.dart';

import '../cubit/comment/comment_cubit.dart';
import '../widgets/comment_card.dart';

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

  @override
  void initState() {
    context.read<CommentCubit>().getComments(threadId: widget.thread.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thread Detail",
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
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
                          listener: (context, state) {},
                          builder: (context, state) {
                            return state.maybeMap(
                              success: (value) {
                                return Column(
                                  children: [
                                    for (var comment in value.comments)
                                      TreeView.simple(
                                        indentation: Indentation(
                                          style: IndentStyle.roundJoint,
                                          thickness: 0.3,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground
                                              .withOpacity(0.4),
                                        ),
                                        tree:
                                            ForumUtils.threadCommentToTreeNode(
                                                comment),
                                        expansionBehavior:
                                            ExpansionBehavior.scrollToLastChild,
                                        shrinkWrap: true,
                                        showRootNode: true,
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
                                          commentController: commentController,
                                          comment: node.data!,
                                          commentFocusNode: commentFocusNode,
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
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                ),
                padding: context.paddingHorzWithVertical(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          hintText: "Write a comment...",
                          hintStyle: context.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                    10.widthBox,
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
