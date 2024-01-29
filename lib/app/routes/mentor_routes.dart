import 'package:go_router/go_router.dart';
import 'package:stuverse/features/mentor/mentor.dart';

class MentorRoutes {
  static const String mentorHome = '/mentor/home';

  static List<GoRoute> mentorRoutes = [
    GoRoute(
      path: mentorHome,
      builder: (context, state) => const MentorHomeScreen(),
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
