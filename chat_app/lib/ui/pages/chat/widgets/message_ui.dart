import 'package:chat_app/domain/entities/message_model.dart';

import 'package:flutter/material.dart';

class MessageUI extends StatefulWidget {
  final MessageModel chat;

  const MessageUI({Key? key, required this.chat}) : super(key: key);

  @override
  State<MessageUI> createState() => _MessageUIState();
}

class _MessageUIState extends State<MessageUI> with TickerProviderStateMixin {
  late final AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: controller,
          curve: Curves.easeIn,
        ),
        child: MessageItem(chat: widget.chat),
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final MessageModel chat;

  @override
  Widget build(BuildContext context) {
    final localM = chat.uuid == "123";
    return Align(
      alignment: localM ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
            bottom: 10, left: localM ? 50 : 5, right: localM ? 5 : 50),
        decoration: BoxDecoration(
            color: localM ? Colors.grey[800] : Colors.grey,
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(8.0),
        child: Text(
          chat.message,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
