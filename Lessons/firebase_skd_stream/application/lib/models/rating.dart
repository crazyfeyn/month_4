import 'package:cloud_firestore/cloud_firestore.dart';

class Rating {
  String id;
  String email;
  int correctAnswer;

  Rating({
    required this.id,
    required this.email,
    required this.correctAnswer,
  });

  factory Rating.fromJson(QueryDocumentSnapshot query) {
    return Rating(
      id: query.id,
      email: query['email'],
      correctAnswer: query['correctAnswer'],
    );
  }
}
