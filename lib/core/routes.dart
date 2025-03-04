import 'package:flutter/material.dart';
import 'package:lux/ui/screens/home.dart';
import 'package:lux/ui/screens/login.dart';
import 'package:lux/ui/screens/profile.dart';

// Define route names as constants
class RouteNames {
  static const String home = '/home';
  static const String login = '/login';
  static const String profile = '/profile';
}

// Define a routes map
final Map<String, WidgetBuilder> routes = {
  RouteNames.home: (context) => Home(),
  RouteNames.login: (context) => Login(),
  RouteNames.profile: (context) => Profile(),
};

// Optional: Route generator function
Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.home:
      return MaterialPageRoute(builder: (_) => Home());
    case RouteNames.login:
      return MaterialPageRoute(builder: (_) => Login());
    case RouteNames.profile:
      return MaterialPageRoute(builder: (_) => Profile());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ));
  }
}
