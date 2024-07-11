import 'package:bloc/bloc.dart';

class CubitController extends Cubit<int> {
  CubitController() : super(0);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    emit(state - 1);
  }
}
