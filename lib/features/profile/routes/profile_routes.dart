import 'package:go_router/go_router.dart';
import 'package:stuverse/features/profile/profile.dart';

class ProfileRoutes {
  //! ---DO NOT MODIFY-----
  static const String profileHome = '/profile';
  static final GoRoute profileHomeRoute = GoRoute(
    path: profileHome,
    builder: (context, state) => const ProfileHomeScreen(),
  );
  //! ----------------

  static List<GoRoute> profileRoutes = [
    // GoRoute(
    //   path: '/mentor/detail',
    //   builder: (context, state) => const MentorDetailScreen(),
    // ),
    // GoRoute(
    //   path: '/mentor/manage',
    //   builder: (context, state) => const MentorManageScreen(),
    // ),
  ];
}
