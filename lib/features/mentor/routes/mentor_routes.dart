import 'package:go_router/go_router.dart';
import 'package:stuverse/features/mentor/mentor.dart';
import 'package:stuverse/features/mentor/models/mentor_post.dart';
import 'package:stuverse/features/mentor/views/mentor_details_screen.dart';

class MentorRoutes {
  //! ---DO NOT MODIFY-----
  static const String mentorHome = '/mentor';
  static final GoRoute mentorHomeRoute = GoRoute(
    path: mentorHome,
    builder: (context, state) =>  MentorHomeScreen(),
  );
  //! ----------------

  static const String mentorDetails= '/mentor/details';

  static List<GoRoute> mentorRoutes = [
    GoRoute(
      path: '/mentor/details',
      builder: (context, state) =>  MentorDetailsScreen(
        post: state.extra as MentorPost,
      ),
    ),
    // GoRoute(
    //   path: '/mentor/manage',
    //   builder: (context, state) => const MentorManageScreen(),
    // ),
  ];
}
