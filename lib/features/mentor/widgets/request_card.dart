import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/features/mentor/cubit/home/cubit/mentor_home_cubit.dart';
import 'package:stuverse/features/mentor/models/mentor_request.dart';

import '../../../app/app.dart';
import '../cubit/manage_mentor_request/cubit/manage_mentor_request_cubit.dart';
import '../cubit/mentor_request/cubit/mentorship_request_cubit.dart';
import '../routes/mentor_routes.dart';

class RequestCard extends StatefulWidget {
  const RequestCard({super.key, required this.request});
  final MentorRequest request;

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        height: 190,
        width: context.width * 0.9,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border.all(
              color: context.colorScheme.onBackground.withOpacity(0.1),
              width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: context.height * 0.02,
                    backgroundImage:
                        CachedNetworkImageProvider(widget.request.mentor.image),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.request.mentor.name,
                        style: context.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        CommonUtils.relativeTime(
                            DateTime.parse(widget.request.createdAt)),
                        style: context.bodySmall,
                      ),
                    ],
                  ),
                  Spacer(),
                
                    PopupMenuButton(
                        padding: EdgeInsets.zero,
                        iconSize: 18,
                        itemBuilder: (context) {
                          return [
                              PopupMenuItem(
                              child:  Row(
                                children: [
                                  Icon(
                                    Icons.report_outlined,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Report',
                                    style: context.bodySmall!.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onTap: () {
                                showDialog(context: context, builder: (context) {
                                  return ReportDialogue(
                                   item: ReportItem.mentorshipRequest,
                                   itemId: widget.request.id,
                                   onSuccess: (){
                                    context.go(MentorRoutes.mentorHome);
                                    context.read<MentorHomeCubit>().getMentorHomeData();
                                   },
                                   onError: (){
                                    
                                   },
                                  );
                                });
                              },
                            ),
                             if (widget.request.mentor.id ==
                      context.read<CoreCubit>().state.user!.id)
                            PopupMenuItem(
                                onTap: () {
                                  context.push(
                                    MentorRoutes.manageMentorRequest,
                                    extra: widget.request,
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
                                      style: context.bodySmall!.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                                 if (widget.request.mentor.id ==
                      context.read<CoreCubit>().state.user!.id)
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
                                        BlocConsumer<ManageMentorRequestCubit,
                                                ManageMentorRequestState>(
                                            listener: (context, state) {
                                              if (state
                                                  is ManageMentorRequestFailure) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(state.message),
                                                ));
                                              }
                                              if (state
                                                  is ManageMentorRequestLoaded) {
                                                    Navigator.of(context)
                                                          .pop();
                                                    context
                                                    .read<
                                                        MentorshipRequestCubit>()
                                                    .getMentorRequestData();
                                                    context
                                                    .read<
                                                        MentorHomeCubit>()
                                                    .getMentorHomeData();
                                                context.showMessage(message: state.message);

                                                context.go(MentorRoutes.mentorHome);
                                                
                                              }
                                            },
                                            builder: (context, state) => state
                                                    is ManageMentorRequestLoading
                                                ? CircularProgressIndicator()
                                                : TextButton(
                                                    onPressed: () async {
                                                      context
                                                          .read<
                                                              ManageMentorRequestCubit>()
                                                          .deleteRequest(
                                                            id: widget
                                                                .request.id,
                                                          );
                                                      
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
                ],
              ),
              10.heightBox,
              Text(
                widget.request.description,
                style: context.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.push(MentorRoutes.requestDetails,
                          extra: widget.request);
                    },
                    child: Text('Review',
                        style: context.titleSmall!.copyWith(
                            color: context.colorScheme.surface,
                            fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
