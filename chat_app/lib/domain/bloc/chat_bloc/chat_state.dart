part of 'chat_bloc.dart';

class ChatState {
  final List<MessageModel> messages;

  ChatState({
    required this.messages,
  });

  ChatState copyWith({
    required List<MessageModel> messages,
  }) =>
      ChatState(messages: messages);
}
