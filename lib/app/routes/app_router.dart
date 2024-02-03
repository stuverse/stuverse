import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/routes/home_routes.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'home');
  static final _forumNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'forum');
  static final _fundNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'fund');
  static final _jobNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'job');
  static final _mentorNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'mentor');

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
        path: CommonRoutes.otpVerify,
        builder: (context, state) => OtpVerifyScreen(
          email: (state.extra as String?) ?? '',
        ),
      ),
      GoRoute(
        path: CommonRoutes.onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: CommonRoutes.otpSignin,
        builder: (context, state) => OtpSigningScreen(
          email: state.extra as String?,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            initialLocation: HomeRoutes.home,
            routes: HomeRoutes.homeRoutes,
          ),
          StatefulShellBranch(
            navigatorKey: _forumNavigatorKey,
            initialLocation: ForumRoutes.forumHome,
            routes: ForumRoutes.forumRoutes,
          ),
          StatefulShellBranch(
            navigatorKey: _fundNavigatorKey,
            initialLocation: FundRoutes.fundHome,
            routes: FundRoutes.fundRoutes,
          ),
          StatefulShellBranch(
            navigatorKey: _jobNavigatorKey,
            initialLocation: JobRoutes.jobHome,
            routes: JobRoutes.jobRoutes,
          ),
          StatefulShellBranch(
            navigatorKey: _mentorNavigatorKey,
            initialLocation: MentorRoutes.mentorHome,
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
