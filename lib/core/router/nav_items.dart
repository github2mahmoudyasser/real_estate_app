import 'package:flutter/material.dart';
import 'package:realstateapp/core/router/app_router.dart';

class NavItems {
  final String label;
  final IconData icon;
  final String route;

  const NavItems({
    required this.label,
    required this.icon,
    required this.route,
  });
}

const navItems = [
  NavItems(label: 'Home', icon: Icons.home_rounded, route: AppRoutes.home),
  NavItems(
    label: 'Favorites',
    icon: Icons.favorite_rounded,
    route: AppRoutes.favorites,
  ),
  NavItems(label: 'Map', icon: Icons.map_rounded, route: AppRoutes.map),
  NavItems(label: 'History', icon: Icons.history, route: AppRoutes.history),
  NavItems(
    label: 'Profile',
    icon: Icons.person_rounded,
    route: AppRoutes.profile,
  ),
];
