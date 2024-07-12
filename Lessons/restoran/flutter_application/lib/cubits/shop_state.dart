//! InitialState - boshlang'ich holat
//! LoadingState - yuklanish holati
//! LoadedState - yuklanib bo'lgan holati
//! ErrorState - xatolik holati


import 'package:flutter_application/models/shop.dart';

sealed class ShopState {}

final class InitialState extends ShopState {}

final class LoadingState extends ShopState {}

final class LoadedState extends ShopState {
  List<Shop> products = [];

  LoadedState(this.products);
}

final class ErrorState extends ShopState {
  String message;

  ErrorState(this.message);
}