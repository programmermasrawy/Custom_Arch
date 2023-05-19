import 'package:flutter/material.dart';
import 'screens/choose_language.dart';
import 'screens/service_not_available_screen.dart';
import 'screens/splash.dart';
import 'screens/update_screen.dart';
import 'screens/walkthrough.dart';

class CoreRouter {
  CoreRouter._();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Splash.id:
        return MaterialPageRoute(
          builder: (_) => const Splash(),
          settings: routeSettings,
        );
      case ChooseLanguageScreen.id:
        return MaterialPageRoute(
          builder: (_) => const ChooseLanguageScreen(),
          settings: routeSettings,
        );
      case WalkthroughScreen.id:
        return MaterialPageRoute(
          builder: (_) => const WalkthroughScreen(),
          settings: routeSettings,
        );
      case UpdateScreen.id:
        return MaterialPageRoute(
          builder: (_) => const UpdateScreen(),
          settings: routeSettings,
        );
      case ServiceNotAvailableScreen.id:
        return MaterialPageRoute(
          builder: (_) => const ServiceNotAvailableScreen(),
          settings: routeSettings,
        );

      default:
        return null;
    }
  }
}
