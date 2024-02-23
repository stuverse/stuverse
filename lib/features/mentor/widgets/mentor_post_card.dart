import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/mentor/cubit/home/mentor_home_cubit.dart';
import 'package:stuverse/features/mentor/cubit/manage_mentor_post/manage_mentor_post_cubit.dart';
import 'package:stuverse/features/mentor/cubit/manage_mentor_post/manage_mentor_post_state.dart';
import 'package:stuverse/features/mentor/mentor.dart';

import '../models/mentor_post.dart';

class MentorPostCard extends StatefulWidget {
  const MentorPostCard({super.key, required this.post});
  final MentorPost post;

  @override
  State<MentorPostCard> createState() => _MentorPostCardState();
}

class _MentorPostCardState extends State<MentorPostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {
          // context.push(MentorRoutes.mentorDetails,extra: widget.post);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.24,
          width: MediaQuery.of(context).size.height * 0.30,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Row(children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(widget.post.mentor!.image!),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.post.mentor?.name ?? "User",
                  style: context.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                if (widget.post.mentor!.id ==
                    context.read<CoreCubit>().state.user!.id)
                  PopupMenuButton(
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              onTap: () {
                                context.push(
                                  MentorRoutes.manageMentorPost,
                                  extra: widget.post,
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Edit',
                                    style: context.bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          PopupMenuItem(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Are you sure you want to delete this thread?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      BlocConsumer<ManageMentorPostCubit,
                                              ManageMentorPostState>(
                                          listener: (context, state) {
                                            if (state
                                                is ManageMentorPostFailure) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(state.message),
                                              ));
                                            }
                                            if (state
                                                is ManageMentorPostLoaded) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(state.message),
                                              ));
                                              context.pushReplacement(
                                                  MentorRoutes.mentorHome);
                                              context
                                                  .read<MentorHomeCubit>()
                                                  .getMentorHomeData();
                                            }
                                          },
                                          builder: (context, state) => state
                                                  is ManageMentorPostLoading
                                              ? CircularProgressIndicator()
                                              : TextButton(
                                                  onPressed: () async {
                                                    context
                                                        .read<
                                                            ManageMentorPostCubit>()
                                                        .deletePost(
                                                            id: widget
                                                                .post.id!);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Delete'),
                                                )),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Delete',
                                  style: context.bodySmall!.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ];
                      }),
              ]),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: context.colorScheme.surface,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.payment,
                              color: context.colorScheme.onBackground),
                          SizedBox(
                            width: 5,
                          ),
                          (widget.post.isFree!)
                              ? Text(
                                  'Free',
                                  style: context.bodyMedium!.copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                )
                              : Text(
                                  'Paid',
                                  style: context.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.post.name ?? "",
                        style: context.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
