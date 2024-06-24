import 'package:flutter/material.dart';

class ExternalAnimation extends StatefulWidget {
  const ExternalAnimation({super.key});

  @override
  State<ExternalAnimation> createState() => _ExternalAnimationState();
}

class _ExternalAnimationState extends State<ExternalAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> containerAnimation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    containerAnimation = Tween<double>(begin: 0.0, end: 300.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('External animation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '100%',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            width: containerAnimation.value,
            height: 50,
            color: Colors.blue,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animationController.forward(from: 0.1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
