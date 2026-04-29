
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstateapp/feature/home_screen/presentation/ui/home_view.dart';
import 'package:realstateapp/feature/onboarding_screen/ui/onboarding_screen.dart';
import '../../feature/login_screen/presentation/cubit/login_cubit.dart';
import '../../feature/login_screen/presentation/ui/login_view.dart'; // مسار شاشتك
import '../../feature/splash_screen/ui/splash_screen.dart';
import '../di/service_locator.dart'; // ملف الـ sl

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case '/splash':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case '/onboard':
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );


      case '/login':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<LoginCubit>(),
            child: const LoginView(),
          ),
        );

      case '/home':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<LoginCubit>(),
            child: const HomeView(),
          ),
        );
      default:
        return null;
    }
  }
}