import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:popbubble/components/chat/Chat.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.title,
    required this.chatId,
    required this.isOwner,
    this.docId,
  }) : super(key: key);

  final String title;
  final int chatId;
  final bool isOwner;
  final String? docId;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  var _channel;

  @override
  void initState() {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://popbubble-ws.herokuapp.com/chat/${widget.chatId}'),
    );
  }

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
  dispose() {
    if(widget.isOwner)
      deleteChat(widget.chatId);
    _channel.sink.close();
    super.dispose();
  }

  Future<void> deleteChat(int chatId) {
    return FirebaseFirestore.instance.collection('rooms')
        .doc(widget.docId)
        .delete()
        .then((value) => print("sala deletada"))
        .catchError((onError) => print("Failed to delete with error ${onError}"));
  }
}