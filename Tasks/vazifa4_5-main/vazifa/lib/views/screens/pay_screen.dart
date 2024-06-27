import 'package:flutter/material.dart';
import 'package:musobaqa/controllers/cart_controller.dart';
import 'package:musobaqa/views/screens/firspage.dart';
import 'package:musobaqa/views/widgets/product_item.dart';
import 'package:provider/provider.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardController = context.watch<CartController>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green),
                padding: const EdgeInsets.all(40),
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 30,
                  ),
                )),
            const SizedBox(height: 30),
            const Text(
              "Payment Succesful!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Orders will arrive in 3 days!",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            const SizedBox(height: 40),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < cardController.list.length; i++)
                    Row(
                      children: [
                        ProductItem(
                          image: cardController.list[i].imageUrl,
                          title: cardController.list[i].title,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    )
                ],
              ),
            ),
            const SizedBox(height: 140),
            InkWell(
              onTap: () {
                cardController.pay();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Firspage(),
                    ));
              },
              child: Container(
                width: 240,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green),
                child: const Center(
                  child: Text(
                    "BACK TO HOME",
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
