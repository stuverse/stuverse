import 'package:go_router/go_router.dart';
import 'package:stuverse/features/forum/forum.dart';

class ForumRoutes {
  static final String forumHome = '/forum/home';

  static final List<GoRoute> forumRoutes = [
    GoRoute(
      path: forumHome,
      builder: (context, state) => const ForumHomeScreen(),
    ),
    // GoRoute(
    //   path: '/mentor/detail',
    //   builder: (context, state) => const MentorDetailScreen(),
    // ),
    // GoRoute(
    //   path: '/mentor/manage',
    //   builder: (context, state) => const MentorManageScreen(),
    // ),
  ];
}
