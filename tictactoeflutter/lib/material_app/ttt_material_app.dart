import 'package:flutter/material.dart';
import 'package:tictactoeflutter/home_page/home_page.dart';

class TTTMaterialApp extends StatelessWidget {
  const TTTMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage(),);
  }
}