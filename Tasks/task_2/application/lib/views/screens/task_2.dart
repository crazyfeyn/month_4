import 'dart:async';
import 'package:flutter/material.dart';

class Task2 extends StatefulWidget {
  const Task2({super.key});

  @override
  State<Task2> createState() => _Task2State();
}

class _Task2State extends State<Task2> {
  PageController pageController = PageController();
  Timer? timer;
  int curPageIndex = 0;
  List<String> images = [
    'assets/images/image_1.png',
    'assets/images/image_2.png',
    'assets/images/image_3.png',
    'assets/images/image_4.png',
    'assets/images/image_5.png'
  ];

  void startAutoScroll() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (pageController.hasClients) {
        int nextPage = curPageIndex + 1;
        if (nextPage == 5) {
          nextPage = 0;
        }
        pageController.animateToPage(
          nextPage,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        setState(() {
          curPageIndex = nextPage;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  @override
  void dispose() {
    pageController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 2'),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              height: 400,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
