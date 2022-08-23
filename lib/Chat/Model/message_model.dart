// // To parse this JSON data, do
// //
// //     final chatModel = chatModelFromMap(jsonString);

import 'dart:convert';

import 'package:coupled/models/profile.dart';
import 'package:coupled/models/tol_order_history.dart';

MessageModel chatModelFromMap(String str) =>
    MessageModel.fromMap(json.decode(str));

String chatModelToMap(MessageModel data) => json.encode(data.toMap());

class MessageModel {
  MessageModel({
    this.status,
    this.response,
    this.code,
  });

  String? status;
  ChatModelResponse? response;
  int? code;

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        status: json["status"] == null ? '' : json["status"],
        response: json["response"] == null
            ? null
            : ChatModelResponse.fromMap(json["response"]),
        code: json["code"] == null ? 0 : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == '' ? '' : status,
        "response": response == '' ? '' : response!.toMap(),
        "code": code == 0 ? 0 : code,
      };
}

class ChatModelResponse {
  ChatModelResponse({
    this.messages,
    this.messagesUnreadIndex = 0,
    this.mom,
    this.chatShow = '',
    this.loveGiven = 0,
    this.loveRecieve = 0,
    this.requestTolStatus = 0,
    this.recieveTolStatus = 0,
    this.userStatus = '',
  });

  List<Message>? messages;
  int? messagesUnreadIndex;
  dynamic loveGiven;
  dynamic loveRecieve;
  dynamic requestTolStatus;
  int? recieveTolStatus;
  Mom? mom;
  String? chatShow;
  String? userStatus;

  factory ChatModelResponse.fromMap(Map<String, dynamic> json) =>
      ChatModelResponse(
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"].map((x) => Message.fromMap(x))),
        messagesUnreadIndex: json["messages_unread_index"] == null
            ? 0
            : json["messages_unread_index"],
        loveGiven: json["love_given"] == null ? 0 : json["love_given"],
        loveRecieve: json["love_recieve"] == null ? 0 : json["love_recieve"],
        mom: Mom.fromMap(json) == null
            ? null
            : Mom.fromMap(json["mom"] != null ? json["mom"] : {}),
        chatShow: json["chat_show"] == null ? '' : json["chat_show"],
        userStatus: json["user_status"] == null ? null : json["user_status"],
        requestTolStatus:
            json["request_tol_status"] == null ? 0 : json["request_tol_status"],
        recieveTolStatus:
            json["recieve_tol_status"] == null ? 0 : json["recieve_tol_status"],
      );

  Map<String, dynamic> toMap() => {
        "messages": messages == []
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toMap())),
        "messages_unread_index":
            messagesUnreadIndex == null ? 0 : messagesUnreadIndex,
        "love_given": loveGiven == 0 ? 0 : loveGiven,
        "love_recieve": loveRecieve == 0 ? 0 : loveRecieve,
        "mom": mom == null ? '' : mom?.toMap(),
        "chat_show": chatShow == null ? '' : chatShow,
        "user_status": userStatus == null ? null : userStatus,
        "request_tol_status": requestTolStatus == null ? 0 : requestTolStatus,
        "recieve_tol_status": recieveTolStatus == null ? 0 : recieveTolStatus,
      };

  @override
  String toString() {
    return 'ChatModelResponse{messages: $messages, messagesUnreadIndex: $messagesUnreadIndex, loveGiven: $loveGiven, loveRecieve: $loveRecieve, requestTolStatus: $requestTolStatus, recieveTolStatus: $recieveTolStatus, mom: $mom, chatShow: $chatShow, userStatus: $userStatus}';
  }
}

class Message {
  Message({
    this.id = 0,
    this.userId = 0,
    this.partnerId = 0,
    this.message = '',
    this.partner,
    this.read = 0,
    this.love = 0,
    this.createdAt,
    this.updatedAt,
    this.type = '',
    this.mode = '',
  });

  int? id;
  int? userId;
  int? partnerId;
  String? message;
  int? read;
  int? love;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? type;
  String? mode;
  Partner? partner;

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? 0 : json["id"],
        userId: json["user_id"] == null ? 0 : json["user_id"],
        partnerId: json["partner_id"] == null ? 0 : json["partner_id"],
        message: json["msg"] == null ? '' : json["msg"],
        partner: json["partner"] == null
            ? Partner.fromMap(json[""])
            : Partner.fromMap(json["partner"]),
        read: json["read"] == null ? 0 : json["read"],
        love: json["love"] == null ? 0 : json["love"],
        type: json["type"] == null ? '' : json["type"],
        mode: json["mode"] == null ? '' : json["mode"],
        createdAt: json["created_at"] == null
            ? DateTime.parse(json[""])
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.parse(json[""])
            : DateTime.parse(json["updated_at"]),
      );

  @override
  String toString() {
    return 'Message{id: $id, userId: $userId, partnerId: $partnerId, message: $message, read: $read, love: $love, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  Map<String, dynamic> toMap() => {
        "id": id == null ? 0 : id,
        "user_id": userId == null ? 0 : userId,
        "partner_id": partnerId == null ? 0 : partnerId,
        "msg": message == null ? '' : message,
        "read": read == null ? 0 : read,
        "type": read == null ? 0 : read,
        "mode": mode == null ? '' : mode,
        "love": love == null ? 0 : love,
        "created_at": createdAt == null ? '' : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? '' : updatedAt?.toIso8601String(),
      };
}

// class Mom {
//   Mom({
//     this.id = 0,
//     this.userId = 0,
//     this.partnerId = 0,
//     this.momType = '',
//     //this.momStatus = '',
//     this.message,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.snoozeAt,
//   });

//   int id;
//   int userId;
//   int partnerId;
//   String momType;
//   //String momStatus;
//   dynamic message;
//   dynamic deletedAt;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic snoozeAt;

//   factory Mom.fromMap(Map<String, dynamic> json) => Mom(
//         id: json["id"] == null ? 0 : json["id"],
//         userId: json["user_id"] == null ? 0 : json["user_id"],
//         partnerId: json["partner_id"] == null ? 0 : json["partner_id"],
//         momType: json["mom_type"] == null ? '' : json["mom_type"],
//         //momStatus: json["mom_status"] == null ? '' : json["mom_status"],
//         message: json["message"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? ''
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? ''
//             : DateTime.parse(json["updated_at"]),
//         snoozeAt:
//             json["snooze_at"] == null ? '' : DateTime.parse(json["snooze_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? 0 : id,
//         "user_id": userId == null ? 0 : userId,
//         "partner_id": partnerId == null ? 0 : partnerId,
//         "mom_type": momType == null ? '' : momType,
//         //"mom_status": momStatus == null ? '' : momStatus,
//         "message": message,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? '' : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? '' : updatedAt.toIso8601String(),
//         "snooze_at": snoozeAt == null ? '' : snoozeAt.toIso8601String(),
//       };
// }
