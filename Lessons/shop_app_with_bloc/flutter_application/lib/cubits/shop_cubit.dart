import 'package:flutter/material.dart';
import 'package:flutter_application/cubits/shop_state.dart';
import 'package:flutter_application/models/shop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(InitialState());
  static List<Shop> products = [];
 

  Future<void> getProducts() async {
    try {
      emit(LoadingState());
      await Future.delayed(const Duration(seconds: 2));

      // products.add(
      //   Shop(
      //       id: "Shop1",
      //       title: "Birinchi product",
      //       imageUrl:
      //           "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg",
      //       price: 12.23),
      // );

      // throw("Xatolik");

      emit(LoadedState(products));
    } catch (e) {
      print("Xatolik sodir bo'ldi");
      emit(ErrorState("Rejalarni ololmadim"));
    }
  }

  Future<void> addProduct(
      String title, String id, String imageUrl, double price) async {
    try {
      if (state is LoadedState) {
        products = (state as LoadedState).products;
      }

      emit(LoadingState());
      await Future.delayed(const Duration(seconds: 2));
      // await ShopHttpService.getShops();

      products
          .add(Shop(id: id, title: title, imageUrl: imageUrl, price: price));
      emit(LoadedState(products));
    } catch (e) {
      print("Qo'shishda xatolik");
      emit(ErrorState("Qo'shishda xatolik"));
    }
  }

  Future<void> toggleFavorite(String id) async {
    products = (state as LoadedState).products;
    for (int i = 0; i < products.length; i++) {
      if (products[i].id == id) {
        products[i].isFavorite = !products[i].isFavorite;
      }
    }
    emit(LoadedState(products));
  }

  Future<void> deleteProduct(String id) async {
    products = (state as LoadedState).products;
    products.removeWhere((element) => element.id == id);
    emit(LoadedState(products));
  }

  Future<void> editProduct(
      String title, String id, String imageUrl, double price) async {
    try {
      if (state is LoadedState) {
        products = (state as LoadedState).products;
      }

      for (var element in products) {
        if (element.id == id) {
          element.title = title;
          element.price = price;
          element.imageUrl = imageUrl;
        }
      }
      emit(LoadedState(products));
    } catch (e) {
      emit(ErrorState("Qo'shishda xatolik"));
    }
  }



  // Future<void> deleteproduct(String id) async{

  // }
}
