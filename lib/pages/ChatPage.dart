import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:popbubble/components/chat/Chat.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://popbubble-ws.herokuapp.com/chat'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Chat(_channel)
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}