import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  String title;
  double price;
  String imageUrl;
  int count;
  Orders({
    required this.count,
    required this.imageUrl,
    required this.price,
    required this.title,
  });




  factory Orders.fromJson(QueryDocumentSnapshot query) {
    return Orders(
        imageUrl: query['imageUrl'],
        price: query['price'].toDouble(),
        title: query['title'],
        count: query['count']
        );
  }
}