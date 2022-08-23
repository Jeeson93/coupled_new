part of 'chat_bloc.dart';

abstract class ChatBlocEvent extends Equatable {
  const ChatBlocEvent();
}

class GetChatList extends ChatBlocEvent {
  GetChatList();

  @override
  List<Object> get props => [];
}

class GetChatSearchList extends ChatBlocEvent {
  final String searchKey;

  GetChatSearchList(this.searchKey);

  @override
  List<Object> get props => [];
}

class GetChat extends ChatBlocEvent {
  String? memberShipCode;

  GetChat(this.memberShipCode);

  @override
  List<Object> get props => [memberShipCode!];
}

class SendChat extends ChatBlocEvent {
  final String memberShipCode;
  final String message;
  final String mode;

  SendChat(this.memberShipCode, this.message, this.mode);

  @override
  // TODO: implement props
  List<Object> get props => [memberShipCode, message];
}

class SendLove extends ChatBlocEvent {
  final int messageId;
  final int love;

  SendLove(this.messageId, this.love);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetEvents extends ChatBlocEvent {
  final String memcode;

  GetEvents(this.memcode);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetOnlineUsers extends ChatBlocEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChatChangeNotifier extends ChatBlocEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
