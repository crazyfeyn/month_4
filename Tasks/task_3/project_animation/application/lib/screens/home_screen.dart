import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> rotationAnimation;
  bool isSwich = false;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.14).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );

    rotationAnimation.addListener(() {
      setState(() {});
    });

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project animation'),
      ),
      body: Stack(
        children: [
          Image.asset('assets/images/image.png'),
          Positioned(
            top: 65,
            left: 355,
            child: AnimatedOpacity(
              opacity: isSwich ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      const BoxShadow(
                        blurRadius: 1,
                        color: Colors.white,
                      )
                    ]),
              ),
            ),
          ),
          Positioned(
              top: 100,
              left: 22,
              child: SizedBox(
                width: 335,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.rotate(
                      angle: rotationAnimation.value,
                      child: Image.asset(
                        'assets/images/tire.png',
                        height: 90,
                      ),
                    ),
                    Transform.rotate(
                      angle: rotationAnimation.value,
                      child: Image.asset(
                        'assets/images/tire.png',
                        height: 90,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          isSwich = !isSwich;
        });
      }),
    );
  }
}
