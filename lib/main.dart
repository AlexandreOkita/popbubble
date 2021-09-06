import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:popbubble/pages/ChatPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'PopBubble';
    return const MaterialApp(
      title: title,
      home: ChatPage(
        title: title,
      ),
    );
  }
}