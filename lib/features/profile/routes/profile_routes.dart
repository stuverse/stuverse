import 'package:go_router/go_router.dart';
import 'package:stuverse/features/profile/profile.dart';
import 'package:stuverse/features/profile/views/delete_account_screen.dart';
import 'package:stuverse/features/profile/views/reset_password_screen.dart';

import '../views/manage_profile_screen.dart';

class ProfileRoutes {
  //! ---DO NOT MODIFY-----
  static const String profileHome = '/profile';

  static final GoRoute profileHomeRoute = GoRoute(
    path: profileHome,
    builder: (context, state) => const ProfileHomeScreen(),
  );
  //! ----------------

  static const String profileEdit = '/profile/edit';
  static const String profileDelete = '/profile/delete';
  static const String resetPassword = '/profile/reset-password';
  static List<GoRoute> profileRoutes = [
    GoRoute(
      path: profileEdit,
      builder: (context, state) => const ManageProfileScreen(),
    ),
    GoRoute(
      path: profileDelete,
      builder: (context, state) => const DeleteAccountScreen(),
    ),
    GoRoute(
      path: resetPassword,
      builder: (context, state) => const ResetAccountPasswordScreen(),
    ),
  ];

  // GoRoute(
  //   path: '/mentor/manage',
  //   builder: (context, state) => const MentorManageScreen(),
  // ),
}
