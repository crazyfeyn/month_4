import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/models/product.dart';

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

  void addProduct(String title, double price) {
    _list.add(Product(
        id: UniqueKey().toString(),
        title: title,
        color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
            Random().nextInt(255), Random().nextInt(255)),
        price: price));
    notifyListeners();
  }

  void editProduct(String id, String newTitle, double newPrice) {
    for (var i = 0; i < _list.length; i++) {
      if (_list[i].id == id) {
        _list[i].title = newTitle;
        _list[i].price = newPrice;
      }
    }
    notifyListeners();
  }

  void deleteProduct(String id) {
    for (var i = 0; i < _list.length; i++) {
      if (_list[i].id == id) {
        _list.removeAt(i);
        break;
      }
    }
    notifyListeners();
  }
}
