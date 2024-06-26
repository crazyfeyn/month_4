import 'package:application/models/product.dart';
import 'package:flutter/material.dart';

class ProductsController extends ChangeNotifier {
  final List<Product> _list = [
    Product(
      id: UniqueKey().toString(),
      title: "iPhone",
      color: Colors.teal,
      price: 340.5,
    ),
    Product(
      id: UniqueKey().toString(),
      title: "Macbook",
      color: Colors.grey,
      price: 1340.5,
    ),
    Product(
      id: UniqueKey().toString(),
      title: "AirPods",
      color: Colors.blue,
      price: 140.5,
    ),
  ];

  List<Product> get list {
    return [..._list];
  }

  void deleteProduct(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void addOrder(Product product) {
    _list.add(product);
  }

  // void removeOrder(Product product) {
  //   _list.add(product);
  // }
}
