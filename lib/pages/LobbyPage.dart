import 'package:flutter/material.dart';
import 'package:popbubble/components/lobby/Lobby.dart';

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