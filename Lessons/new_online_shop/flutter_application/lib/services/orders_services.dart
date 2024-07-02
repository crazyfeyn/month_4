import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersServices {
  final _ordersCollection = FirebaseFirestore.instance.collection('orders');

  Stream<QuerySnapshot> getOrders() async* {
    yield* _ordersCollection.snapshots();
  }

  void addOrder(String title, String imageUrl, double price, int count) {
    _ordersCollection.add({
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'count': count,
    });
  }

  
}
