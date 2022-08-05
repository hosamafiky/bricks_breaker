import 'package:bricks_breaker_game/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bricks Breaker Game',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
