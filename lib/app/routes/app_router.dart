import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/features/common/common.dart';

import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/fund/fund.dart';
import 'package:stuverse/features/job/job.dart';
import 'package:stuverse/features/mentor/mentor.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: SplashScreen.routeName,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: SignInScreen.routeName,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: SignUpScreen.routeName,
        builder: (context, state) => SignUpScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(routes: forumRoutes),
          StatefulShellBranch(
            routes: fundRoutes,
          ),
          StatefulShellBranch(routes: jobRoutes),
          StatefulShellBranch(
            routes: mentorRoutes,
          ),
        ],
      ),
      GoRoute(
        path: SplashScreen.routeName,
        builder: (context, state) => SplashScreen(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}
