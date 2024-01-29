import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: CommonRoutes.splash,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: CommonRoutes.signin,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: CommonRoutes.signup,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: CommonRoutes.emailOtp,
        builder: (context, state) => const EmailOtpScreen(),
      ),
      GoRoute(
        path: CommonRoutes.onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: CommonRoutes.otpSignin,
        builder: (context, state) => OtpSigningScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: ForumRoutes.forumRoutes,
          ),
          StatefulShellBranch(
            routes: ForumRoutes.forumRoutes,
          ),
          StatefulShellBranch(
            routes: JobRoutes.jobRoutes,
          ),
          StatefulShellBranch(
            routes: MentorRoutes.mentorRoutes,
          ),
        ],
      ),
      GoRoute(
        path: CommonRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}
