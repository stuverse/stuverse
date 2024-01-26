import 'package:go_router/go_router.dart';

import '../job.dart';

final List<GoRoute> jobRoutes = [
  GoRoute(
    path: JobHomeScreen.routeName,
    builder: (context, state) => const JobHomeScreen(),
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
