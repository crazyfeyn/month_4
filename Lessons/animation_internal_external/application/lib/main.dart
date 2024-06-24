import 'package:application/external_animation.dart';
import 'package:application/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData theme = ThemeData.light();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      // theme = ThemeData.dark();
      // setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: AnimatedTheme(
          data: theme,
          duration: Duration(seconds: 2),
          child: ExternalAnimation()),
    );
  }
}
