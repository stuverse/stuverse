import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
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
          context.push(MentorRoutes.mentorDetails,extra: widget.post);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.23,
          width: MediaQuery.of(context).size.height * 0.22,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                    widget.post.mentor.image
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.post.mentor.username,
                    style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
                          Icon(
                            Icons.payment,
                            color: context.colorScheme.onBackground
                        
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          widget.post.isFree
                          ?Text(
                            'Free',
                            style: context
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                          )
                          :
                          Text(
                            'Paid',
                            style: context
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.post.name,
                        style:
                            context.bodyMedium!.copyWith(
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