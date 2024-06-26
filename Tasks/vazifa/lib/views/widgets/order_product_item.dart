import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/controllers/cart_controller.dart';
import 'package:lesson64_statemanagement/models/product.dart';
import 'package:provider/provider.dart';

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: product.color,
      ),
      title: Text(
        product.title,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text("\$${product.price}"),
      trailing: Consumer<CartController>(
        builder: (context, controller, child) {
          return Text(
            "Amount: ${controller.getOrderAmount(product.id)}",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          );
        },
      ),
    );
  }
}
