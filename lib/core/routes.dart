import 'package:flutter/material.dart';
import 'package:lux/ui/screens/home.dart';
import 'package:lux/ui/screens/cart.dart';
import 'package:lux/ui/screens/shop.dart';
import 'package:lux/ui/screens/detail.dart';
import 'package:lux/models/product.dart';

// Define route names as constants
class RouteNames {
  static const String home = '/home';
  static const String shop = '/shop';
  static const String cart = '/cart';
  static const String detail = '/detail';

  // Define a routes map
  final Map<String, WidgetBuilder> routes = {
    home: (context) => Home(),
    shop: (context) => Shop(),
    cart: (context) => Cart(),
  };

  // Optional: Route generator function
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case shop:
        return MaterialPageRoute(builder: (_) => Shop());
      case cart:
        return MaterialPageRoute(builder: (_) => Cart());
      case detail:
        final product = settings.arguments as Product?;
        if (product != null) {
          return MaterialPageRoute(builder: (_) => Detail(product: product));
        }
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No product found for detail route')),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
