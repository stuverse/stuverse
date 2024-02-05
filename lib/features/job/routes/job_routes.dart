import 'package:go_router/go_router.dart';
import 'package:stuverse/features/job/job.dart';

class JobRoutes {
  //! ---DO NOT MODIFY-----
  static const String jobHome = '/job';
  static final GoRoute jobHomeRoute = GoRoute(
    path: jobHome,
    builder: (context, state) => const JobHomeScreen(),
  );
  //! ----------------

  static List<GoRoute> jobRoutes = [
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
