import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/user.dart';

class FirebaseServices {
  final CollectionReference<Map<String, dynamic>> _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference<Map<String, dynamic>> _chatCollection =
      FirebaseFirestore.instance.collection('chat_rooms');

  Stream<QuerySnapshot> getUsers() async* {
    yield* _usersCollection.snapshots();
  }

  Future<void> addNewUser(UserModel newUser) async {
    try {
      await _usersCollection.add({
        'u_email': newUser.email,
        'uid': newUser.uid,
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> startChat(
      String receiverId, String senderId, String chrId, String message) async {
    if (receiverId.isEmpty ||
        senderId.isEmpty ||
        chrId.isEmpty ||
        message.isEmpty) {
      return;
    }

    try {
      Map<String, dynamic> data = {
        'receiver_id': receiverId,
        'sender_id': senderId,
        'timestamp': FieldValue.serverTimestamp(),
        'message': message
      };
      await _chatCollection.doc(chrId).collection('messages').add(data);
      // ignore: empty_catches
    } catch (e) {}
  }

  Stream<QuerySnapshot> getActiveChats(String receiverEmail, String senderEmail) async* {
    List<String> sortedList = [receiverEmail, senderEmail]
      ..sort((a, b) => a.compareTo(b));
    yield* _chatCollection.doc(sortedList.join('')).collection('messages').orderBy('timestamp', descending: true).snapshots();
  }
}
