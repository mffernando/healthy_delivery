import 'package:flutter/material.dart';

import 'src/authentication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Delivery',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthy Delivery'),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 10),
          Image.asset(
              'assets/strawberry.png',
              height: 100,
              width: 100),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

