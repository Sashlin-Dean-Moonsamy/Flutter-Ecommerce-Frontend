import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lux', style: TextStyle(color: Colors.white),)),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Icon(Icons.favorite, size: 50)),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white,),
              title: Text('Home', style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              }
            ),
            ListTile(
              leading: Icon(Icons.shop, color: Colors.white,),
              title: Text('Shop', style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.pushNamed(context, '/shop');
              }
            )
          ],
        ),
      ),

      body: Container(
      ),
    );
  }
}
