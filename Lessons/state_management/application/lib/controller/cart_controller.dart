import 'package:application/models/cart.dart';
import 'package:application/models/product.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  final Cart _cart = Cart(products: {}, totalPrice: 0);

  Cart get cart {
    return _cart;
  }

  Cart get orders {
    return _orders;
  }

  final Cart _orders = Cart(
    products: {},
    totalPrice: 0,
  );


  void addOrder() {
    if (_cart.products.isNotEmpty) {
      _orders.products.addAll(_cart.products);
      _orders.products.clear();
      calculateTotal();
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    if (_cart.products.containsKey(product.id)) {
      _cart.products[product.id]['amount']++;
    } else {
      _cart.products[product.id] = {'product': product, 'amount': 1};
    }
    calculateTotal();
    notifyListeners();
  }

  void removeFromCart(String productId) {
    if (_cart.products.containsKey(productId)) {
      if (_cart.products[productId]['amount'] == 1) {
        _cart.products.removeWhere((key, value) {
          return productId == key;
        });
      } else {
        _cart.products[productId]['amount']--;
      }
      calculateTotal();
      notifyListeners();
    }
  }

  void calculateTotal() {
    double total = 0;
    _cart.products.forEach((key, value) {
      total += value['product'].price * value['amount'];
    });
    _cart.totalPrice = total;
  }

 void calculateTotalOrder() {
    double total = 0;
    _orders.products.forEach((key, value) {
      total += value['product'].price * value['amount'];
    });
    _orders.totalPrice = total;
  }


  bool isInCart(String productId) {
    return _cart.products.containsKey(productId);
  }

  int getProductAmount(String productId) {
    return _cart.products[productId]['amount'];
  }
}
