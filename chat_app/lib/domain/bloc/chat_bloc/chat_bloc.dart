import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/entities/message_model.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState(messages: [])) {
    on<ChatEvent>((event, emit) {
      if (event is SendMessage) {
        final amessage = state.messages;
        state.messages.insert(0, event.message);
        final message = state.messages;
        emit(state.copyWith(messages: state.messages));
      }
    });
  }
}
