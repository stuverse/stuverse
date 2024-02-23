// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:stuverse/app/app.dart';


// import '../models/mentor_post.dart';



// class MentorDetailsScreen extends StatefulWidget {
//   MentorDetailsScreen({super.key,required this.post});
//  final MentorPost post;
//   @override
//   State<MentorDetailsScreen> createState() => _MentorDetailsScreenState();
// }

// class _MentorDetailsScreenState extends State<MentorDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double deviceHeight= MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: BgGradient(
//         child: SingleChildScrollView(
//           child: SafeArea(child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [            
//                Stack(
//                  children: [
//                   ClipRRect(
//                    borderRadius: BorderRadius.circular(35),
//                    child: Container(
//                     height: deviceHeight*0.6,
//                     width: double.infinity,
//                     child: Image.network(widget.
//                     fit: BoxFit.cover,
//                     ),
//                    ),
//                  ),
                 
//                   Positioned(
//                     top: 20,
//                     child: IconButton(onPressed: (){
//                         context.pop();
//                     }, icon:Icon(Icons.arrow_back_ios_new,color:Theme.of(context).colorScheme.tertiary),)),
//                  Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                    child: Padding(
//                      padding: const EdgeInsets.symmetric(
//                       horizontal: 15
//                      ),
//                      child: Container(
//                        decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: context.colorScheme.surface.withOpacity(0.91)
//                        ),
//                        child: Padding(
//                          padding: const EdgeInsets.all(15),
//                          child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(widget.post.mentor.fullName,style: context.headlineSmall!.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                 ),
//                                 ),
//                                 SizedBox(height: 5,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Column(
//                                       children: [
//                                         Text('Experience',
//                                         style: context.bodySmall!.copyWith(
//                                         ),
//                                         ),
                                 
//                                         Text('${widget.post.mentor.experience.toString()} Years',
//                                         style: context.bodyMedium!.copyWith(
//                                         fontWeight: FontWeight.bold
//                                         ),
//                                         ),
//                                       ],
//                                     ),
                                 
//                                      Container(
//                                     height: 30, 
//                                     child: VerticalDivider(
//                                     color: Theme.of(context).colorScheme.onBackground,
//                                        thickness: 1,
//                                              ),
//                                                 ),
//                                       Row(
//                                         children: [
//                                            Icon(
//                                            Icons.payment,
//                                            size: 18,
//                                           color: Theme.of(context).colorScheme.onBackground
//                             ),
//                             SizedBox(width: 3,),
//                                  if(widget.post.isFree)
//                                       Text('Free',
//                                       style: context.bodyMedium!.copyWith(
//                                         color: Colors.green,
//                                       fontWeight: FontWeight.bold
//                                       ),
//                                       )
//                                       else
//                                       Text('\$${widget.post.price}',
//                                       style: context.bodyMedium!.copyWith(
//                                       fontWeight: FontWeight.bold
//                                       ),
//                                       ),
//                                         ],
//                                       )
//                                   ]
//                                 ),
//                                 SizedBox(height: 3,),
//                             ElevatedButton(
//                               onPressed: (){}, child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.send,color: Theme.of(context).colorScheme.onBackground,),
//                                 SizedBox(width: 5,),
//                                 Text('Connect',
//                                 style: context.bodyLarge!.copyWith(
//                                 fontWeight: FontWeight.bold)
//                                 ),
//                               ],
//                                                   ),
//                             style: ElevatedButton.styleFrom(
//                               maximumSize: Size(double.infinity, 80),
//                               backgroundColor: Theme.of(context).colorScheme.primary,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)
//                               )
//                             ),
//                             )
                              
//                           ],
//                          ),
//                        ),
//                      ),
//                    ) 
//                  ),
//                  ]
//                ),
//                SizedBox(height: 20,),
//               Text("About",
//               style: context.titleMedium!.copyWith(
//                 fontWeight: FontWeight.bold
//               ),
//               ),
//               SizedBox(height: 5,),
//               Text(widget.post.mentor.bio,
//               style: context.bodyMedium!.copyWith(
//               ),
//               ),
//               ],
//             ),
//           )),
//         ),
//       ),
//     );
//   }
// }