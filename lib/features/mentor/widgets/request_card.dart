import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/features/mentor/models/mentor_request.dart';

import '../../../app/app.dart';
import '../routes/mentor_routes.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.request});
  final MentorRequest request;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: context.height * 0.19,
        width: context.width * 0.8,
        decoration: BoxDecoration(
          border:
              Border.all(color: context.colorScheme.onBackground.withOpacity(0.1), width: 2),
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
                  Text(
                    request.mentor.name,
                    style: context.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              10.heightBox,
              Text(
                request.description,
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
                         onPressed: (){
                           context.push(MentorRoutes.requestDetails, extra: request);
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
                  // FilledButton(onPressed: (){}, child: Text('Review',
                  //  style: context.titleSmall!.copyWith(
                  //                    color: context.colorScheme.surface,
                  //                    fontWeight: FontWeight.bold)
                  // ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
