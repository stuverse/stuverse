import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/mentor/cubit/manage_mentor_post/manage_mentor_post_cubit.dart';
import 'package:stuverse/features/mentor/cubit/manage_mentor_post/manage_mentor_post_state.dart';
import 'package:stuverse/features/mentor/widgets/request_card.dart';
import '../cubit/home/cubit/mentor_home_cubit.dart';
import '../routes/mentor_routes.dart';
import '../widgets/mentor_post_card.dart';

class MentorHomeScreen extends StatefulWidget {
  MentorHomeScreen({super.key});
  @override
  _MentorHomeScreenState createState() => _MentorHomeScreenState();
}

class _MentorHomeScreenState extends State<MentorHomeScreen> {
  void initState() {
    context.read<MentorHomeCubit>().getMentorHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return SingleChildScrollView(
      child: BgGradient(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<MentorHomeCubit>().getMentorHomeData();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightBox,
                Padding(
                    padding: context.paddingHorz,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Find Your',
                            style: context.headlineMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (user?.linkedin == null ||
                                  user?.mobile == null ||
                                  user?.github == null ||
                                  user?.about == null ||
                                  user?.experienceYears == null ||
                                  user?.skills == null) {
                                context.showMessage(
                                    message:
                                        "Please ensure your profile is complete before proceeding.");
                                return;
                              }
                              context.push(MentorRoutes.manageMentorPost);
                            },
                            icon: Icon(
                              Icons.add,
                            ),
                            iconSize: context.height * 0.03,
                          )
                        ],
                      ),
                      Text('Perfect Mentor',
                      style: context.headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  BannerCard(
                    title: 'Unlock Your Potential!',
                    description:
                        'Inspire and empower others with your knowledge. Join as a mentor today.',
                    buttonText: 'Join Now',
                    onTap: () {
                      context.showMessage(message: "Feature not available yet");
                    },
                  ),
                  SizedBox(height: 15),
                  Hero(
                    tag: 'search',
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          context.push(MentorRoutes.seeAllPosts);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27),
                            color: Color.fromARGB(242, 231, 230, 230),
                          ),
                          child: IgnorePointer(
                            ignoring: true,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                    ],
                  ),
                ),
                
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
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                  padding: context.paddingHorz,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Latest Mentorships',
                                          style: context.titleMedium!.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .push(MentorRoutes.seeAllPosts);
                                          },
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
                                  ),
                                10.heightBox,
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (final post in state.latestPosts)
                                          MentorPostCard(post: post),
                                      ],
                                    ),
                                  ),
                                  10.heightBox,
                                 Padding(
                                  padding: context.paddingHorz,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Requests',
                                          style: context.titleMedium!.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .push(MentorRoutes.seeAllPosts);
                                          },
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
                                  ),
                                  10.heightBox,
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                      RequestCard()
                                      ],
                                    ),
                                  ),
                                 
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
    );
  }
}
