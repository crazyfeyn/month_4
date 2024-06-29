import 'package:cloud_firestore/cloud_firestore.dart';

class Quize {
  String id;
  String question;
  List<dynamic> variants;
  int correctAnswer; 

  Quize({
    required this.id,
    required this.question,
    required this.variants,
    required this.correctAnswer,
  });

  factory Quize.fromJson(QueryDocumentSnapshot query) {
    return Quize(
      id: query.id,
      question: query['question'] ?? '',
      variants: List.from(query['variants'] ?? []),
      correctAnswer: query['correctAnswer'] ?? 0, 
    );
  }
}
