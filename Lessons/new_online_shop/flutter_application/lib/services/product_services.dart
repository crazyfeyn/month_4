import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductServices {
  final _productsCollection = FirebaseFirestore.instance.collection('products');
  final _productsImageStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getProducts() async* {
    yield* _productsCollection.snapshots();
  }

  void addproduct(String category, String imageUrl, double price, String title,
      bool isLiked) {
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
      String id, String category, File imageUrl, double price, String title) async{
         final imageReference = _productsImageStorage.ref()
        .child("products")
        .child("id")
        .child("$imageUrl.jpg");
    final uploadTask = imageReference.putFile(
      imageUrl
    );

    await uploadTask.whenComplete(() async {
      final imageUrl = await imageReference.getDownloadURL();
      await _productsCollection.doc(id).update({
        "title": title,
        "imageUrl": imageUrl,
        "price": price,
        "category": category,
        "isLiked": false,
      });
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
