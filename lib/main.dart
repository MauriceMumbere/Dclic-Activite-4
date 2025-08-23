import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.pink,
        // Title
        title: Text('Magazine Infos', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        // Leading
        leading: IconButton(
          onPressed: () {},
          icon: Icon(color: Colors.white, Icons.menu),
        ),
        // Action
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(color: Colors.white, Icons.search),
          ),
        ],
      ),
      // Body
      body: Center(child: Image.asset("assets/images/magazin-infos.jpg")),
      // floatingActionButton
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {},
        child: const Text('Click'),
      ),
    );
  }
}
