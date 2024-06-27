import 'package:application/controller/cart_controller.dart';
import 'package:application/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderedProductsItem extends StatefulWidget {
  const OrderedProductsItem({super.key});

  @override
  State<OrderedProductsItem> createState() => _OrderedProductsItemState();
}

class _OrderedProductsItemState extends State<OrderedProductsItem> {
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
            "Amount: ${controller.getProductAmount(product.id)}",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          );
        },
      ),
    );
  }
}
