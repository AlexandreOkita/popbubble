import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popbubble/main.dart';
import 'package:popbubble/pages/ChatPage.dart';



class CreateRoomButton extends StatelessWidget {

  final TextEditingController _controller;

  CreateRoomButton(this._controller);

  final CollectionReference rooms = FirebaseFirestore.instance.collection(
      'rooms');

  Future<void>? addUser() {
    // Call the user's CollectionReference to add a new user
    if (_controller.text.isNotEmpty) {
      _controller.clear();
      final id = DateTime
          .now()
          .microsecondsSinceEpoch;
      return rooms
          .add({
        'description': _controller.text,
        'createdAt': Timestamp.now(),
        'id': id
      })
          .then((value) =>
      {
        navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (context) =>
                ChatPage(title: _controller.text, chatId: id,)
            )
        )
      })
          .catchError((error) => print("Failed to add user: $error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: addUser,
      style: ElevatedButton.styleFrom(shape: StadiumBorder()) ,
      child: Text(
        "Create Room",
      ),
    );
  }
}