import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logman/logman.dart';
import 'package:stuverse/app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/common/core/views/pdf_viewer_screen.dart';
import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/fund/fund.dart';
import 'package:stuverse/features/job/job.dart';
import 'package:stuverse/features/mentor/mentor.dart';
import 'package:stuverse/features/profile/profile.dart';

import '../common/auth/views/user_request_list_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _profileNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'profile');
  static final _forumNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'forum');
  static final _fundNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'fund');
  static final _jobNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'job');
  static final _mentorNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'mentor');

  static final unProtectedRoutes = [
    CommonRoutes.signin,
    CommonRoutes.signup,
    CommonRoutes.otpVerify,
    CommonRoutes.otpSignin,
    CommonRoutes.onBoarding,
    CommonRoutes.splash,
    CommonRoutes.webView,
  ];

  static final GoRouter _router = GoRouter(
    initialLocation: CommonRoutes.splash,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    observers: [
      LogmanNavigatorObserver(), // Navigator observer
    ],
    redirect: (ctx, state) {
      final coreState = ctx.read<CoreCubit>().state;

      if (coreState.user == null &&
          !unProtectedRoutes.contains(state.uri.path)) {
        ctx.read<CoreCubit>().setIsUserLoading(true);
        print(state.uri.path);
        return CommonRoutes.splash + "?from=${state.uri.path}";
      }
      return null;
    },
    routes: [
      ...CommonRoutes.commonRoutes,
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _forumNavigatorKey,
            initialLocation: ForumRoutes.forumHome,
            routes: [
              ForumRoutes.forumHomeRoute,
            ],
          ),
          StatefulShellBranch(
              navigatorKey: _fundNavigatorKey,
              initialLocation: FundRoutes.fundHome,
              routes: [
                FundRoutes.fundHomeRoute,
              ]),
          StatefulShellBranch(
            navigatorKey: _jobNavigatorKey,
            initialLocation: JobRoutes.jobHome,
            routes: [
              JobRoutes.jobHomeRoute,
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _mentorNavigatorKey,
            initialLocation: MentorRoutes.mentorHome,
            routes: [
              MentorRoutes.mentorHomeRoute,
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            initialLocation: ProfileRoutes.profileHome,
            routes: [
              GoRoute(
                path: ProfileRoutes.profileHome,
                builder: (context, state) {
                  return ProfileHomeScreen();
                },
              ),
            ],
          ),
        ],
      ),
      ...ForumRoutes.forumRoutes,
      ...FundRoutes.fundRoutes,
      ...JobRoutes.jobRoutes,
      ...MentorRoutes.mentorRoutes,
      ...ProfileRoutes.profileRoutes
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}
