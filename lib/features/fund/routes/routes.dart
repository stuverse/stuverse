import 'package:go_router/go_router.dart';

import '../fund.dart';

final List<GoRoute> fundRoutes = [
  GoRoute(
    path: FundHomeScreen.routeName,
    builder: (context, state) => const FundHomeScreen(),
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
