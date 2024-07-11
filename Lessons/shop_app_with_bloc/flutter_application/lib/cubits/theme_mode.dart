import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitThemeMode extends Cubit<bool> {
  CubitThemeMode() : super(false);

  void toggleThemeMode() {
   
    emit(!state);
  }
}
