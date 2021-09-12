import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:popbubble/components/chat/BubbleChat.dart';
import 'package:popbubble/components/chat/ChatBox.dart';
import 'package:popbubble/components/chat/ChatForms.dart';
import 'package:flutter/material.dart';
import 'package:popbubble/components/chat/SystemChip.dart';
import 'package:popbubble/main.dart';
import 'package:popbubble/models/Message.dart';


class Chat extends StatefulWidget {

  final _channel;

  Chat(this._channel);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  final TextEditingController _controller = TextEditingController();
  final List<Widget> messages = [];

  void listen(value) {
    final message = Message.fromJson(jsonDecode(value));
    addMessage(message, false);
    if (message.event == Event.DISCONNECTED)
      showAlert();
  }

  void showAlert() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('O desconhecido acabou de sair da sala'),
          content: const Text('A sala será excluída agora, obrigado!'),
          actions: [
            TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: Text("Deixar a sala"))
          ],
        )
    );
  }

  listenStream() {
    widget._channel.stream.listen((value) => {
      listen(value)
    });
  }
  void addMessage(message, isSender) {
    setState(() {

      if (message.author == Author.PERSON) {
          messages.add(BubbleChat(message.message, isSender));
      } else {
        messages.add(SystemChip(message.message));
      }
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
            child: ChatBox(messages),
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