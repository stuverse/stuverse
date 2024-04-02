import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';
import 'package:url_launcher/url_launcher.dart';

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
          padding: const EdgeInsets.all(10),
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
          20.heightBox,
            InkWell(
              onTap:()async{
                  final url =
                Uri.parse("http://wa.me/+91${request.mentor.mobile}");
            final canlaunch = await canLaunchUrl(url);
            if (!canlaunch) {
              return;
            } else {
              await launchUrl(url);
            }
              } ,
               child: Expanded(
                 child: Container(
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       border: Border.all(
                           width: 1,
                           color:
                               Theme.of(context).colorScheme.onBackground)),
                                   
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                   
                     child:
                      Row(
                                     
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Image.asset('assets/app/icons/WhatsApp_icon.png',
                         height: context.height * 0.028,
                         width: context.height * 0.028,
                         ),
                         3.widthBox,
                         Text(
                           'Connect to whatsapp',
                           style: Theme.of(context)
                               .textTheme
                               .bodyMedium!
                               .copyWith(fontWeight: FontWeight.bold,
                               color: Colors.green
                               ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             )
        ]),
      ))));
      
  }
}