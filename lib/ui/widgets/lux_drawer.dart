import 'package:flutter/material.dart';

class LuxDrawer extends StatelessWidget{
  const LuxDrawer({super.key});

  @override
  Widget build(BuildContext context){
    return  Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(Icons.favorite, size: 50),
          ),
          _buildDrawerItem(context, Icons.home, "Home", '/home'),
          _buildDrawerItem(context,Icons.shop, "Shop", '/shop'),
          _buildDrawerItem(context, Icons.phone, "Contact", '/contact'),
        ],
      ),
    );
  }

  // Drawer item builder
  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}