import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:coupled/Chat/Model/ChatModel.dart';
import 'package:coupled/Chat/Model/EventModel.dart';
import 'package:coupled/Chat/Model/message_model.dart';
import 'package:coupled/Chat/Model/sticker_model.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';

import 'package:equatable/equatable.dart';
import 'package:laravel_echo2/laravel_echo2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import './bloc.dart';
part 'chat_bloc_state.dart';
part 'chat_bloc_event.dart';
// class ChatBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
//   ChatBloc({ChatBlocState initialState}) : super(initialState);

//   Stream<ChatBlocState> mapEventToState(
//     ChatBlocEvent event,
//   ) async* {
//     //  yield InitialChatBlocState();
//     if (event is GetChatList) {
//       try {
//         Map<String, dynamic> chatResponse =
//             await RestAPI().get<Map>(APis.chatUrl, "chat");
//         var chat = ChatModel.fromJson(chatResponse);

//         Map<String, dynamic> stickersResponse =
//             await RestAPI().get<Map>(APis.stickers, "stickers");
//         GlobalData.stickerModel = StickerModel.fromMap(stickersResponse);
//         print("Chat :: $chat");
//         print("sticker :: $stickersResponse");
//         yield ChatLoaded(chat);
//       } on RestException catch (e) {
//         yield ChatError("${e.prefix} Something went wrong.");
//       }
//     }

//     if (event is GetChatSearchList) {
//       try {
//         Map<String, dynamic> response = await RestAPI()
//             .get<Map>("${APis.chatUrl}?search=${event.searchKey}");
//         var chat = ChatModel.fromJson(response);
//         print("Chat :: $chat");
//         yield ChatLoaded(chat);
//       } on RestException catch (e) {
//         yield ChatError("${e.prefix} Something went wrong.");
//       }
//     }

//     if (event is GetChat) {
//       print('response----------getChat');
//       try {
//         var response =
//             await RestAPI().get("${APis.chatUrl}/${event.memberShipCode}");
//         print('message unread----------------');
//         // print(response);
//         GlobalData.messageModel = MessageModel.fromMap(response);
//         print(GlobalData.messageModel.response.messagesUnreadIndex);
//         yield ChatMessageLoaded(GlobalData.messageModel);
//       } on RestException catch (e) {
//         yield ChatError("${e.prefix} Something went wrong.");
//       }
//     }

//     if (event is SendChat) {
//       try {
//         Map<String, String> params = {
//           "memCode": event.memberShipCode,
//           "msg": event.message,
//           "mode": event.mode,
//         };

//         Map<String, String> response =
//             await RestAPI().post<Map>(APis.chatUrl, params: params);
//         GlobalData.messageModel = MessageModel.fromMap(response);

//         yield ChatMessageLoaded(GlobalData.messageModel);
//       } on RestException catch (e) {
//         yield ChatError("${e.prefix} Something went wrong.");
//       }
//     }
//     if (event is SendLove) {
//       try {
//         Map<String, int> params = {
//           "message_id": event.messageId,
//           "love": event.love
//         };

//         Map<String, dynamic> response =
//             await RestAPI().post<Map>(APis.chatUrlLove, params: params);
//         yield ChatMessageLoaded(MessageModel.fromMap(response));
//       } on RestException catch (e) {
//         yield ChatError("${e.prefix} Something went wrong.");
//       }
//     }

//     if (event is GetEvents) {
//       try {
//         var response =
//             await RestAPI().get("${APis.chatHistory}/${event.memcode}");
//         print('events----------------');
//         print(response);
//         GlobalData.eventModel = EventModel.fromMap(response);

//         yield ChatEventLoaded(GlobalData.eventModel);
//       } on RestException catch (e) {
//         yield ChatError("${e.prefix} Something went wrong.");
//       }
//     }

//    if (event is GetOnlineUsers) {
//      String token;
//      try {
//        Future<void> getToken() async {
//          SharedPreferences prefs = await SharedPreferences.getInstance();
//          token = prefs.getString('accessToken');
//        }
//
//        List getOnlineUsers() {
//          getToken();
//          print('token');
//
//          Echo echo = new Echo({
//            'broadcaster': 'socket.io',
//            'client': IO.io,
//            'host': APis.socketIO,
//            'auth': {
//              'headers': {'Authorization': 'Bearer $token'}
//            }
//          });
//
//          echo.join('coupled-online-users').here((users) {
//            List listUsers = users.map((f) => f).toList();
//            print('join users------------');
//            print(listUsers.length);
//          }).joining((user) {
//            print('joining users------------');
//            print(user);
//          }).leaving((user) {
//            print('leavinge----------');
//            print(user);
//          }).listen('PresenceEvent', (e) {
//            print('e----------');
//            print(e);
//          });
//
//          return getOnlineUsers();
//        }
//
//        yield OnlineUsersLoaded(getOnlineUsers());
//      } on RestException catch (e) {
//        yield ChatError("${e.prefix} Something went wrong.");
//      }
//    }

//     if (event is ChatChangeNotifier) {
//       yield InitialChatBlocState();

//       yield ChatMessageLoaded(GlobalData.messageModel);
//     }
//   }
// }

class ChatBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBloc() : super(InitialChatBlocState()) {
    on<GetChatList>((event, emit) async {
      try {
        Map<String, dynamic> chatResponse = await RestAPI()
            .get<Map>(APis.chatUrl, "chat") as Map<String, dynamic>;
        var chat = ChatModel.fromJson(chatResponse);

        Map<String, dynamic> stickersResponse = await RestAPI()
            .get<Map>(APis.stickers, "stickers") as Map<String, dynamic>;
        GlobalData.stickerModel = StickerModel.fromMap(stickersResponse);
        print("Chat :: $chat");
        print("sticker :: $stickersResponse");
        emit(ChatLoaded(chat));
      } on RestException catch (e) {
        emit(ChatError("${e.prefix} Something went wrong."));
      }
    });
    on<GetChatSearchList>((event, emit) async {
      try {
        Map<String, dynamic> response = await RestAPI()
                .get<Map>("${APis.chatUrl}?search=${event.searchKey}")
            as Map<String, dynamic>;
        var chat = ChatModel.fromJson(response);
        print("Chat :: $chat");
        emit(ChatLoaded(chat));
      } on RestException catch (e) {
        emit(ChatError("${e.prefix} Something went wrong."));
      }
    });
    on<GetChat>((event, emit) async {
      print('response----------getChat');
      try {
        // var response =
        //     await RestAPI().get("${APis.chatUrl}/${event.memberShipCode}");
        // MessageModel chatlistmodel = await Repository()
        //     .getchatlistpro(memberShipCode: event.memberShipCode);
        // print('message unread----------------');
        // print(response);
        GlobalData.messageModel = await Repository()
            .getchatlistpro(memberShipCode: event.memberShipCode.toString());

        print(GlobalData.messageModel);
        emit(ChatMessageLoaded(GlobalData.messageModel));
      } on RestException catch (e) {
        emit(ChatError("${e.prefix} Something went wrong."));
      }
    });
    on<SendChat>((event, emit) async {
      try {
        Map<String, String> params = {
          "memCode": event.memberShipCode,
          "msg": event.message,
          "mode": event.mode,
        };

        Map response = await RestAPI().post<Map>(APis.chatUrl, params: params);
        print('chat_res$response');
        GlobalData.messageModel =
            MessageModel.fromMap(response as Map<String, dynamic>);

        emit(ChatMessageLoaded(GlobalData.messageModel));
      } on RestException catch (e) {
        emit(ChatError("${e.prefix} Something went wrong."));
        GlobalData.recievemsg = 1;
      }
    });
    on<SendLove>((event, emit) async {
      try {
        Map<String, int> params = {
          "message_id": event.messageId,
          "love": event.love
        };

        Map<String, dynamic> response = await RestAPI()
            .post<Map>(APis.chatUrlLove, params: params) as Map<String, String>;
        emit(ChatMessageLoaded(MessageModel.fromMap(response)));
      } on RestException catch (e) {
        emit(ChatError("${e.prefix} Something went wrong."));
      }
    });
    on<GetEvents>((event, emit) async {
      try {
        var response =
            await RestAPI().get("${APis.chatHistory}/${event.memcode}");
        print('events----------------');
        print(response);
        GlobalData.eventModel = EventModel.fromMap(response);

        emit(ChatEventLoaded(EventModel.fromMap(response)));
      } on RestException catch (e) {
        emit(ChatError("${e.prefix} Something went wrong."));
      }
    });
    on<GetOnlineUsers>((event, emit) async {
      String token = '';
      try {
        Future<void> getToken() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          token = prefs.getString('accessToken')!;
        }

        List getOnlineUsers() {
          getToken();
          print('token');

          Echo echo = Echo({
            'broadcaster': 'socket.io',
            'client': IO.io,
            'host': APis.socketIO,
            'auth': {
              'headers': {'Authorization': 'Bearer $token'}
            }
          });

          echo.join('coupled-online-users')!.here((users) {
            List listUsers = users.map((f) => f).toList();
            print('join users------------');
            print(listUsers.length);
          }).joining((user) {
            print('joining users------------');
            print(user);
          }).leaving((user) {
            print('leavinge----------');
            print(user);
          }).listen('PresenceEvent', (e) {
            print('e----------');
            print(e);
          });

          return getOnlineUsers();
        }

        emit(OnlineUsersLoaded(getOnlineUsers()));
      } on RestException catch (e) {
        emit(ChatError("${e.prefix} Something went wrong."));
      }
    });
    on<ChatChangeNotifier>((event, emit) {
      emit(InitialChatBlocState());

      emit(ChatMessageLoaded(GlobalData.messageModel));
    });
  }
  // void GetChatListget(GetChatList event, Emit<ChatBlocState> emit) async {
  //   emit()
  //   try {
  //       Map<String, dynamic> chatResponse =
  //           await RestAPI().get<Map>(APis.chatUrl, "chat");
  //       var chat = ChatModel.fromJson(chatResponse);

  //       Map<String, dynamic> stickersResponse =
  //           await RestAPI().get<Map>(APis.stickers, "stickers");
  //       GlobalData.stickerModel = StickerModel.fromMap(stickersResponse);
  //       print("Chat :: $chat");
  //       print("sticker :: $stickersResponse");
  //       emit( ChatLoaded(chat));
  //     } on RestException catch (e) {
  //       emit( ChatError("${e.prefix} Something went wrong."));
  //     }
  // }
}
