import 'package:flutter/material.dart';
import 'mission_screen.dart';

void main() {
  runApp(const SnapRushApp());
}

class SnapRushApp extends StatelessWidget {
  const SnapRushApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapRush',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MissionScreen(),
    );
  }
}