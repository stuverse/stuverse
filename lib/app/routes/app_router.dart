import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/features/common/auth/views/email_otp_screen.dart';
import 'package:stuverse/features/common/auth/views/forgot_password_screen.dart';
import 'package:stuverse/features/common/common.dart';
import 'package:stuverse/features/common/core/views/onboarding_screen.dart';

import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/fund/fund.dart';
import 'package:stuverse/features/job/job.dart';
import 'package:stuverse/features/mentor/mentor.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: EmailOtpScreen.routeName,
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
      GoRoute(
        path: EmailOtpScreen.routeName,
        builder: (context, state) => EmailOtpScreen(),
      ),
      GoRoute(
        path: OnBoardingScreen.routeName,
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: ForgotPasswordScreen.routeName,
        builder: (context, state) => ForgotPasswordScreen(),
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
