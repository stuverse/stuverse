import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';
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
    return InkWell(
      onTap: () {
        context.push(
          JobRoutes.jobDetail,
          extra: widget.post,
        );
      },
      child: Card(
        color: context.colorScheme.primary,
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
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(widget.post.image),
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
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 12,
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.post.place,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy  hh:mm a').format(DateTime.parse(
                          widget.post.createdAt,
                        ).toLocal()),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                    iconSize: 15,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            textStyle: TextStyle(fontSize: 15),
                            onTap: () {
                              context.push(
                                JobRoutes.jobAddEdit,
                                extra: widget.post,
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.edit_outlined),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            )),
                        PopupMenuItem(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                            child: Row(
                          children: [
                            Icon(Icons.bookmark_outline),
                            SizedBox(width: 8),
                            Text('Save'),
                          ],
                        )),
                        const PopupMenuItem(
                            child: Row(
                          children: [
                            Icon(Icons.flag_outlined),
                            SizedBox(width: 8),
                            Text('Report '),
                          ],
                        )),
                      ];
                    }),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
