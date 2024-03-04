import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/mentor_post.dart';


class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({super.key,required this.post});
 final MentorPost post;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}
  bool isAboutExpanded = false;
class _PostDetailsScreenState extends State<PostDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    double deviceHeight= MediaQuery.of(context).size.height;
    return Hero(
       tag: 'mentor_${widget.post.id}',
      child: Scaffold(
        appBar:
         AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: SafeArea(child: Padding(
            padding: const EdgeInsets.all(15),
            child: 
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [  
                
                 ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Container(
                   height: deviceHeight*0.35,
                   width: double.infinity,
                   child: Image.network(widget.post.mentor!.image!,
                   fit: BoxFit.cover,
                   ),
                  ),
                                ),
                                SizedBox(height: 15,),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.post.mentor!.name!,style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                        ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('Experience',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                ),
                                ),
                         
                                Text('${widget.post.mentor!.experienceYears!.toString()} Years',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold
                                ),
                                ),
                              ],
                            ),
                         
                             Container(
                            height: 30, 
                            child: VerticalDivider(
                            color: Theme.of(context).colorScheme.onBackground,
                               thickness: 1,
                                     ),
                                        ),
                              Row(
                                children: [
                                   Icon(
                                   Icons.payment,
                                   size: 18,
                                  color: Theme.of(context).colorScheme.onBackground
                    ),
                    SizedBox(width: 3,),
                         if(widget.post.isFree!)
                              Text('Free',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.green,
                              fontWeight: FontWeight.bold
                              ),
                              )
                              else
                              Text('\$${widget.post.price}/hr',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold
                              ),
                              ),
                                ],
                              )
                          ]
                        ),
                        SizedBox(height: 3,),
                    ElevatedButton(
                      onPressed: ()async{
                        final url =  Uri.parse("http://wa.me/+91${ widget.post.mentor!.mobile}");
                        final canlaunch = await canLaunchUrl(
                          url
                        );
                        if(!canlaunch){
                          return;
                        }else{
                          await launchUrl(
                            url
                          );
                        }
                        
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send,color: Theme.of(context).colorScheme.onBackground,),
                        SizedBox(width: 5,),
                        Text('Connect',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold)
                        ),
                      ],
                                          ),
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(double.infinity, 80),
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.86),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                    )
                      
                  ],
                 ),
                   SizedBox(height: 10),
                    Text("Insights",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold
                ),

                ),
                SizedBox(height: 5,),
                ReadMoreText(
                widget.post.description!,
                trimLines: 2,
                colorClickableText: Theme.of(context).colorScheme.primary,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'Show less',
                moreStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
                ),
                lessStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
                ),
              ),
                SizedBox(height: 10,),
                Text("About Myself",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height: 5,),
              ReadMoreText(
                widget.post.mentor!.about!,
                trimLines: 3,
                colorClickableText: Theme.of(context).colorScheme.primary,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'Show less',
                moreStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
                ),
                lessStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
                ),
              ),
                SizedBox(height: 10,),
                 Text("Skills",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height: 5,),
              
                    SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.post.mentor!.skills!.map((skill) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(
                  skill.name!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10,),
                ],
              ),                     
           
          )),
        ),
      ),
    );
  }
}

