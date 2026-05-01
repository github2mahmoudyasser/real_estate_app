import 'package:go_router/go_router.dart';
import 'package:realstateapp/shared/main_scaffold.dart';

import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/map/presentation/pages/map_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/booking/presentation/screens/request_to_book_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String favorites = '/favorites';
  static const String map = '/map';
  static const String history = '/history';
  static const String profile = '/profile';
  static const String payment = '/payment';
  static const String booking = '/booking';
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.booking,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: AppRoutes.favorites,
            builder: (context, state) => const FavoritesPage(),
          ),
          GoRoute(
            path: AppRoutes.map,
            builder: (context, state) => const MapPage(),
          ),
          GoRoute(
            path: AppRoutes.history,
            builder: (context, state) => const HistoryPage(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: AppRoutes.booking,
            builder: (context, state) => const RequestToBookScreen(),
          ),
        ],
      ),
    ],
  );
}
