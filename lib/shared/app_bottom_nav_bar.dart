import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:realstateapp/core/router/nav_items.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = navItems.indexWhere((item) => item.route == location);
    return NavigationBar(
      selectedIndex: currentIndex == -1 ? 0 : currentIndex,
      onDestinationSelected: (value) {
        context.go(navItems[value].route);
      },
      destinations: navItems.map((item) {
        return NavigationDestination(icon: Icon(item.icon), label: item.label);
      }).toList(),
    );
  }
}
