import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

import '../views/thread/thread_detail_screen.dart';

class ForumRoutes {
  //! ---DO NOT MODIFY-----
  static final String forumHome = '/forum';
  static final GoRoute forumHomeRoute = GoRoute(
    path: forumHome,
    builder: (context, state) => const ForumHomeScreen(),
  );
  //! ----------------

  static final String threadDetail = '/forum/thread';
  static final List<GoRoute> forumRoutes = [
    GoRoute(
      path: threadDetail,
      onExit: (context) {
        context.read<HomeCubit>().getHomeData();
        return true;
      },
      builder: (context, state) => ThreadDetailScreen(
        thread: state.extra as Thread,
      ),
    ),
    // GoRoute(
    //   path: '/mentor/manage',
    //   builder: (context, state) => const MentorManageScreen(),
    // ),
  ];
}
