import 'package:go_router/go_router.dart';
import 'package:stuverse/features/profile/profile.dart';
import 'package:stuverse/features/profile/views/delete_account.dart';
import 'package:stuverse/features/profile/views/reset_password.dart';

import '../views/manage_profile.dart';

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
      builder: (context, state) => const DeleteAccount(),
    ),
    GoRoute(
      path: resetPassword,
      builder: (context, state) => const ResetAccountPassword(),
    ),
  ];

  // GoRoute(
  //   path: '/mentor/manage',
  //   builder: (context, state) => const MentorManageScreen(),
  // ),
}
