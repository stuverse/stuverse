import 'package:go_router/go_router.dart';

import '../forum.dart';

final List<GoRoute> forumRoutes = [
  GoRoute(
    path: ForumHomeScreen.routeName,
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
