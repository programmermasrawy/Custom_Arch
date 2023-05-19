import 'package:flutter/material.dart';

import 'core/services/analytics.dart';
import 'core/view/router.dart';
import 'core/view/screens/splash.dart';

class AppRouter {
  AppRouter._();
  static Route onGenerateRoute(RouteSettings routeSettings) {
    Analytics.instance.logScreen(
      screenName: routeSettings.name,
      argments: routeSettings.arguments,
    );
    return CoreRouter.onGenerateRoute(routeSettings) ??
        // AuthRouter.onGenerateRoute(routeSettings) ??
        // HomeRouter.onGenerateRoute(routeSettings) ??
        //?This should never happen
        MaterialPageRoute(builder: (_) => const Splash());
  }
}
