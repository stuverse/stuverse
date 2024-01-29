import 'package:go_router/go_router.dart';
import 'package:stuverse/features/fund/fund.dart';

class FundRoutes {
  static const String fundHome = '/fund/home';

  static List<GoRoute> fundRoutes = [
    GoRoute(
      path: fundHome,
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
}
