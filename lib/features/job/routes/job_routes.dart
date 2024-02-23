import 'package:go_router/go_router.dart';
import 'package:stuverse/features/job/job.dart';

import 'package:stuverse/features/job/views/home/job_search_screen.dart';

import '../models/job_post.dart';
import '../views/add-edit/add_edit_job_post.dart';
import '../views/detail/job_detail_screen.dart';

class JobRoutes {
  static const String jobAddEdit = '/job/add-edit';
  static const String jobDetail = '/job/detail';
  static const String jobSearch = '/job/search';

  static List<GoRoute> jobRoutes = [
    GoRoute(
        path: jobAddEdit,
        builder: (context, state) => AddEditJobPostScreen(
              post: state.extra as JobPost?,
            )),
    GoRoute(
      path: jobDetail,
      builder: (context, state) => JobDetailScreen(
        post: state.extra as JobPost,
      ),
    ),
    GoRoute(
      path: jobSearch,
      builder: (context, state) => const JobSearchScreen(),
    )

    // GoRoute(
    //   path: '/mentor/manage',
    //   builder: (context, state) => const MentorManageScreen(),
    // ),
  ];

  //! ---DO NOT MODIFY-----
  static const String jobHome = '/job';
  static final GoRoute jobHomeRoute = GoRoute(
    path: jobHome,
    builder: (context, state) => const JobHomeScreen(),
  );
  //! ----------------
}
