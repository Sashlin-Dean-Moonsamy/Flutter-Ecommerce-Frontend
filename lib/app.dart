import 'package:flutter/material.dart';
import 'package:lux/ui/screens/home.dart';
import 'core/routes.dart';
import 'core/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'E-Commerce App',
      theme: lightMode, // Light Theme with cream and gold
      home: const Home(),
      onGenerateRoute: RouteNames().generateRoute,
    );
  }
}