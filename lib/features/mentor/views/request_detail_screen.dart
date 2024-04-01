import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

import '../models/mentor_request.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key, required this.request});

  final MentorRequest request;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,

      body:BgGradient(
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
          Text(request.description),
          10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
          

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.86),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                        onPressed: (){}, child: Row(
                        children: [
                          Icon(Icons.send,
                          color: context.colorScheme.onBackground,
                          ),
                          5.widthBox,
                          Text('Message',
                          style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold))
                        ],
                      ))
              ],
            )
        ]),
      ))));
      
  }
}