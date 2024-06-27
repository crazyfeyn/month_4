import 'package:application/controller/cart_controller.dart';
import 'package:application/controller/products_controller.dart';
import 'package:application/models/product.dart';
import 'package:application/views/screens/admin_screen.dart';
import 'package:application/views/screens/cart_screen.dart';
import 'package:application/views/screens/orders_screen.dart';
import 'package:application/views/widgets/ordered_products_item.dart';
import 'package:application/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ordered Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const CartScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cartController.orders.products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = cartController.orders.products.values.toList()[index]['product'];
          return ChangeNotifierProvider<Product>.value(
            value: product,
            builder: (context, child) {
              return const OrderedProductsItem();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => AdminScreen()));
        },
        child: const Icon(Icons.person),
      ),
    );
  }
}
