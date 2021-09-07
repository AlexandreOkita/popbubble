import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LobbyPage extends StatefulWidget {
  const LobbyPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Lobby()
    );
  }
}

class Lobby extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: RoomsList(), flex: 7,),
        Expanded(child: CreateRoomForms() ,flex: 1,),
        Expanded(child: SizedBox(), flex: 1,)
      ],
    );
  }
}


class CreateRoomForms extends StatefulWidget {

  @override
  _CreateRoomFormsState createState() => _CreateRoomFormsState();
}

class _CreateRoomFormsState extends State<CreateRoomForms> {

  final TextEditingController _controller = TextEditingController();

  final templateEndString = ", prove-me o contrário";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      String text = _controller.text;
      if (_controller.text.isNotEmpty && !_controller.text.contains(templateEndString)) {
        text = _controller.text + templateEndString;
      }
      if (_controller.text == templateEndString)
        text = "";
      _controller.value = _controller.value.copyWith(
        text: text,
      );
      if (_controller.text.contains(templateEndString))
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length - templateEndString.length));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox(), flex: 1,),
        Expanded(
          child: Form(
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Crie uma sala escrevendo uma afirmação em que você acredita!'),
            ),
          ),
          flex: 5,
        ),
        Expanded(child: CreateRoomButton(_controller), flex: 1),
        Expanded(child: SizedBox(), flex: 1,),
      ],
    );
  }

}

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

class RoomsList extends StatefulWidget {

  @override
  _RoomsListState createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('rooms').snapshots();
  final _joinRoom = () => {
    print("Vou dar join!")
  };

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text("${data['description']}"),
                subtitle: Text(dateToText((data['createdAt'] as Timestamp).toDate())),
                trailing: Row(children: [Text("Join Room"), SizedBox(width: 10,), Icon(Icons.arrow_forward_ios, size: 16,)], mainAxisSize: MainAxisSize.min),
                onTap: _joinRoom,
              );
            }).toList(),
          );
        }
    );
  }

  dateToText(date) {
    return "${date.day.toString()}/${date.month.toString().padLeft(2,'0')}/${date.year.toString().padLeft(2,'0')} ${date.hour.toString().padLeft(2,'0')}:${date.minute.toString().padLeft(2,'0')}";
  }
}