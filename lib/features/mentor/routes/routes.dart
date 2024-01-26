import 'package:go_router/go_router.dart';

import '../mentor.dart';

final List<GoRoute> mentorRoutes = [
  GoRoute(
    path: MentorHomeScreen.routeName,
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
