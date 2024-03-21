import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

import '../cubit/search/mentor_search_cubit.dart';
import '../widgets/mentor_post_card.dart';

class seeAllPostsScreen extends StatefulWidget {
  const seeAllPostsScreen({super.key});

  @override
  State<seeAllPostsScreen> createState() => _seeAllPostsScreenState();
}

class _seeAllPostsScreenState extends State<seeAllPostsScreen> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    context
        .read<MentorSearchCubit>()
        .getMentorSearchData(search: _searchController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    5.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Hero(
                        tag: 'search',
                        child: Material(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(27),
                              color: Color.fromARGB(242, 231, 230, 230),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                context
                                    .read<MentorSearchCubit>()
                                    .getMentorSearchData(
                                        search: _searchController.text);
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    5.heightBox,
                    BlocBuilder<MentorSearchCubit, MentorSearchState>(
                      builder: (context, state) {
                        if (state is MentorSearchLoading) {
                          return LinearProgressIndicator();
                        } else if (state is MentorSearchLoaded) {
                          final posts = state.posts;
                          final facultyMentors = posts
                              .where((post) => post.mentor!.type == "faculty")
                              .toList();
                          final studentMentors = posts
                              .where((post) => post.mentor!.type == "student")
                              .toList();
                          return Expanded(
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
                          );
                        }
                        return Container();
                      },
                    )
                  ],
                ))));
  }
}
