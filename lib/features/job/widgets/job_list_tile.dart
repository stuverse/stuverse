import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:stuverse/app/app.dart';

import '../models/job_post.dart';
import '../routes/job_routes.dart';

class JobListTile extends StatefulWidget {
  const JobListTile({
    super.key,
    required this.post,
  });
  final JobPost post;

  @override
  State<JobListTile> createState() => _JobListTileState();
}

class _JobListTileState extends State<JobListTile> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return InkWell(
      onTap: () {
        context.push(
          JobRoutes.jobDetail,
          extra: widget.post,
        );
      },
      child: Card(
        color: context.colorScheme.surfaceVariant.withOpacity(0.6),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image:
                                  CachedNetworkImageProvider(widget.post.image),
                              fit: BoxFit.cover))),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.title,
                      ),
                      Text(widget.post.companyName),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: context.colorScheme.secondaryContainer,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.post.place,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          CommonUtils.relativeTime(
                            DateTime.parse(widget.post.createdAt),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // if (user?.type == UserTypes.ADMIN ||
                //     user?.type == UserTypes.FACULTY)
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
