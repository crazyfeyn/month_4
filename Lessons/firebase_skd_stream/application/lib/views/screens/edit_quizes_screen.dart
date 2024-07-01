import 'package:application/controllers/quizes_controller.dart';
import 'package:application/models/quizes.dart';
import 'package:application/views/screens/first_screen.dart';
import 'package:flutter/material.dart';

class EditQuizesScreen extends StatefulWidget {
  const EditQuizesScreen({super.key});

  @override
  State<EditQuizesScreen> createState() => _EditQuizesScreenState();
}

List<String> variantList = ['A', 'B', 'C', 'D'];
QuizesController quizesController = QuizesController();

class _EditQuizesScreenState extends State<EditQuizesScreen> {
  QuizesController quizesController = QuizesController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: StreamBuilder(
          stream: quizesController.list,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          Quize quize =
                              Quize.fromJson(snapshot.data.docs[index]);
                          return InkWell(
                            onTap: () {
                              quizesController.deleteQuiz(quize.id);
                            },
                            child: ListTile(
                              title: Text(
                                "${quize.question.toUpperCase()}?",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...List.generate(quize.variants.length,
                                        (int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          "${variantList[index]})"
                                          "  ${quize.variants[index]}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      dispose();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red,
                          border: Border.all(color: Colors.white)),
                      child: const Text(
                        'Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
