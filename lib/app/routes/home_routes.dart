import 'package:go_router/go_router.dart';
import 'package:stuverse/features/home/home.dart';

class HomeRoutes {
  static const String home = '/home';

  static List<GoRoute> homeRoutes = [
    GoRoute(
      path: home,
      builder: (context, state) => const HomeScreen(),
    ),
  ];
}
