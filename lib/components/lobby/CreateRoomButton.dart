import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CreateRoomButton extends StatelessWidget {

  final TextEditingController _controller;

  CreateRoomButton(this._controller);

  final CollectionReference rooms = FirebaseFirestore.instance.collection(
      'rooms');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return rooms
        .add({
      'description': _controller.text,
      'createdAt': Timestamp.now()// John Doe
    })
        .then((value) => print("Room Created"))
        .catchError((error) => print("Failed to add user: $error"));
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