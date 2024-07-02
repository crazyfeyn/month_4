import 'package:cloud_firestore/cloud_firestore.dart';

class ProductServices {
  final _productsCollection = FirebaseFirestore.instance.collection('products');

  Stream<QuerySnapshot> getProducts() async* {
    yield* _productsCollection.snapshots();
  }

  void addproduct(
      String category, String imageUrl, double price, String title, bool isLiked) {
    _productsCollection.add({
      'category': category,
      'imageUrl': imageUrl,
      'price': price,
      'title': title,
      'isLiked': isLiked
    });
  }

  void deleteProduct(String id) {
    _productsCollection.doc(id).delete();
  }

  void updateProduct(
      String id, String category, String imageUrl, double price, String title) {
    _productsCollection.doc(id).update({
      'category': category,
      'imageUrl': imageUrl,
      'price': price,
      'title': title,
      'isLiked': false
    });
  }

  Future<void> toggleFavorite(String id) async {
    DocumentSnapshot doc = await _productsCollection.doc(id).get();
    bool currentIsLiked = doc['isLiked'] ?? false;
    await _productsCollection.doc(id).update({
      'isLiked': !currentIsLiked,
    });
  }
}
