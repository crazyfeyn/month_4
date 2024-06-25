import 'package:application/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> rotationAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

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

    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.rotate(
          angle: rotationAnimation.value,
          child: Image.asset(
            'assets/images/tire.png',
            height: 200,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
