import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:lux/providers/cart_provider.dart'; // Import your CartProvider
import 'package:lux/providers/auth_provider.dart';
import 'app.dart'; // Your app widget

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const MyApp(), // Your root app widget
    ),
  );
}
