import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/cubit_controller.dart';
import 'package:flutter_application/views/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocProvider(
      create: (context) {
        return CubitController();
      },
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
    );
   
  }
}
