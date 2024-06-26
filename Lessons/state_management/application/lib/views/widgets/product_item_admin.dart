// import 'package:application/controller/cart_controller.dart';
// import 'package:application/controller/products_controller.dart';
// import 'package:application/models/product.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProductItemAdmin extends StatefulWidget {
//   const ProductItemAdmin({super.key});

//   @override
//   State<ProductItemAdmin> createState() => _ProductItemAdminState();
// }

// class _ProductItemAdminState extends State<ProductItemAdmin> {
//   @override
//   Widget build(BuildContext context) {
//     final product = Provider.of<Product>(context, listen: false);
//     return ListTile(
//       leading: CircleAvatar(backgroundColor: product.color),
//       title: Text(
//         product.title,
//         style: const TextStyle(fontSize: 18),
//       ),
//       subtitle: Text("\$${product.price}"),
//       trailing: Consumer<Product>(builder: (context, controller, child) {
//         return Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.edit),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.delete),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
