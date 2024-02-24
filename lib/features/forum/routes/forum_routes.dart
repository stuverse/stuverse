import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

import 'package:stuverse/features/forum/forum.dart';

import '../models/community/community.dart';
import '../views/community/community_add_edit_screen.dart';
import '../views/community/community_admin_screen.dart';
import '../views/community/community_detail_screen.dart';
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
  static final String communityDetail = '/forum/community';
  static final String communityManage = '/forum/community/manage';
  static final String communityAddEdit = '/forum/community/add-edit';

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
    GoRoute(
      path: communityDetail,
      onExit: (context) {
        // context.read<HomeCubit>().getHomeData();
        return true;
      },
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<CommunityManageCubit>(
            create: (context) => CommunityManageCubit(),
          ),
          BlocProvider<CommunityDetailCubit>(
            create: (context) => CommunityDetailCubit(),
          ),
        ],
        child: CommunityDetailScreen(
          community: state.extra as Community,
        ),
      ),
    ),
    GoRoute(
      path: communityManage,
      builder: (context, state) => const CommunityAdminScreen(),
    ),
    GoRoute(
      path: communityAddEdit,
      builder: (context, state) => BlocProvider(
        create: (context) => CommunityManageCubit(),
        child: CommunityAddEditScreen(
          community: state.extra as Community?,
        ),
      ),
    ),
  ];
}
