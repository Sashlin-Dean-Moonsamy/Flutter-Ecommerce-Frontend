import 'package:flutter/material.dart';
import 'package:lux/ui/screens/home.dart';
import 'package:lux/ui/screens/contact.dart';
import 'package:lux/ui/screens/shop.dart';

// Define route names as constants
class RouteNames {
  static const String home = '/home';
  static const String shop = '/shop';
  static const String contact = '/contact';

// Define a routes map
  final Map<String, WidgetBuilder> routes = {
    home: (context) => Home(),
    shop: (context) => Shop(),
    contact: (context) => Contact(),
  };

// Optional: Route generator function
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case RouteNames.shop:
        return MaterialPageRoute(builder: (_) => Shop());
      case RouteNames.contact:
        return MaterialPageRoute(builder: (_) => Contact());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}