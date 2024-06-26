import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/controllers/products_controller.dart';
import 'package:lesson64_statemanagement/models/product.dart';
import 'package:lesson64_statemanagement/views/widgets/edit_product.dart';
import 'package:provider/provider.dart';

class AdminProductItem extends StatelessWidget {
  const AdminProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: product.color,
      ),
      title: Text(
        product.title,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text("\$${product.price}"),
      trailing: Consumer<ProductsController>(
        builder: (context, controller, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async {
                  final response = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProduct(),
                      ));
                  if (response != null) {
                    controller.editProduct(product.id, response['title'],
                        double.parse(response['price']));
                  }
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.deleteProduct(product.id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
