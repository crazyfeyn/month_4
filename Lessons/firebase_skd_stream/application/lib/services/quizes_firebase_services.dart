import 'package:cloud_firestore/cloud_firestore.dart';

class QuizesFirebaseServices {
  final _quizesCollection = FirebaseFirestore.instance.collection('quizes');

  Stream<QuerySnapshot> getQuizes() async* {
    yield* _quizesCollection.snapshots();
  }
}
