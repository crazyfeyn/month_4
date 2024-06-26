import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/controllers/products_controller.dart';
import 'package:lesson64_statemanagement/models/product.dart';
import 'package:lesson64_statemanagement/views/widgets/add_product.dart';
import 'package:lesson64_statemanagement/views/widgets/admin_product_item.dart';
import 'package:provider/provider.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: ListView.builder(
        itemCount: productController.list.length,
        itemBuilder: (ctx, index) {
          final product = productController.list[index];
          return ChangeNotifierProvider<Product>.value(
            value: product,
            builder: (context, child) {
              return const AdminProductItem();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProduct(),
              ));
          if (response != null) {
            productController.addProduct(
                response['title'], double.parse(response['price']));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
