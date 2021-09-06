import 'package:popbubble/components/chat/BubbleChat.dart';
import 'package:popbubble/components/chat/ChatBox.dart';
import 'package:popbubble/components/chat/ChatForms.dart';
import 'package:flutter/material.dart';


class Chat extends StatefulWidget {

  final _channel;

  Chat(this._channel);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  final TextEditingController _controller = TextEditingController();
  final List<BubbleChat> messages = [];

  listenStream() {
    widget._channel.stream.listen((value) => {
      addMessage(value, false)
    });
  }
  void addMessage(text, isSender) {
    setState(() {
      messages.add(BubbleChat(text, isSender));
    });
  }

  @override void initState() {
    listenStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: ChatBox(widget._channel),
            flex: 3,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ChatForms(_controller, widget._channel, addMessage),
            flex: 1,
          ),
        ],
      ),
    );
  }
}