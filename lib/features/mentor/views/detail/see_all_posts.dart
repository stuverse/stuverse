import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

import '../../cubit/search/mentor_search_cubit.dart';
import '../../models/mentor_post.dart';
import '../../widgets/mentor_post_card.dart';

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
    String? selectedFilter;
  List<String> filters = ['All', 'Free', 'Paid'];
  List<MentorPost> allPosts = []; // Assuming you have all mentor posts stored here

  List<MentorPost> getFilteredPosts() {
    // Filter mentor posts based on the selected filter
    switch (selectedFilter) {
      case 'Free':
        return allPosts.where((post) => post.isFree).toList();
      case 'Paid':
        return allPosts.where((post) => !post.isFree).toList();
      default:
        return allPosts;
    }
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
                      child: Row(
                        children: [
                          Expanded(
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
                          10.widthBox,
                        InkWell(
                          onTap: () {
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                content: Text("Mentorship Fee"),
                                actions: [
                                 Column(
                                   children: [
                                    Text('fee'),
                                          DropdownButton<String>(
                      value: selectedFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedFilter = value;
                        });
                      },
                      items: filters.map<DropdownMenuItem<String>>((String filter) {
                        return DropdownMenuItem<String>(
                          value: filter,
                          child: Text(filter),
                        );
                      }).toList(),
                    ),
                                   ],
                                 ),

                                ],
                              );
                            });
                          },
                          child: Container(
                              height:58,
                              width: 58,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: context.colorScheme.primaryContainer,
                              ),
                              child: Icon(
                                Icons.tune,
                                size: 24,
                              ),
                            ),
                        ),
                        ],
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
                        return const SizedBox();
                      },
                    )
                  ],
                ))));
  }
}
