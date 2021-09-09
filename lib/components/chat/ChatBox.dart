import 'package:flutter/material.dart';
import 'package:popbubble/components/chat/BubbleChat.dart';
import 'package:popbubble/models/Message.dart';


class ChatBox extends StatefulWidget {

  final List<Widget> messages;

  ChatBox(this.messages);

  @override
  _ChatBoxState createState() => _ChatBoxState();

}

class _ChatBoxState extends State<ChatBox> {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: widget.messages.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                child: Center(child: List.of(widget.messages.reversed)[index])
            );
          }
      ),
    );
  }
}