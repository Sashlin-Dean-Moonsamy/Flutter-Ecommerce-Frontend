import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:lux/providers/cart_provider.dart'; // Import your CartProvider
import 'app.dart'; // Your app widget

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(), // Provide CartProvider here
      child: const MyApp(), // Your root app widget
    ),
  );
}
