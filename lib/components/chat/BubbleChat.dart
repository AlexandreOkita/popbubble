import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';


class BubbleChat extends StatelessWidget {

  final _text;
  final _isSender;

  BubbleChat(this._text, this._isSender);

  @override
  Widget build(BuildContext context) {
    return BubbleNormal(
        text: _text,
        isSender: _isSender,
        color: _isSender ? Colors.blue : Colors.purple,
        tail: true,
        textStyle: TextStyle(
            fontSize: 20,
            color: Colors.white
        )
    );
  }
}