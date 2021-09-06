import 'package:flutter/material.dart';

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
          ElevatedButton(onPressed: _sendMessage, child: const Icon(Icons.send))
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