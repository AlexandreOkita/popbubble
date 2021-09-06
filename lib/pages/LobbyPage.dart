import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



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
        Expanded(
            child: ListView(
              children: [
                Container(color: Colors.deepOrange, height: 500,),
                Container(height: 500, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),),
                Container(color: Colors.pink, height: 500,)
              ],
            )
        )
      ],
    );
  }

}