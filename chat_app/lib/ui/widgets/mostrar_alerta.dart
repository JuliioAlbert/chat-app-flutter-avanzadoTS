import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class MostrarAlerta {
  static mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(titulo),
              content: Text(subtitulo),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"),
                ),
              ],
            );
          });
    }
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          CupertinoDialogAction(
            child: const Text("Ok"),
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
