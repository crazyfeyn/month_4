// import 'package:application/controllers/product_controller.dart';
// import 'package:application/models/product.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AdminPanel extends StatelessWidget {
//   const AdminPanel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final productController = Provider.of<ProductController>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Admin Panel",
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       drawer: const CustomDrawer(),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(20),
//         itemCount: productController.productList.length,
//         itemBuilder: (context, index) {
//           Product product = productController.productList[index];
//           return AdminItem(product: product);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AddProduct(),
//               ));
//         },
//       ),
//     );
//   }
// }