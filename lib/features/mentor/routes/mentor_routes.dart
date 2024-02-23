import 'package:go_router/go_router.dart';
import 'package:stuverse/features/mentor/mentor.dart';
import 'package:stuverse/features/mentor/models/mentor_post.dart';
import 'package:stuverse/features/mentor/views/add_edit_post_screen.dart';

class MentorRoutes {
  //! ---DO NOT MODIFY-----
  static const String mentorHome = '/mentor';
  static final GoRoute mentorHomeRoute = GoRoute(
    path: mentorHome,
    builder: (context, state) => MentorHomeScreen(),
  );
  //! ----------------

  static const String addMentor = '/mentor/addPost';

  static List<GoRoute> mentorRoutes = [
    GoRoute(
      path: '/mentor/addPost',
      builder: (context, state) => AddEditPostScreen(
        post: state.extra as MentorPost?,
      ),
    ),
    //   // GoRoute(
    //   //   path: '/mentor/manage',
    //   //   builder: (context, state) => const MentorManageScreen(),
    //   // ),
  ];
}
