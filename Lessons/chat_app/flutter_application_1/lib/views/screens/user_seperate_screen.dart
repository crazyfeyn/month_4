import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_servrices.dart';

class UserSeperateScreen extends StatefulWidget {
  final String senderId;
  final String receiverId;
  final String chrId;
  final FirebaseServices firebaseServices;
  final String receiverEmail;
  final String senderEmail;

  UserSeperateScreen({
    Key? key,
    required this.senderId,
    required this.receiverId,
    required this.chrId,
    required this.firebaseServices,
    required this.receiverEmail,
    required this.senderEmail,
  }) : super(key: key);

  @override
  State<UserSeperateScreen> createState() => _UserSeperateScreenState();
}

class _UserSeperateScreenState extends State<UserSeperateScreen> {
  final _formKey = GlobalKey<FormState>();
  final messageEditingController = TextEditingController();

  @override
  void dispose() {
    messageEditingController.dispose();
    super.dispose();
  }

  Future<void> startChat(String message) async {
    await widget.firebaseServices.startChat(
      widget.receiverId,
      widget.senderId,
      widget.chrId,
      message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('justSooth'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: widget.firebaseServices.getActiveChats(
          widget.receiverEmail,
          widget.senderEmail,
        ),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error}'),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No messages'),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    // widget.senderId ==
                    //     snapshot.data!.docs[index]['sender_id']?
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: widget.senderId ==
                                snapshot.data!.docs[index]['sender_id']
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(snapshot.data!.docs[index]['message']),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.add),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: messageEditingController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your message',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a message';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            startChat(messageEditingController.text);
                            messageEditingController.clear();
                          }
                        },
                        icon: Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
