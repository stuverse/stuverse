import 'package:go_router/go_router.dart';
import 'package:stuverse/features/job/job.dart';

class JobRoutes {
  static const String jobHome = '/job/home';

  static List<GoRoute> jobRoutes = [
    GoRoute(
      path: jobHome,
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
}
