import 'dart:convert';

EventModel eventModelFromMap(String str) =>
    EventModel.fromMap(json.decode(str));

String eventModelToMap(EventModel data) => json.encode(data.toMap());

class EventModel {
  EventModel({
    this.status = '',
    this.response = const <Response>[],
    this.code = 0,
  });

  String status;
  List<Response> response;
  int code;

  factory EventModel.fromMap(Map<String, dynamic> json) => EventModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? []
            : List<Response>.from(
                json["response"].map((x) => Response.fromMap(x))),
        code: json["code"] == 0 ? 0 : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == '' ? '' : status,
        "response": response == []
            ? []
            : List<dynamic>.from(response.map((x) => x.toMap())),
        "code": code == null ? null : code,
      };
}

class Response {
  Response({
    this.id = 0,
    this.userId = 0,
    this.partnerId = 0,
    this.momId = 0,
    this.momType = '',
    this.momStatus = '',
    this.message = '',
    this.adminMessage,
    this.userHide = 0,
    this.partnerHide = 0,
    this.seenAt,
    this.remindAt,
    this.snoozeAt,
    this.actionAt,
    this.actionCount,
    this.statusPosition = '',
    this.viewAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.historyText = '',
  });

  int id;
  int userId;
  int partnerId;
  int momId;
  String momType;
  String momStatus;
  String message;
  dynamic adminMessage;
  int userHide;
  int partnerHide;
  dynamic seenAt;
  dynamic remindAt;
  dynamic snoozeAt;
  dynamic actionAt;
  dynamic actionCount;
  String statusPosition;
  dynamic viewAt;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  String historyText;

  factory Response.fromMap(Map<String, dynamic> json) => Response(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        momId: json["mom_id"] == null ? null : json["mom_id"],
        momType: json["mom_type"] == null ? null : json["mom_type"],
        momStatus: json["mom_status"] == null ? '' : json["mom_status"],
        message: json["message"] == null ? '' : json["message"],
        adminMessage: json["admin_message"],
        userHide: json["user_hide"] == null ? null : json["user_hide"],
        partnerHide: json["partner_hide"] == null ? null : json["partner_hide"],
        seenAt: json["seen_at"] == null ? '' : DateTime.parse(json["seen_at"]),
        remindAt: json["remind_at"],
        snoozeAt: json["snooze_at"],
        actionAt: json["action_at"],
        actionCount: json["action_count"],
        statusPosition:
            json["status_position"] == null ? null : json["status_position"],
        viewAt: json["view_at"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? ''
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? ''
            : DateTime.parse(json["updated_at"]),
        historyText: json["history_text"] == null ? null : json["history_text"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "partner_id": partnerId == null ? null : partnerId,
        "mom_id": momId == null ? null : momId,
        "mom_type": momType == null ? null : momType,
        "mom_status": momStatus == null ? null : momStatus,
        "message": message == null ? null : message,
        "admin_message": adminMessage,
        "user_hide": userHide == null ? null : userHide,
        "partner_hide": partnerHide == null ? null : partnerHide,
        "seen_at": seenAt == null ? null : seenAt.toIso8601String(),
        "remind_at": remindAt,
        "snooze_at": snoozeAt,
        "action_at": actionAt,
        "action_count": actionCount,
        "status_position": statusPosition == null ? null : statusPosition,
        "view_at": viewAt,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "history_text": historyText == null ? null : historyText,
      };
}
