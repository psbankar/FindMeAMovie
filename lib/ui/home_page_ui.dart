import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  VoidCallback onTap;
  var text;

  Button(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlineButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        onPressed: onTap,
        borderSide: BorderSide(color: Colors.deepPurpleAccent),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w100),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
