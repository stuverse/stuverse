import 'package:go_router/go_router.dart';
import 'package:stuverse/features/mentor/mentor.dart';
import 'package:stuverse/features/mentor/models/mentor_post.dart';
import 'package:stuverse/features/mentor/models/mentor_request.dart';
import 'package:stuverse/features/mentor/views/manage_mentor_post.dart';
import 'package:stuverse/features/mentor/views/post_detail_screen.dart';
import 'package:stuverse/features/mentor/views/request_detail_screen.dart';

import 'package:stuverse/features/mentor/views/see_all_posts.dart';

import '../views/manage_mentor_request.dart';
import '../views/see_all_requests.dart';

class MentorRoutes {
  //! ---DO NOT MODIFY-----
  static const String mentorHome = '/mentor';
  static final GoRoute mentorHomeRoute = GoRoute(
    path: mentorHome,
    builder: (context, state) => MentorHomeScreen(),
  );
  //! ----------------

  static const String manageMentorPost = '/mentor/manageMentorPost';
  static const String seeAllPosts = '/mentor/seeAllPosts';
  static const String postDetails = '/mentor/postDetails';
  static const String requestDetails = '/mentor/requestDetails';
  static const String seeAllRequests = '/mentor/seeAllRequests';
  static const String manageMentorRequest = '/mentor/manageMentorRequest';

  static List<GoRoute> mentorRoutes = [
    GoRoute(
      path: '/mentor/manageMentorPost',
      builder: (context, state) => ManageMentorPostScreen(
        post: state.extra as MentorPost?,
      ),
    ),
    GoRoute(
      path: '/mentor/seeAllPosts',
      builder: (context, state) => seeAllPostsScreen(),
    ),
    GoRoute(
      path: '/mentor/postDetails',
      builder: (context, state) =>
          PostDetailsScreen(post: state.extra as MentorPost),
    ),
     GoRoute(
      path: '/mentor/requestDetails',
      builder: (context, state) =>
          RequestDetailsScreen(request: state.extra as MentorRequest),
    ),
     GoRoute(
      path: '/mentor/seeAllRequests',
      builder: (context, state) =>
          seeAllRequestsScreen(),
    ),
    GoRoute(
      path: '/mentor/manageMentorRequest',
      builder: (context, state) =>
          ManageMentorRequest(
            mentorRequest: state.extra as MentorRequest,
          ),
    ),
  ];
}
