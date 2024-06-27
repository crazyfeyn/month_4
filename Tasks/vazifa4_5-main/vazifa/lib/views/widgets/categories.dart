import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// ignore: must_be_immutable
class Categories extends StatefulWidget {
  String category;

  Categories({super.key, required this.category});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ZoomTapAnimation(
          onTap: () {
            isSelected = !isSelected;
            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 50,
            decoration: BoxDecoration(
                border:
                    Border.all(color: isSelected ? Colors.white : Colors.black),
                borderRadius: BorderRadius.circular(10),
                color: isSelected ? Colors.green.shade200 : null),
            child: Text(
              widget.category,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
