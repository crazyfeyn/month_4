import 'dart:math';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> secBrushAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60)); 

    secBrushAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292D42),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: AnimatedBuilder(
              animation: secBrushAnimation,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(350, 400),
                  painter: Painter(secBrushAnimation.value),
                );
              })),
    );
  }
}

class Painter extends CustomPainter {
  final double angle;

  Painter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = const Color(0xFF414673)
      ..style = PaintingStyle.fill;

    Paint paintBorder = Paint()
      ..color = const Color(0xFFE6E9FD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    Paint paintCenter = Paint()
      ..color = const Color(0xFFE6E9FD)
      ..style = PaintingStyle.fill;

    var secHandBrush = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var minHandBrush = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var hourHandBrush = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    canvas.drawCircle(center, 100, paint);
    canvas.drawCircle(center, 100, paintBorder);

    double secHandX = center.dx + 80 * cos(angle - pi / 2);
    double secHandY = center.dy + 80 * sin(angle - pi / 2);

    double minHandX = center.dx + 70 * cos((angle / 60 * 2 * pi) - pi / 2);
    double minHandY = center.dy + 70 * sin((angle / 60 * 2 * pi) - pi / 2);

    double hourHandX = center.dx + 60 * cos((angle / 3600 * 2 * pi) - pi / 2);
    double hourHandY = center.dy + 60 * sin((angle / 3600 * 2 * pi) - pi / 2);

    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);
    canvas.drawCircle(center, 20, paintCenter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
