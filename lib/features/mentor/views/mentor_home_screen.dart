import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/mentor/cubit/manage_mentor_post/manage_mentor_post_cubit.dart';
import 'package:stuverse/features/mentor/cubit/manage_mentor_post/manage_mentor_post_state.dart';
import '../cubit/home/mentor_home_cubit.dart';
import '../routes/mentor_routes.dart';
import '../widgets/mentor_post_card.dart';

class MentorHomeScreen extends StatefulWidget {
  MentorHomeScreen({super.key});

  @override
  _MentorHomeScreenState createState() => _MentorHomeScreenState();
}

class _MentorHomeScreenState extends State<MentorHomeScreen> {
  void initState() {
    context
        .read<MentorHomeCubit>()
        .getMentorHomeData(search: _searchController.text);
    super.initState();
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BgGradient(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(MentorRoutes.manageMentorPost);
          },
          icon: Icon(Icons.add),
          label: Text("Add Post"),
        ),
        body: BgGradient(
          child: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<MentorHomeCubit>()
                    .getMentorHomeData(search: _searchController.text);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find Your',
                      style: context.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Perfect Mentor',
                        style: context.headlineLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    ListViewCard(
                      title: 'Unlock Your Potential!',
                      description:
                          'Inspire and empower others with your knowledge. Join as a mentor today.',
                      buttonText: 'Join Now',
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27),
                        color: Color.fromARGB(242, 231, 230, 230),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          context.read<MentorHomeCubit>().getMentorHomeData(
                              search: _searchController.text);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    BlocBuilder<ManageMentorPostCubit, ManageMentorPostState>(
                      builder: (context, state) => state is ManageMentorPostLoading
                          ? CircularProgressIndicator()
                         
                     
                      
                   : BlocConsumer<MentorHomeCubit, MentorHomeState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is MentorHomeFailure) {
                            return Center(child: Text('Error'));
                          }
                          if (state is MentorHomeLoaded) {
                            // final first3Mentors = state.posts.take(3).toList();
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Top Mentors',
                                      style: context.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'See All',
                                        style: context.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (final post in state.posts)
                                        MentorPostCard(post: post),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    
                    ),
  
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard(
      {super.key,
      required this.title,
      required this.description,
      required this.buttonText});
  final String title;
  final String description;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: context.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(buttonText,
                          style: context.titleSmall!.copyWith(
                              color: context.colorScheme.surface,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  )
                ],
              )),
        ));
  }
}
