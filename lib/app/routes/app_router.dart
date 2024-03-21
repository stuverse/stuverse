import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/forum/views/community/community_members_manage.dart';
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
  ];

  static final GoRouter _router = GoRouter(
    initialLocation: CommonRoutes.splash,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    redirect: (ctx, state) {
      final user = ctx.read<CoreCubit>().state.user;
      if (user == null && !unProtectedRoutes.contains(state.uri.path)) {
        return CommonRoutes.signin;
      }
      return null;
    },
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
      GoRoute(
        path: CommonRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
          path: CommonRoutes.webView,
          redirect: (context, state) {
            if (state.extra == null) {
              return CommonRoutes.notFound;
            }
            return null;
          },
          builder: (context, state) => WebViewScreen(
                url: (state.extra as String?) ?? "",
              )),
      GoRoute(
          path: CommonRoutes.pdfViewer,
          redirect: (context, state) {
            if (state.extra == null) {
              return CommonRoutes.notFound;
            }
            return null;
          },
          builder: (context, state) => PdfViewerScreen(
                path: (state.extra as String?) ?? "",
              )),
      GoRoute(
        path: CommonRoutes.markdownEditor,
        redirect: (context, state) {
          if (state.extra == null) {
            return CommonRoutes.notFound;
          }
          return null;
        },
        builder: (context, state) =>
            MarkDownScreen(props: state.extra as MarkDownScreenProps),
      ),
      GoRoute(
        path: CommonRoutes.userRequest,
        builder: (context, state) => const UserRequestListScreen(),
      ),
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
