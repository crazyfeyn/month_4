import 'package:application/controllers/quizes_controller.dart';
import 'package:application/views/screens/first_screen.dart';
import 'package:flutter/material.dart';

class CreateQuizesScreen extends StatefulWidget {
  const CreateQuizesScreen({super.key});

  @override
  State<CreateQuizesScreen> createState() => _CreateQuizesScreenState();
}

class _CreateQuizesScreenState extends State<CreateQuizesScreen> {
  QuizesController quizesController = QuizesController();
  int chosenVariantIndex = -1;
  List<String> variantList = ['A', 'B', 'C', 'D'];
  List<String> variants = [];
  final _formKey = GlobalKey<FormState>();
  String question = '';
  String variantA = '';
  String variantB = '';
  String variantC = '';
  String variantD = '';
  int correctAnswer = -1;

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _variantAController = TextEditingController();
  final TextEditingController _variantBController = TextEditingController();
  final TextEditingController _variantCController = TextEditingController();
  final TextEditingController _variantDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      _questionController.dispose();
      _variantAController.dispose();
      _variantBController.dispose();
      _variantCController.dispose();
      _variantDController.dispose();
      super.dispose();
    }

    void onSubmit() {
      if (_formKey.currentState!.validate() && correctAnswer != -1) {
        _formKey.currentState!.save();
        variants = [
          _variantAController.text,
          _variantBController.text,
          _variantCController.text,
          _variantDController.text
        ];
        quizesController.addQuiz(question, variants, correctAnswer);

        _formKey.currentState!.reset();
        _questionController.clear();
        _variantAController.clear();
        _variantBController.clear();
        _variantCController.clear();
        _variantDController.clear();
        setState(() {
          question = '';
          variantA = '';
          variantB = '';
          variantC = '';
          variantD = '';
          correctAnswer = -1;
          chosenVariantIndex = -1;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FirstScreen()));
      }
    }

    void onAddOneMore() {
      if (_formKey.currentState!.validate() && correctAnswer != -1) {
        _formKey.currentState!.save();
        variants = [
          _variantAController.text,
          _variantBController.text,
          _variantCController.text,
          _variantDController.text
        ];
        quizesController.addQuiz(question, variants, correctAnswer);

        _formKey.currentState!.reset();
        _questionController.clear();
        _variantAController.clear();
        _variantBController.clear();
        _variantCController.clear();
        _variantDController.clear();
        setState(() {
          question = '';
          variantA = '';
          variantB = '';
          variantC = '';
          variantD = '';
          correctAnswer = -1;
          chosenVariantIndex = -1;
        });
      }
    }

    void toggleCorrectAnswer(int value) {
      setState(() {
        correctAnswer = value;
        chosenVariantIndex = value;
      });
    }

    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 700,
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        controller: _questionController,
                        decoration: InputDecoration(
                          hintText: 'Enter question',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a question';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null && newValue.isNotEmpty) {
                            setState(() {
                              question = newValue;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      //variants
                      SizedBox(
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextFormField(
                              controller: _variantAController,
                              decoration: InputDecoration(
                                hintText: 'A',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an option of (A)';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null && newValue.isNotEmpty) {
                                  setState(() {
                                    variantA = newValue;
                                  });
                                }
                              },
                            ),
                            TextFormField(
                              controller: _variantBController,
                              decoration: InputDecoration(
                                hintText: 'B',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an option of (B)';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null && newValue.isNotEmpty) {
                                  setState(() {
                                    variantB = newValue;
                                  });
                                }
                              },
                            ),
                            TextFormField(
                              controller: _variantCController,
                              decoration: InputDecoration(
                                hintText: 'C',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an option of (C)';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null && newValue.isNotEmpty) {
                                  setState(() {
                                    variantC = newValue;
                                  });
                                }
                              },
                            ),
                            TextFormField(
                              controller: _variantDController,
                              decoration: InputDecoration(
                                hintText: 'D',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an option of (D)';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null && newValue.isNotEmpty) {
                                  setState(() {
                                    variantD = newValue;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...List.generate(4, (int index) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () => toggleCorrectAnswer(index),
                                  child: Container(
                                    padding: const EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: chosenVariantIndex == index
                                              ? Colors.red
                                              : Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      variantList[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })
                        ],
                      ),
                      InkWell(
                        onTap: onSubmit,
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green.shade600,
                              border: Border.all(color: Colors.white)),
                          child: const Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onAddOneMore,
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue,
                              border: Border.all(color: Colors.white)),
                          child: const Text(
                            'Add one more',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
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
                            'Cancel',
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
                  )),
            )
          ],
        ),
      )),
    );
  }
}
