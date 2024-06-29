import 'package:application/controllers/quizes_controller.dart';
import 'package:application/models/quizes.dart';
import 'package:flutter/material.dart';

class VariantWidget extends StatefulWidget {
  Quize quize;
  int selectedAnswer;
  Function nextPage;
  QuizesController quizesController;
  VariantWidget(
      {super.key,
      required this.quize,
      required this.selectedAnswer,
      required this.nextPage,
      required this.quizesController});

  @override
  State<VariantWidget> createState() => _VariantWidgetState();
}

class _VariantWidgetState extends State<VariantWidget> {
  void toggleAnswer(int index) {
    widget.selectedAnswer = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.quize.variants.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              crossAxisSpacing: 10,
              mainAxisExtent: 100,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  toggleAnswer(index);
                  widget.quizesController.responses(widget.quize, index);
                  widget.nextPage();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: widget.selectedAnswer == index
                          ? Colors.amber
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white)),
                  padding: const EdgeInsets.all(2),
                  child: Center(
                    child: Text(
                      '${widget.quize.variants[index]}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
