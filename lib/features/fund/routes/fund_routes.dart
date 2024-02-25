import 'package:go_router/go_router.dart';
import 'package:stuverse/features/fund/fund.dart';
import 'package:stuverse/features/fund/views/project_desc.dart';

class FundRoutes {
  //! ---DO NOT MODIFY-----
  static const String fundHome = '/fund';
  static final GoRoute fundHomeRoute = GoRoute(
    path: fundHome,
    builder: (context, state) => const FundHomeScreen(),
  );
  //! ----------------

  static List<GoRoute> fundRoutes = [
    GoRoute(
      path: '/fund/projectdesc',
      builder: (context, state) => const ProjectDescScreen(),
    ),
    // GoRoute(
    //   path: '/mentor/manage',
    //   builder: (context, state) => const MentorManageScreen(),
    // ),
  ];
}
