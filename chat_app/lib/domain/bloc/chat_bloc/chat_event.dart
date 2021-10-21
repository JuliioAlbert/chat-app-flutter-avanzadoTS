part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final MessageModel message;

  SendMessage(this.message);
}
