import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.onpressed,
      required this.buttonText,
      this.color});
  final Function() onpressed;
  final String buttonText;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: color),
        onPressed: onpressed,
        child: Text(
          buttonText,
          style: TextStyle(color: color == null ? Colors.white : Colors.black),
        ));
  }
}
