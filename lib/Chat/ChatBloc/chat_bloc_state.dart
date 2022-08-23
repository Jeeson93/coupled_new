part of 'chat_bloc.dart';

abstract class ChatBlocState extends Equatable {
  const ChatBlocState();
}

class InitialChatBlocState extends ChatBlocState {
  @override
  List<Object> get props => [];
}

class ChatError extends ChatBlocState {
  final String error;

  ChatError(this.error);

  @override
  List<Object> get props => [error];
}

class ChatLoaded extends ChatBlocState {
  final ChatModel chatModel;

  ChatLoaded(this.chatModel);

  @override
  List<Object> get props => [chatModel];
}

class ChatMessageLoaded extends ChatBlocState {
  final MessageModel? messageModel;

  ChatMessageLoaded(this.messageModel);

  @override
  List<Object> get props => [messageModel!];
}

class ChatEventLoaded extends ChatBlocState {
  final EventModel eventModel;

  ChatEventLoaded(this.eventModel);

  @override
  List<Object> get props => [eventModel];
}

class OnlineUsersLoaded extends ChatBlocState {
  final List onlineList;

  OnlineUsersLoaded(this.onlineList);

  @override
  List<Object> get props => [onlineList];
}
