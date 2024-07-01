import 'package:cloud_firestore/cloud_firestore.dart';

class QuizesFirebaseServices {
  final _quizesCollection = FirebaseFirestore.instance.collection('quizes');

  Stream<QuerySnapshot> getQuizes() async* {
    yield* _quizesCollection.snapshots();
  }

  void addQuiz(String question, List<String> variants, int correctAnswer) {
    _quizesCollection.add({
      'question': question,
      'variants': variants,
      'correctAnswer': correctAnswer
    });
  }

  void deleteQuiz(String id) {
    _quizesCollection.doc(id).delete();
  }
}
