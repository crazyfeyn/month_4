import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    // loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom painter'),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(300, 300),
          painter: MyPainter(image),
          child: Text(
            'Hello',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  // void loadImage() async {
  //   final ByteData data = await rootBundle.load('assets/image.png');
  //   final Uint8List bytes = data.buffer.asUint8List();
  //   final ui.Codec codec = await ui.instantiateImageCodec(bytes);
  //   final ui.FrameInfo frameInfo = await codec.getNextFrame();
  //   setState(() {
  //     image = frameInfo.image;
  //   });
  // }
}

class MyPainter extends CustomPainter {
  final ui.Image? image;

  MyPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    // var paint = Paint()
    //   ..color = Colors.blue
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 5;

    var paint2 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    var rect = const Rect.fromLTWH(90, 100, 300, 10);
    var rect2 = const Rect.fromLTWH(100, 110, 30, 50);
    var rectPaint = const Rect.fromLTWH(50, 200, 150, 70);
    var rrect = RRect.fromRectAndRadius(rect, const Radius.circular(25));

    canvas.drawRRect(rrect, paint2);

    // canvas.drawCircle(Offset(size.width / 8, size.height / 20), 50, paint2);
    // canvas.drawCircle(Offset(size.width / 1.5, size.height / 20), 50, paint2);
    // canvas.drawOval(rect, paint);
    // canvas.drawRect(rectPaint, paint);

    // if (image != null) {
    //   canvas.drawImage(image!, Offset.zero, Paint());
    // }

    // var textPainter = TextPainter(
    //     text: const TextSpan(
    //         text: 'Salom, Flutter!',
    //         style: TextStyle(color: Colors.black, fontSize: 24)),
    //     textDirection: TextDirection.ltr);

    // textPainter.layout(minWidth: 0, maxWidth: size.width);
    // var offset = const Offset(50, 200);
    // textPainter.paint(canvas, offset);
    // rect = Rect.fromLTWH(50, 50, 200, 100);
    // if (image != null) {
    //   paintImage(canvas: canvas, rect: rect, image: image!);
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
