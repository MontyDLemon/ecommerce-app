import 'package:flutter/material.dart';

import 'pages/authentication_page/authentication_page.dart';
import 'pages/get_started_page.dart';
import 'pages/launch_page.dart';

class AppRouter {
  static const auth = "auth";
  static const launch = "launch";

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute<void>(
          builder: (context) => const GetStartedPage(),
        );
      case "launch":
        return MaterialPageRoute<void>(
          builder: (context) => const LaunchPage(),
        );
      default:
        return MaterialPageRoute<void>(
          builder: (_) => const AuthenticationPage(),
        );
    }
  }
}
