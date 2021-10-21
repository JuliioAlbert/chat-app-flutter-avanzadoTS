import 'package:chat_app/domain/bloc/chat_bloc/chat_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/input_chat.dart';
import 'widgets/message_ui.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        title: Column(
          children: const [
            CircleAvatar(
              maxRadius: 10,
              child: Text(
                "TE",
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Julio Gonzalez",
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return ListView.builder(
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: state.messages.length,
                    itemBuilder: (_, i) => MessageUI(chat: state.messages[i]),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Container(
              color: Colors.grey,
              child: const InputChat(),
            )
          ],
        ),
      ),
    );
  }
}
