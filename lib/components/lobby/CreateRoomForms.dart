import 'package:flutter/material.dart';
import 'package:popbubble/components/lobby/CreateRoomButton.dart';

class CreateRoomForms extends StatefulWidget {

  @override
  _CreateRoomFormsState createState() => _CreateRoomFormsState();
}

class _CreateRoomFormsState extends State<CreateRoomForms> {

  final TextEditingController _controller = TextEditingController();

  final templateEndString = ", prove-me o contrário";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      String text = _controller.text;
      if (_controller.text.isNotEmpty && !_controller.text.contains(templateEndString)) {
        text = _controller.text + templateEndString;
      }
      if (_controller.text == templateEndString)
        text = "";
      _controller.value = _controller.value.copyWith(
        text: text,
      );
      if (_controller.text.contains(templateEndString))
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length - templateEndString.length));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox(), flex: 1,),
        Expanded(
          child: Form(
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Crie uma sala escrevendo uma afirmação em que você acredita!'),
            ),
          ),
          flex: 5,
        ),
        Expanded(child: CreateRoomButton(_controller), flex: 1),
        Expanded(child: SizedBox(), flex: 1,),
      ],
    );
  }

}
