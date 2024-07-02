import 'package:application/controllers/cart_controller.dart';
import 'package:application/controllers/product_controller.dart';
import 'package:application/services/product_services.dart';
import 'package:application/views/screens/product_detail_screen.dart';
import 'package:application/views/screens/product_ready_to_buy_screen.dart';
import 'package:application/views/widgets/first_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> topProductsType = [
  'Popular',
  'New',
  'ForeMost',
  'Intensive',
];
final productServices = ProductServices();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: ListTile(
              title: Text('Home screen'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Admin'),
            ),
          )
        ],
      )),
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: StreamBuilder(
        stream: productServices.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("$snapshot -----");
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          // if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          //   return const Center(
          //     child: Text('No data available'),
          //   );
          // }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<ProductController>(
              builder: (context, productController, child) {
                return Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Firstcategorywidget(
                                categoryName: "living",
                                imageUrl:
                                    'https://media.architecturaldigest.com/photos/64f71af50a84399fbdce2f6a/16:9/w_2560%2Cc_limit/Living%2520with%2520Lolo%2520Photo%2520Credit_%2520Life%2520Created%25204.jpg',
                                name: 'Living Room'),
                            Firstcategorywidget(
                                categoryName: "wall",
                                imageUrl:
                                    'https://foyr.com/learn/wp-content/uploads/2023/10/Best-wall-decor-idea-24-Tell-a-story-1024x768.jpg',
                                name: 'Wall Decoration'),
                            Firstcategorywidget(
                                categoryName: "table",
                                imageUrl:
                                    'https://jumanji.livspace-cdn.com/magazine/wp-content/uploads/2018/03/27162018/Table-decoration_tray.jpg',
                                name: 'Table Decoration'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              productController.productList.map((product) {
                            return Container(
                              width: 150,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                image: const DecorationImage(
                                    image: NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO2Pl9tI46P9ws0zd42SWJnV2YXoawhaq1fg&s'),
                                    fit: BoxFit.cover),
                              ),
                              child: Center(
                                child: Text(
                                  product.category,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: topProductsType.map((type) {
                          return Container(
                            alignment: Alignment.center,
                            width: 100,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green),
                            child: Text(
                              type,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Have ${productController.productList.length - 1} products",
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue.shade400),
                            child: const Text('Sort by'),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        itemCount: productController.productList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final product = productController.productList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                          product: product)));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 120,
                                    width: double.infinity,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.title,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '\$${product.price}',
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            productController
                                                .toggleFavorite(product);
                                          },
                                          child: CircleAvatar(
                                            child: Icon(
                                              product.isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
