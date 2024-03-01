import 'package:go_router/go_router.dart';
import 'package:stuverse/features/profile/profile.dart';

import '../views/profile_edit_screen.dart';

class ProfileRoutes {
  //! ---DO NOT MODIFY-----
  static const String profileHome = '/profile';
  static final GoRoute profileHomeRoute = GoRoute(
    path: profileHome,
    builder: (context, state) => const ProfileHomeScreen(),
  );
  //! ----------------

  static const String profileEdit = '/profile/edit';
  static List<GoRoute> profileRoutes = [
    GoRoute(
      path: profileEdit,
      builder: (context, state) => const ProfileEditScreen(),
    ),
    // GoRoute(
    //   path: '/mentor/manage',
    //   builder: (context, state) => const MentorManageScreen(),
    // ),
  ];
}
