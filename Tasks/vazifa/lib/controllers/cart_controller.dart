import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/models/cart.dart';
import 'package:lesson64_statemanagement/models/product.dart';

class CartController extends ChangeNotifier {
  final Cart _cart = Cart(
    products: {},
    totalPrice: 0,
  );
  final Cart _orders = Cart(
    products: {},
    totalPrice: 0,
  );

  Cart get cart {
    return _cart;
  }

  Cart get orders {
    return _orders;
  }

  void orderCart() {
    _orders.products.addAll(_cart.products);
    _cart.products.clear();

    calculateTotalOrder();
    notifyListeners();
  }

  void addToCart(Product product) {
    if (_cart.products.containsKey(product.id)) {
      _cart.products[product.id]["amount"]++;
    } else {
      _cart.products[product.id] = {
        "product": product,
        "amount": 1,
      };
    }
    calculateTotal();
    notifyListeners();
  }

  void removeFromCart(String productId) {
    if (_cart.products.containsKey(productId)) {
      if (_cart.products[productId]["amount"] == 1) {
        _cart.products.removeWhere((key, value) {
          return key == productId;
        });
      } else {
        _cart.products[productId]["amount"]--;
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

  int getOrderAmount(String productId) {
    return _orders.products[productId]["amount"];
  }

  int getProductAmount(String productId) {
    return _cart.products[productId]['amount'];
  }
}
