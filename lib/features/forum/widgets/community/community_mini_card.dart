import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

class CommunityMiniCard extends StatefulWidget {
  const CommunityMiniCard({
    super.key,
    required this.community,
    this.isDetail = false,
  });
  final Community community;
  final bool isDetail;

  @override
  State<CommunityMiniCard> createState() => _CommunityMiniCardState();
}

class _CommunityMiniCardState extends State<CommunityMiniCard> {
  @override
  late final User? user;
  bool isJoined = false;
  @override
  void initState() {
    user = context.read<CoreCubit>().state.user;
    isJoined = widget.community.members?.contains(user?.id) ?? false;
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isDetail
          ? null
          : () {
              context.push(ForumRoutes.communityDetail
                  .replaceFirst(":id", widget.community.id.toString()));
            },
      child: Container(
        margin: widget.isDetail ? null : context.paddingOnlyWith(right: 15),
        decoration: BoxDecoration(
          color: widget.isDetail ? null : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        padding: context.paddingAllWith(0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.community.image ?? ""),
                ),
                10.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.community.name ?? "",
                      style: context.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      (widget.community.members?.length.toString() ?? "0") +
                          " Members",
                      style: context.bodyMedium!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                BlocConsumer<CommunityManageCubit, CommunityManageState>(
                  listener: (context, state) {
                    if (state is CommunityJoinSuccess ||
                        state is CommunityLeaveSuccess) {
                      context.read<ForumHomeCubit>().getHomeData(
                            isSilent: true,
                          );
                      isJoined = !isJoined;
                    }
                    if (state is CommunityJoinError) {
                      context.showErrorMessage(
                        message: state.message,
                      );
                    }
                    if (state is CommunityLeaveError) {
                      context.showErrorMessage(
                        message: state.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        if (isJoined)
                          TextButton(
                            onPressed: () {
                              if (widget.community.id != null)
                                context
                                    .read<CommunityManageCubit>()
                                    .toggleJoinCommunity(
                                      communityId: widget.community.id!,
                                    );
                            },
                            child: state is CommunityLeaveLoading
                                ? CircularProgressIndicator()
                                : Text("Joined"),
                          )
                        else
                          FilledButton.tonal(
                            onPressed: () {
                              if (widget.community.id != null)
                                context
                                    .read<CommunityManageCubit>()
                                    .toggleJoinCommunity(
                                      communityId: widget.community.id!,
                                    );
                            },
                            child: state is CommunityJoinLoading
                                ? CircularProgressIndicator()
                                : Text("Join"),
                          ),
                      ],
                    );
                  },
                )
              ],
            ),
            10.heightBox,
            Text(
              widget.community.description ?? "",
              maxLines: widget.isDetail ? null : 1,
              textAlign: TextAlign.left,
              overflow: widget.isDetail ? null : TextOverflow.ellipsis,
              style: context.bodyMedium!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
            10.heightBox,
            // Chip(
            //   label: Text(
            //     "Type: " + (widget.community.type?.name ?? ""),
            //     style: context.bodyMedium!.copyWith(
            //       color: Theme.of(context)
            //           .colorScheme
            //           .onBackground
            //           .withOpacity(0.7),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
