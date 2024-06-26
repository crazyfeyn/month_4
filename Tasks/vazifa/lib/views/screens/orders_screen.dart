import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/controllers/cart_controller.dart';
import 'package:lesson64_statemanagement/models/product.dart';
import 'package:lesson64_statemanagement/views/widgets/order_product_item.dart';
import 'package:provider/provider.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Buyurtmalar"),
        ),
        body: cartController.orders.products.isEmpty
            ? const Center(
                child: Text("Buyurtmalar yo'q"),
              )
            : ListView.builder(
                itemCount: cartController.orders.products.length,
                itemBuilder: (ctx, index) {
                  final product = cartController.orders.products.values
                      .toList()[index]['product'];
                  return ChangeNotifierProvider<Product>.value(
                    value: product,
                    builder: (context, child) {
                      return const OrderProductItem();
                    },
                  );
                },
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          shape: const RoundedRectangleBorder(),
          onPressed: () {},
          label: Text(
            "\$${cartController.orders.totalPrice}",
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
