import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stuverse/app/app.dart';


import '../../forum.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.comment,
    required this.onReply,
  });

  final TreeNode<ThreadComment> comment;

  final Function(TreeNode<ThreadComment>?) onReply;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingHorzWith(0.035),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(
                    comment.data?.author?.image ?? ""),
              ),
              10.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${CommonUtils.getFirstLetter(comment.data?.author?.type ?? "u")}/${comment.data?.author?.username ?? "User"}",
                    style: context.bodyMedium!.copyWith(
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
                  CommonUtils.relativeTime(comment.data?.createdAt),
                  style: context.bodySmall!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                  ),
                ),
              ),
              5.widthBox,
              PopupMenuButton(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ReportDialogue(
                              item: ReportItem.comment,
                              itemId: comment.data?.id ?? 0-1,
                              onSuccess: () {
                                context.read<ThreadCommentCubit>().getComments(
                                  threadId: comment.data?.thread ?? -1
                                );
                              },
                              onError: (){

                              },
                          );
                        },
                      );
                    },
                    child: Text("Report 🛑"),
                  ),
                ];
              }),
              5.widthBox,
            ],
          ),
          Text(
            comment.data?.content ?? "",
            style: context.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ).paddingOnly(left: 5),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (comment.data?.replyCount != null &&
                    comment.data?.replyCount != 0)
                  Text(
                    "${comment.data?.replyCount ?? 0} ${comment.data?.replyCount == 1 ? "Reply" : "Replies"}",
                    style: context.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                InkWell(
                  onTap: () {
                    onReply(comment);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      10.widthBox,
                      SvgPicture.asset(
                        ForumImages.replySVG,
                        width: 15,
                        height: 15,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.7),
                            BlendMode.srcIn),
                      ),
                      5.widthBox,
                      Text(
                        "Reply",
                        style: context.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.7)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          10.heightBox,
        ],
      ),
    );
  }
}
