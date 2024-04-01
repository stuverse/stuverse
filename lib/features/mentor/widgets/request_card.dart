import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stuverse/features/mentor/models/mentor_request.dart';

import '../../../app/app.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.request});
  final MentorRequest request;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: context.height * 0.3,
        width: context.width * 0.8,
        decoration: BoxDecoration(
          border:
              Border.all(color: context.colorScheme.surfaceVariant, width: 2),
          //color: context.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: context.height * 0.02,
                    backgroundImage:
                        CachedNetworkImageProvider(request.mentor.image),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.mentor.name,
                        style: context.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   CommonUtils.relativeTime(
                      //     DateTime.parse(request.createdAt)
                      //     ,
                      //   ),
                      //   style: context.bodyMedium,
                      // ),
                    ],
                  )
                ],
              ),
              10.heightBox,
              Text(
                request.description,
                style: context.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              10.heightBox,
              // ElevatedButton(
              //           onPressed: (){},
              //           child: Text('Review',
              //               style: context.titleSmall!.copyWith(
              //                   color: context.colorScheme.surface,
              //                   fontWeight: FontWeight.bold)),
              //           style: ElevatedButton.styleFrom(
              //               backgroundColor: context.colorScheme.secondary,
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(12))),
              //         ),
            ],
          ),
        ),
      ),
    );
  }
}
