import 'package:application/models/quizes.dart';
import 'package:application/services/quizes_firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizesController extends ChangeNotifier {
  final quizesFirebaseServices = QuizesFirebaseServices();
  Stream<QuerySnapshot> get list {
    return quizesFirebaseServices.getQuizes();
  }

  static List<Quize> _correctResponses = [];
  static List<Quize> _incorrectResponses = [];

  List<Quize> get correctResponses {
    return _correctResponses;
  }

  List<Quize> get incorrectResponses {
    return _incorrectResponses;
  }

  void responses(Quize quize, int index) {
    if (quize.correctAnswer == index) {
      _correctResponses.add(quize);
    } else {
      _incorrectResponses.add(quize);
    }
  }

  void clearCorrectIncCorrects() {
    _correctResponses.clear();
    _incorrectResponses.clear();
  }

  void addQuiz(String question, List<String> variants, int correctAnswer) {
    quizesFirebaseServices.addQuiz(question, variants, correctAnswer);
  }

  void deleteQuiz(String id) {
    quizesFirebaseServices.deleteQuiz(id);
  }
}
