import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/common/auth/views/users_list_screen.dart';

import '../auth/views/user_manage_screen.dart';

class CommonRoutes {
  static const String otpVerify = '/otp-verify';
  static const String otpSignin = '/otp-signin';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String onBoarding = '/onboarding';
  static const String splash = '/';
  static const String notFound = '/not-found';
  static const String webView = '/web-view';
  static const String markdownEditor = '/markdown-editor';
  static const String userRequest = '/user-request';
  static const String pdfViewer = '/pdf-viewer';
  static const String usersSelection = '/users-selection';
  static const String userManage = '/user-manage';
  static const String usersList = '/users-list';

  static final List<GoRoute> commonRoutes = [
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
      builder: (context, state) => SplashScreen(
        from: state.uri.queryParameters['from'],
      ),
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
    GoRoute(
      path: CommonRoutes.usersSelection,
      builder: (context, state) => UsersSelectionScreen(
        onSubmit: state.extra as Function(List<MiniUser>),
      ),
    ),
    GoRoute(
      path: CommonRoutes.userManage,
      builder: (context, state) => UserManageScreen(),
    ),
    GoRoute(
      path: CommonRoutes.usersList,
      builder: (context, state) => UsersListScreen(),
    ),
  ];
}
