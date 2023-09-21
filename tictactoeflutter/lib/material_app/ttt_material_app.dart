import 'package:flutter/material.dart';
import 'package:tictactoeflutter/home_page/home_page.dart';

class TTTMaterialApp extends StatelessWidget {
  const TTTMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple,brightness: Brightness.dark),useMaterial3: true),
      home: const Scaffold(body: HomePage()),
    );
  }
}
