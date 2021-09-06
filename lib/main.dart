import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:popbubble/pages/ChatPage.dart';
import 'package:popbubble/pages/LobbyPage.dart';
import 'package:firebase_core/firebase_core.dart';



void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PopBubble());
}

class PopBubble extends StatefulWidget {
  @override
  _PopBubbleState createState() => _PopBubbleState();
}

class _PopBubbleState extends State<PopBubble> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    const title = 'PopBubble';
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: title,
            home: LobbyPage(
              title: title,
            ),
          );
        }
        return Loading();
      },
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text("loading"),
    );
  }

}