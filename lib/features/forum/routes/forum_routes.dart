import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/forum/views/community/show_all_communities_screen.dart';

import '../views/community/community_add_edit_screen.dart';
import '../views/community/community_admin_screen.dart';
import '../views/community/community_detail_screen.dart';
import '../views/community/community_members_manage.dart';
import '../views/thread/thread_add_edit_screen.dart';
import '../views/thread/thread_detail_screen.dart';

class ForumRoutes {
  //! ---DO NOT MODIFY-----
  static final String forumHome = '/forum';
  static final GoRoute forumHomeRoute = GoRoute(
    path: forumHome,
    builder: (context, state) => const ForumHomeScreen(),
  );
  //! ----------------

  static final String threadDetail = '/forum/thread/details/:id';
  static final String communityDetail = '/forum/community/details/:id';
  static final String communityManage = '/forum/community/manage';
  static final String communityAddEdit = '/forum/community/add-edit';
  static final String allCommunities = '/forum/community/all';

  static final String threadAddEdit = '/forum/thread/add-edit';
  static const String communityMembersManageScreen =
      '/manage-community-members';
  static final List<GoRoute> forumRoutes = [
    GoRoute(
      path: threadDetail,
      onExit: (context) {
        context.read<HomeCubit>().getHomeData();
        return true;
      },
      builder: (context, state) => ThreadDetailScreen(
        threadId: int.tryParse(state.pathParameters['id'] ?? "N/A"),
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
        ],
        child: CommunityDetailScreen(
          communityId: int.tryParse(state.pathParameters['id'] ?? "N/A"),
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
    GoRoute(
      path: threadAddEdit,
      builder: (context, state) => BlocProvider(
        create: (context) => ThreadManageCubit(),
        child: ThreadAddEditScreen(
          props: state.extra as ThreadAddEditScreenProps,
        ),
      ),
    ),
    GoRoute(
      path: allCommunities,
      builder: (context, state) => ShowAllCommunitiesScreen(
        yourCommunity: state.extra as bool,
      ),
    ),
    GoRoute(
      path: communityMembersManageScreen,
      builder: (context, state) => CommunityMembersManageScreen(
        communityId: state.extra as int,
      ),
    ),
  ];
}
