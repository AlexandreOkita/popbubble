import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                title: Padding(child: Text("${data['description']}"), padding: EdgeInsets.only(bottom: 6),),
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
    return "${date.hour.toString().padLeft(2,'0')}:${date.minute.toString().padLeft(2,'0')}   ${date.day.toString()}/${date.month.toString().padLeft(2,'0')}/${date.year.toString().padLeft(2,'0')}";
  }
}