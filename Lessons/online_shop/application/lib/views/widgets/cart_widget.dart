import 'package:application/controllers/cart_controller.dart';
import 'package:application/views/screens/product_ready_to_buy_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final cardController = context.watch<CartController>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "My Card",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cardController.cartList.length,
                  itemBuilder: (context, index) {
                    final product = cardController.cartList[index];
                    return Card(
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          clipBehavior: Clip.hardEdge,
                          height: 80,
                          width: 80,
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      cardController
                                          .decrementProductCount(product.id);
                                    },
                                    icon: const Icon(CupertinoIcons.minus)),
                                Text(
                                  product.count.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                IconButton(
                                    onPressed: () {
                                      cardController
                                          .incrementProductCount(product.id);
                                    },
                                    icon: const Icon(CupertinoIcons.add)),
                                Container(
                                  height: 25,
                                  width: 2,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "\$${product.count * product.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 110,
              )
            ],
          ),
          Positioned(
              bottom: 80,
              right: 0,
              child: Row(
                children: [
                  const Text(
                    "Total: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "\$${cardController.totalPrice()}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                ],
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsReadyToBuy(),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,
                ),
                height: 70,
                child: const Center(
                  child: Text(
                    'Checkout Cart',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
