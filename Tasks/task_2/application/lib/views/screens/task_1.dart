import 'package:flutter/material.dart';

class Task1 extends StatefulWidget {
  const Task1({super.key});

  @override
  State<Task1> createState() => _Task1State();
}

class _Task1State extends State<Task1> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    List<Alignment> directions = [
      Alignment.centerLeft,
      Alignment.centerRight,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 1'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              i = i == 0 ? 1 : 0;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: i == 0 ? Colors.blue : Colors.black),
            height: 71,
            width: 160,
            child: AnimatedAlign(
                duration: const Duration(seconds: 1),
                alignment: directions[i],
                child: Container(
                  width: 70,
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: i == 0 ? Colors.white : Colors.grey,
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 0.8,
                            spreadRadius: 0.2,
                            color: Colors.black)
                      ]),
                  child: Image.asset(
                    i == 0
                        ? 'assets/images/plane_1.png'
                        : 'assets/images/plane_2.png',
                    fit: BoxFit.cover,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
