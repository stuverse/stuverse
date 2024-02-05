import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stuverse/app/app.dart';

import '../forum.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.commentController,
    required this.comment,
    required this.commentFocusNode,
  });

  final ThreadComment comment;

  final TextEditingController commentController;
  final FocusNode commentFocusNode;

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
                backgroundImage: NetworkImage(comment.author?.image ?? ""),
              ),
              10.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${CommonUtils.getFirstLetter(comment.author?.type ?? "u")}/${comment.author?.username ?? "User"}",
                    style: context.bodyLarge!.copyWith(
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
                  CommonUtils.relativeTime(comment.createdAt),
                  style: context.bodyMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                  ),
                ),
              ),
              5.widthBox,
              IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
              5.widthBox,
            ],
          ),
          Text(
            comment.content ?? "",
            style: context.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ).paddingOnly(left: 5),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (comment.replyCount != null && comment.replyCount != 0)
                  Text(
                    "${comment.replyCount ?? 0} ${comment.replyCount == 1 ? "Reply" : "Replies"}",
                    style: context.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    commentController.text =
                        "@${comment.author?.username ?? ""} ";
                    commentController.selection = TextSelection.fromPosition(
                      TextPosition(offset: commentController.text.length),
                    );
                    //focus
                    FocusScope.of(context).requestFocus(commentFocusNode);
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
