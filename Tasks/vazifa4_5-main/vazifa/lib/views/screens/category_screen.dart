import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musobaqa/controllers/product_controller.dart';
import 'package:musobaqa/models/product.dart';
import 'package:musobaqa/views/screens/third_screen.dart';
import 'package:musobaqa/views/widgets/cart_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatefulWidget {
  String imageUrl;
  String categoryName;
  CategoryScreen(
      {super.key, required this.categoryName, required this.imageUrl});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? selectedValue;
  final List<String> items = ['Price', 'Rating'];
  List<Product> productBox = [];

  @override
  void initState() {
    super.initState();
    selectedValue = items.isNotEmpty ? items[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    productBox.clear();
    for (var element in productController.list) {
      if (element.category == widget.categoryName) {
        productBox.add(element);
      }
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 360,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.imageUrl), fit: BoxFit.cover)),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 50,
                        ))
                  ],
                ),
                const SizedBox(height: 70),
                const Text(
                  "Living Room",
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Have ${productController.productCategoryCount(widget.categoryName)} product",
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                DropdownButton<String>(
                  value: selectedValue,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Color(0xff1F2261),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
              itemCount: productBox.length,
              itemBuilder: (context, index) {
                final product = productBox[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThirdScreen(
                                  product: product,
                                )));
                  },
                  child: Card(
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 130,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(product.imageUrl),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                index.toString(),
                                style: const TextStyle(color: Colors.amber),
                              ),
                            ],
                          ),
                          Text(
                            product.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Row(
                            children: [
                              Text(
                                '\$${product.price}',
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  productController.isLiked(product.id);
                                },
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green.shade200),
                                    child: Icon(
                                      Icons.favorite_outlined,
                                      color: product.isLiked
                                          ? Colors.red
                                          : Colors.white,
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade200,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return const CadrWidget();
              });
        },
        child: const Icon(CupertinoIcons.cart),
      ),
    );
  }
}
