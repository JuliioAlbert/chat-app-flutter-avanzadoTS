import 'package:chat_app/domain/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_app/domain/entities/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'btn_send.dart';

class InputChat extends StatefulWidget {
  const InputChat({Key? key}) : super(key: key);

  @override
  State<InputChat> createState() => _InputChatState();
}

class _InputChatState extends State<InputChat> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool _escribiendo = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (value) {
                  setState(() {
                    if (value.trim().isNotEmpty) {
                      _escribiendo = true;
                    } else {
                      _escribiendo = false;
                    }
                  });
                },
                decoration:
                    const InputDecoration.collapsed(hintText: 'Enviar Mensaje'),
                focusNode: _focusNode,
              ),
            ),
            BtnSend(
                onPressed: _escribiendo
                    ? () => _handleSubmit(_textController.text.trim())
                    : null),
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String texto) {
    if (texto.isEmpty) return;
    context
        .read<ChatBloc>()
        .add(SendMessage(MessageModel(uuid: "123", message: texto)));

    _textController.clear();
    _focusNode.requestFocus();
  }
}
