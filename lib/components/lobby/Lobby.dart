import 'package:flutter/material.dart';
import 'package:popbubble/components/lobby/RoomsList.dart';
import 'package:popbubble/components/lobby/CreateRoomForms.dart';

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