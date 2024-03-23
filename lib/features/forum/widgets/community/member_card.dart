import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/cubit/community/members/community_members_cubit.dart';

import '../../../../app/models/mini_user.dart';

class MembersCard extends StatelessWidget {
  const MembersCard({
    super.key,
    required this.communityId,
    required this.member,
  });
  final int communityId;
  final MiniUser member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        tileColor: context.colorScheme.surface,
        leading: CircleAvatar(
          radius: context.height * 0.02,
          backgroundImage: CachedNetworkImageProvider(
            member.image ?? "",
          ),
        ),
        title: Text(member.name ?? ""),
        subtitle: Text(member.email ?? ""),
        trailing: PopupMenuButton(itemBuilder: (context) {
          return [
            //  PopupMenuItem(
            //   onTap: (){},
            //   child: Row(
            //     children: [
            //       Icon(Icons.account_circle_sharp,
            //       ),
            //       SizedBox(width: 10),
            //       Text('View Profile'),
            //     ],
            //   ),
            // ),
            PopupMenuItem(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          'Are you sure you want to remove this member?',
                          style: context.bodyMedium,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                'No',
                                style: context.bodyMedium,
                              )),
                          TextButton(
                              onPressed: () {
                                context.pop();
                                context
                                    .read<CommunityMembersCubit>()
                                    .removeMember(
                                        memberId: member.id!,
                                        communityId: communityId);
                              },
                              child: Text(
                                'Yes',
                                style: context.bodyMedium,
                              )),
                        ],
                      );
                    });
              },
              child: Row(
                children: [
                  Icon(Icons.close, color: Colors.red),
                  SizedBox(width: 10),
                  Text('Remove', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ];
        }),
      ),
    );
  }
}
