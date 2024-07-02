import 'package:cloud_firestore/cloud_firestore.dart';

class ProductServices {
  final _productsCollection = FirebaseFirestore.instance.collection('products');

  Stream<QuerySnapshot> getProducts() async* {
    yield* _productsCollection.snapshots();
  }

  void addproduct(String category, String imageUrl, bool isLiked, double price,
      String title) {
    _productsCollection.add({
      'category': category,
      'imageUrl': imageUrl,
      'isLiked': isLiked,
      'price': price,
      'title': title,
    });
  }

  void deleteProduct(String id) {
    _productsCollection.doc(id).delete();
  }
}
