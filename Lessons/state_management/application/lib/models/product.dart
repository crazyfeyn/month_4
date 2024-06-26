import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  String id;
  String title;
  Color color;
  double price;

  Product({
    required this.id,
    required this.title,
    required this.color,
    required this.price,
  });

  List<Product> orderList = [];

  // void addOrder(Product product) {
  //   orderList.add(product);
  //   notifyListeners();
  // }

  // void deleteOrder(Product product) {
  //   orderList.remove(product);
  //   notifyListeners();
  // }
}
