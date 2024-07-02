import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String category;
  String id;
  String imageUrl;
  double price;
  String title;
  bool isLiked;

  Product(
      {required this.category,
      required this.id,
      required this.imageUrl,
      required this.price,
      required this.title,
      required this.isLiked});

  factory Product.fromJson(QueryDocumentSnapshot query) {
    return Product(
        id: query.id,
        imageUrl: query['imageUrl'],
        price: query['price'].toDouble(),
        title: query['title'],
        isLiked: query['isLiked'],
        category: query['category']);
  }
}
