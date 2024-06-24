import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Alignment> directions = [
    Alignment.topCenter,
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomCenter,
    Alignment.bottomLeft,
    Alignment.bottomRight,
  ];
  int i = 0;
  bool isBig = true;
  List<String> items = ['1', '2', '3', '4', '5'];
  void changeDirection() {
    setState(() {
      i = Random().nextInt(directions.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: Stack(
        children: [
          SizedBox(
              height: 300,
              child: AnimatedList(
                  initialItemCount: items.length,
                  itemBuilder: (context, index, animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: ListTile(
                        title: Text(items[index]),
                      ),
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          isBig = !isBig;
        });
      }),
    );
  }
}
