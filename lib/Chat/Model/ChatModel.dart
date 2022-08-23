import 'dart:math';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ChatModel.g.dart';

@JsonSerializable(
    includeIfNull: true, checked: true, createToJson: true, createFactory: true)
class ChatModel {
  @JsonKey(defaultValue: "")
  String status;
  List<ChatResponse?>? response;
  @JsonKey(defaultValue: 0)
  int code;

  ChatModel({
    this.status = '',
    this.response,
    this.code = 0,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  @override
  String toString() {
    return 'ChatModel{status: $status, response: $response, code: $code}';
  }
}

@JsonSerializable(
    includeIfNull: true,
    createToJson: true,
    createFactory: true,
    explicitToJson: true,
    disallowUnrecognizedKeys: false,
    fieldRename: FieldRename.snake)
class ChatResponse {
  @JsonKey(defaultValue: 0)
  int id;
  @JsonKey(defaultValue: 0)
  int readCount;
  @JsonKey(defaultValue: 0)
  int userId;
  @JsonKey(defaultValue: 0)
  int partnerId;
  @JsonKey(defaultValue: '')
  String message;
  @JsonKey(defaultValue: 0)
  int read;
  @JsonKey(defaultValue: 0)
  int love;

  @JsonKey(defaultValue: null)
  MomM? mom;
  dynamic createdAt = DateTime(0);
  dynamic updatedAt = DateTime(0);
  PartnerDetails? partner;

  ChatResponse({
    this.id = 0,
    this.userId = 0,
    this.partnerId = 0,
    this.message = '',
    this.read = 0,
    this.love = 0,
    this.createdAt,
    this.updatedAt,
    this.partner,
    this.readCount = 0,
    this.mom,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);

  @override
  String toString() {
    return 'ChatResponse{id: $id, userId: $userId,mom: $mom, partnerId: $partnerId, message: $message, read: $read, '
        'love: $love, createdAt: $createdAt, updatedAt: $updatedAt, partner: $partner,read_count: $readCount}';
  }
}

class ChatEvent {
  @JsonKey(defaultValue: "")
  String id = '', infoMsg = '', time = '', date = '';

  ChatEvent({this.id = '', this.infoMsg = '', this.time = '', this.date = ''});

  ChatEvent.init();

  @override
  @JsonKey(defaultValue: "")
  String toString() {
    return 'ChatEvent{id: $id, infoMsg: $infoMsg, time: $time, date: $date}';
  }

  List<ChatEvent> generateChatEvents() {
    List<ChatEvent> chatEvent = List<ChatEvent>.generate(3, (i) {
      return ChatEvent(
        id: "${Random().nextInt(2)}",
        infoMsg: "hi",
        date: "2019.10.9",
        time: "10.24 AM",
      );
    }, growable: true);
    return chatEvent;
  }
}
