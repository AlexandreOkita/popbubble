import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
          ChatBox(widget._channel, messages),
          const SizedBox(height: 24),
          ChatForms(_controller, widget._channel, addMessage),
        ],
      ),
    );
  }
}

class ChatForms extends StatefulWidget {

  final _controller;
  final _channel;
  final addMessage;

  ChatForms(this._controller, this._channel, this.addMessage);

  @override
  _ChatFormsState createState() => _ChatFormsState();

}

class _ChatFormsState extends State<ChatForms> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Form(
              child: TextFormField(
                onEditingComplete: _sendMessage,
                controller: widget._controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
        ),
        ElevatedButton(onPressed: _sendMessage, child: const Text('Submit'))
      ]
    );
  }

  void _sendMessage() {
    if (widget._controller.text.isNotEmpty) {
      widget._channel.sink.add(widget._controller.text);
      widget.addMessage(widget._controller.text, true);
      widget._controller.clear();
    }
  }
}

class ChatBox extends StatefulWidget {

  final _channel;
  final List<BubbleChat> messages;

  ChatBox(this._channel, this.messages);

  @override
  _ChatBoxState createState() => _ChatBoxState();

}

class _ChatBoxState extends State<ChatBox> {

  @override
  Widget build(BuildContext context) {

        return Container(
          height: 500,
          child: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: widget.messages.length,
            itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: Colors.amber,
              child: Center(child: List.of(widget.messages.reversed)[index])
              );
            }
          )
        );
  }
}

class BubbleChat extends StatelessWidget {

  final _text;
  final _isSender;

  BubbleChat(this._text, this._isSender);

  @override
  Widget build(BuildContext context) {
    return BubbleNormal(
      text: _text,
      isSender: _isSender,
      color: _isSender ? Color(0xFFE8E8EE) : Color(0xFF1B97F3),
      tail: true,
      textStyle: TextStyle(
        fontSize: 20,
        color: _isSender ? Colors.black54 : Colors.white,
      )
    );
  }

}