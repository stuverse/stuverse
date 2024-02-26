import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/mentor/cubit/home/mentor_home_cubit.dart';

import '../widgets/mentor_post_card.dart';


class seeAllPostsScreen extends StatefulWidget {
  const seeAllPostsScreen({super.key});

  @override
  State<seeAllPostsScreen> createState() => _seeAllPostsScreenState();
}

class _seeAllPostsScreenState extends State<seeAllPostsScreen> {
  @override
  Widget build(BuildContext context) {
    final posts= (context.read<MentorHomeCubit>().state as MentorHomeLoaded).posts;
    final facultyMentors = posts.where((post) => post.mentor!.type == "faculty").toList();
    final studentMentors = posts.where((post) => post.mentor!.type == "student").toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
             Expanded(
                              child: DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    TabBar(
                                      dividerColor: Colors.transparent,
                                      tabs: [
                                        Tab(
                                          text: 'Professional Mentors',
                                        ),
                                        Tab(text: 'Student Mentors'),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                        ),
                                        child: TabBarView(
                                          children: [
                                            ListView.builder(
                                itemBuilder: (context, index) {
                                  return MentorPostCard(
                                    post: facultyMentors[index],
                                  );
                                },
                                itemCount: facultyMentors.length,
                              ),

                              ListView.builder(
                                itemBuilder: (context, index) {
                                  return MentorPostCard(
                                    post: studentMentors[index],
                                  );
                                },
                                itemCount: studentMentors.length,
                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
        
          ],
        ),
      )),
    );
  }
}