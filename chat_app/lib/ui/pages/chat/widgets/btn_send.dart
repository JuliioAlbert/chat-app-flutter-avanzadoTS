import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BtnSend extends StatelessWidget {
  const BtnSend({Key? key, required this.onPressed}) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: !Platform.isIOS
          ? CupertinoButton(
              child: const Text("Send"),
              onPressed: onPressed,
            )
          : IconTheme(
              data: IconThemeData(color: Colors.blue[400]),
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: onPressed,
                icon: const Icon(
                  Icons.send,
                ),
              ),
            ),
    );
  }
}
