// import 'package:application/controller/products_controller.dart';
// import 'package:application/models/product.dart';
// import 'package:application/views/screens/cart_screen.dart';
// import 'package:application/views/widgets/product_item_admin.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AdminScreen extends StatefulWidget {
//   const AdminScreen({super.key});

//   @override
//   State<AdminScreen> createState() => _AdminScreenState();
// }

// class _AdminScreenState extends State<AdminScreen> {
//   List<int> addedProducts = [];
//   final productsController = ProductsController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Admin"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (ctx) {
//                     return const CartScreen();
//                   },
//                 ),
//               );
//             },
//             icon: const Icon(Icons.shopping_cart),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: productsController.list.length,
//         itemBuilder: (BuildContext context, int index) {
//           final product = productsController.list[index];
//           return ChangeNotifierProvider<Product>.value(
//             value: product,
//             builder: (context, child) {
//               return const ProductItemAdmin();
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
