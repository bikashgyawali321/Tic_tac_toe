import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.grey),
      initialRoute: '/',
      routes: {'/': (context) => const HomeScreen()},
      // home: const HomeScreen() ,
      title: 'Tic Tac Toe',
    );
  }
}
