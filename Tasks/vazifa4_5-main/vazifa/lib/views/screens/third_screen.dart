import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musobaqa/controllers/cart_controller.dart';
import 'package:musobaqa/controllers/product_controller.dart';
import 'package:musobaqa/models/product.dart';
import 'package:musobaqa/views/widgets/cart_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ThirdScreen extends StatelessWidget {
  Product product;
  ThirdScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cardController = context.watch<CartController>();
    final productController = Provider.of<ProductController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.hardEdge,
                  width: 250,
                  height: 250,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Price: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${product.price}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      const Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    const Text("5"),
                    const Spacer(),
                    const Row(
                      children: [
                        Text("124 reviews  "),
                        Icon(Icons.chevron_right_outlined)
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text(
                      "Simple & Minimalist Light",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                    "When you search for ,you're likely looking for interior design concepts or lighting fixtures that convey a sense of simplicity and elegance. Minimalist lighting often features clean lines, basic shapes, and a limited color palette to create a calming atmosphere. In interior design, simple and minimalist light fixtures can include pendant lights, table lamps, or floor lamps with uncomplicated designs. You can find inspiration online by searching for minimalist lighting ideas, simple lamp designs, or modern interior design concepts.  "),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                cardController.addtoCard(product);
                showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return const CadrWidget();
                    });
              },
              child: Container(
                width: 220,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "ADD TO CART",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return const CadrWidget();
                    });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green.shade400),
                child: const Icon(
                  CupertinoIcons.cart,
                  color: Colors.white,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                productController.isLiked(product.id);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: product.isLiked
                      ? Colors.red
                      : Colors.grey.withOpacity(0.5),
                ),
                child: Icon(
                  product.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
