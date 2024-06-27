import 'package:application/controller/cart_controller.dart';
import 'package:application/controller/products_controller.dart';
import 'package:application/models/product.dart';
import 'package:application/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Text('Cart'),
        ),
        body: cartController.cart.products.isEmpty
            ? const Center(
                child: Text("Savatcha bo'sh, mahsulot qo'shing"),
              )
            : ListView.builder(
                itemCount: cartController.cart.products.length,
                itemBuilder: (context, index) {
                  final product = cartController.cart.products.values
                      .toList()[index]['product'];
                  return ChangeNotifierProvider<Product>.value(
                    value: product,
                    builder: (context, index) {
                      return const ProductItem();
                    },
                  );
                }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton.extended(
                onPressed: () {},
                label: Text(
                  '\$${cartController.cart.totalPrice}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            TextButton(
                onPressed: () {
                  cartController.addOrder();
                },
                child: const Text('Order'))
          ],
        ));
  }
}
