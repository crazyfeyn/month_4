import 'package:application/controller/cart_controller.dart';
import 'package:application/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
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
      trailing: Consumer<CartController>(builder: (context, controller, child) {
        return controller.isInCart(product.id)
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.removeFromCart(product.id);
                    },
                    icon: const Icon(Icons.remove_circle),
                  ),
                  Text(
                    controller.getProductAmount(product.id).toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.addToCart(product);
                    },
                    icon: const Icon(Icons.add_circle),
                  ),
                ],
              )
            : IconButton(
              onPressed: () {
                controller.addToCart(product);
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            );
      }),
    );
  }
}
