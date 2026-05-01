import 'package:go_router/go_router.dart';
import 'package:realstateapp/feature/favorites/presentation/pages/favorites_page.dart';
import 'package:realstateapp/feature/history/presentation/pages/history_page.dart';
import 'package:realstateapp/feature/home/presentation/pages/home_page.dart';
import 'package:realstateapp/feature/map/presentation/pages/map_page.dart';
import 'package:realstateapp/feature/profile/presentation/pages/profile_page.dart';
import 'package:realstateapp/shared/main_scaffold.dart';

class AppRoutes {
  static const String home = '/';
  static const String favorites = '/favorites';
  static const String map = '/map';
  static const String history = '/history';
  static const String profile = '/profile';
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(path: AppRoutes.home, builder: (_, _) => const HomePage()),
          GoRoute(
            path: AppRoutes.favorites,
            builder: (_, _) => const FavoritesPage(),
          ),
          GoRoute(path: AppRoutes.map, builder: (_, _) => const MapPage()),
          GoRoute(
            path: AppRoutes.history,
            builder: (_, _) => const HistoryPage(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (_, _) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}
