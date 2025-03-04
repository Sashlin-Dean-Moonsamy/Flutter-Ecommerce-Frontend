import 'package:flutter/material.dart';
import 'package:lux/ui/screens/home.dart';
import 'package:lux/ui/screens/shop.dart';
import 'core/routes.dart';
import 'core/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'E-Commerce App',
      theme: LuxTheme,  // Light Theme with cream and gold
      home: const Home(),
      routes: {
        '/shop': (context) => const Shop(),
      },
    );
  }
}