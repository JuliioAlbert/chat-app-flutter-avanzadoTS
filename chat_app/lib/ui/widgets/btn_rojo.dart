import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonRojo extends StatelessWidget {
  const ButtonRojo({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Container(
        width: double.infinity,
        child: const Center(
          child: Text("Ingresar", style: TextStyle(fontSize: 17)),
        ),
      ),
      color: const Color(0xFF960404),
      borderRadius: BorderRadius.circular(30),
      onPressed: onPressed,
    );
  }
}
