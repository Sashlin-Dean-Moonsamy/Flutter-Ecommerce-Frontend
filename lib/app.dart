import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lux/ui/screens/home.dart';
import 'package:lux/ui/screens/login_screen.dart';
import 'package:lux/providers/auth_provider.dart';
import 'core/routes.dart';
import 'core/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: lightMode, // Light Theme with cream and gold
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return auth.isAuthenticated ? const Home() : const LoginScreen();
        },
      ),
      onGenerateRoute: RouteNames().generateRoute,
    );
  }
}