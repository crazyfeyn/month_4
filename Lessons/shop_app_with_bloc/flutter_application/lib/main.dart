import 'package:flutter/material.dart';
import 'package:flutter_application/cubits/shop_cubit.dart';
import 'package:flutter_application/cubits/theme_mode.dart';
import 'package:flutter_application/views/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) {
          return CubitThemeMode();
        },),
        BlocProvider(create:(context) {
          return ShopCubit();
        },),
      ],
      child: BlocBuilder<CubitThemeMode, bool>(
        builder: (context, theme) {
          return MaterialApp(
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            themeMode:theme ? ThemeMode.dark : ThemeMode.light,
            home: HomeScreen(),
          );
        }
      ),
    );
  }
}
