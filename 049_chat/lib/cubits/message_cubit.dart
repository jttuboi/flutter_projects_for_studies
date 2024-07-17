import 'package:bloc/bloc.dart';
import 'package:chat/chat.dart';
import 'package:equatable/equatable.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.messageService) : super(MessageInitial());

  final IMessageService messageService;

  void subscribed(User user) {
    messageService.messages(activeUser: user).listen((message) {
      //emit(MessageRe);
      // https://youtu.be/w7jN5vDOvRY?list=PLFhJomvoCKC_mXNBDnpO46Hea_PkCiVWS&t=1272
    });
  }

  void messageSent(Message message) {}

  void messageReceived(Message message) {}
}

abstract class MessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessageInitial extends MessageState {}

class MessageSentSuccess extends MessageState {
  MessageSentSuccess(this.message);

  final Message message;

  @override
  List<Object?> get props => [message];
}

class MessageReceivedSuccess extends MessageState {
  MessageReceivedSuccess(this.message);

  final Message message;

  @override
  List<Object?> get props => [message];
}
