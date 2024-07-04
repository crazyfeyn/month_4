import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/firebase_servrices.dart';
import 'package:flutter_application_1/views/screens/user_seperate_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final firebaseServices = FirebaseServices();
  final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  final currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home screen'),
      ),
      body: StreamBuilder(
        stream: firebaseServices.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data'));
          }

          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserModel user = UserModel.fromQuery(users[index]);
              List<String> sortedList = [user.email, currentUserEmail]
                ..sort((a, b) => a.compareTo(b));
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserSeperateScreen(
                              senderId: currentUserId,
                              receiverId: user.uid,
                              chrId: sortedList.join(''),
                              firebaseServices: firebaseServices,
                              receiverEmail: user.email,
                              senderEmail: currentUserEmail,
                            )),
                  );
                },
                child: ListTile(
                  title: Text(user.email),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
