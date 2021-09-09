import 'package:flutter/material.dart';


class SystemChip extends StatelessWidget {

  final _text;

  SystemChip(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Color(0x558AD3D5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          _text,
        ),
      ),
    );
  }
}