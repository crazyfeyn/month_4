import 'package:flutter/material.dart';
import 'package:musobaqa/controllers/cart_controller.dart';
import 'package:musobaqa/models/cart.dart';
import 'package:musobaqa/views/widgets/custom_drawer.dart';
import 'package:musobaqa/views/widgets/order_product.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardController = context.watch<CartController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Orders",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: cardController.order.length,
          itemBuilder: (context, index) {
            Cart cart = cardController.order[index];
            return OrderProduct(cart: cart);
          },
        ));
  }
}
