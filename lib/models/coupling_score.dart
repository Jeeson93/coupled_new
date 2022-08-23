// To parse this JSON data, do
//
//     final couplingScoreModel = couplingScoreModelFromMap(jsonString);

import 'dart:convert';
import 'profile.dart';

CouplingScoreModel couplingScoreModelFromMap(String str) =>
    CouplingScoreModel.fromMap(json.decode(str));

String couplingScoreModelToMap(CouplingScoreModel data) =>
    json.encode(data.toMap());

class CouplingScoreModel {
  CouplingScoreModel({
    this.status,
    this.response,
    this.code,
  });

  dynamic status;
  CouplingScoreModelResponse? response;
  dynamic code;

  factory CouplingScoreModel.fromMap(Map<String, dynamic> json) =>
      CouplingScoreModel(
        status: json["status"] == null ? null : json["status"],
        response: CouplingScoreModelResponse.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response!.toMap(),
        "code": code == null ? null : code,
      };
}

class CouplingScoreModelResponse {
  CouplingScoreModelResponse({
    this.score = 0,
    this.physicalScore,
    this.psychologicalScore,
    this.physical,
    this.psychological,
    this.mom,
  });

  dynamic score;
  dynamic physicalScore;
  dynamic psychologicalScore;
  List<Ical>? physical;
  List<Ical>? psychological;
  Mom? mom;

  factory CouplingScoreModelResponse.fromMap(Map<String, dynamic> json) =>
      CouplingScoreModelResponse(
        score: json["score"] == null ? 0 : json["score"],
        physicalScore:
            json["physical_score"] == null ? null : json["physical_score"],
        psychologicalScore: json["psychological_score"] == null
            ? null
            : json["psychological_score"],
        physical: json["physical"] == null
            ? []
            : List<Ical>.from(json["physical"].map((x) => Ical.fromMap(x))),
        psychological: json["psychological"] == null
            ? []
            : List<Ical>.from(
                json["psychological"].map((x) => Ical.fromMap(x))),
        mom: json["mom"] == null ? Mom.fromMap({}) : Mom.fromMap(json["mom"]),
      );

  Map<String, dynamic> toMap() => {
        "score": score == null ? null : score,
        "physical_score": physicalScore == null ? null : physicalScore,
        "psychological_score":
            psychologicalScore == null ? null : psychologicalScore,
        "physical": physical == null
            ? null
            : List<dynamic>.from(physical!.map((x) => x.toMap())),
        "psychological": psychological == null
            ? null
            : List<dynamic>.from(psychological!.map((x) => x.toMap())),
        "mom": mom == null ? null : mom!.toMap(),
      };
}

/*class Mom {
  Mom({
    this.id,
    this.userId,
    this.partnerId,
    this.momType,
    this.momStatus,
    this.message,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.momHistory,
  });

  int id;
  int userId;
  int partnerId;
  String momType;
  String momStatus;
  dynamic message;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<MomHistory> momHistory;

  factory Mom.fromMap(Map<String, dynamic> json) => Mom(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        momType: json["mom_type"] == null ? null : json["mom_type"],
        momStatus: json["mom_status"] == null ? null : json["mom_status"],
        message: json["message"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        momHistory: json["mom_history"] == null
            ? null
            : List<MomHistory>.from(
                json["mom_history"].map((x) => MomHistory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "partner_id": partnerId == null ? null : partnerId,
        "mom_type": momType == null ? null : momType,
        "mom_status": momStatus == null ? null : momStatus,
        "message": message,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "mom_history": momHistory == null
            ? null
            : List<dynamic>.from(momHistory.map((x) => x.toMap())),
      };
}*/

class MomHistory {
  MomHistory({
    this.id,
    this.userId,
    this.partnerId,
    this.momId,
    this.momType,
    this.momStatus,
    this.message,
    this.adminMessage,
    this.userHide,
    this.partnerHide,
    this.seenAt,
    this.remindAt,
    this.snoozeAt,
    this.actionAt,
    this.actionCount,
    this.statusPosition,
    this.viewAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.historyText,
    this.loveGiven,
    this.loveRecieve,
  });

  dynamic id;
  dynamic userId;
  dynamic partnerId;
  dynamic momId;
  dynamic momType;
  dynamic momStatus;
  dynamic message;
  dynamic adminMessage;
  dynamic userHide;
  dynamic partnerHide;
  dynamic seenAt;
  dynamic remindAt;
  dynamic snoozeAt;
  dynamic actionAt;
  dynamic actionCount;
  dynamic statusPosition;
  dynamic viewAt;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic historyText;
  dynamic loveGiven;
  dynamic loveRecieve;

  factory MomHistory.fromMap(Map<String, dynamic> json) => MomHistory(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        momId: json["mom_id"] == null ? null : json["mom_id"],
        momType: json["mom_type"] == null ? null : json["mom_type"],
        momStatus: json["mom_status"] == null ? null : json["mom_status"],
        message: json["message"],
        adminMessage: json["admin_message"],
        userHide: json["user_hide"] == null ? null : json["user_hide"],
        partnerHide: json["partner_hide"] == null ? null : json["partner_hide"],
        seenAt:
            json["seen_at"] == null ? null : DateTime.parse(json["seen_at"]),
        remindAt: json["remind_at"],
        snoozeAt: json["snooze_at"],
        actionAt: json["action_at"],
        actionCount: json["action_count"],
        statusPosition:
            json["status_position"] == null ? null : json["status_position"],
        viewAt: json["view_at"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        historyText: json["history_text"] == null ? null : json["history_text"],
        loveGiven: json["love_given"] == null ? null : json["love_given"],
        loveRecieve: json["love_recieve"] == null ? null : json["love_recieve"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "partner_id": partnerId == null ? null : partnerId,
        "mom_id": momId == null ? null : momId,
        "mom_type": momType == null ? null : momType,
        "mom_status": momStatus == null ? null : momStatus,
        "message": message,
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
        "love_given": loveGiven == null ? null : loveGiven,
        "love_recieve": loveRecieve == null ? null : loveRecieve,
      };
}

class Ical {
  Ical({
    this.id,
    this.couplingType,
    this.type,
    this.question,
    this.questionOrder,
    this.parent,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.score,
    this.message,
  });

  dynamic id;
  dynamic couplingType;
  dynamic type;
  dynamic question;
  dynamic questionOrder;
  dynamic parent;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic score;
  dynamic message;

  factory Ical.fromMap(Map<String, dynamic> json) => Ical(
        id: json["id"] == null ? null : json["id"],
        couplingType:
            json["coupling_type"] == null ? null : json["coupling_type"],
        type: json["type"] == null ? null : json["type"],
        question: json["question"] == null ? null : json["question"],
        questionOrder:
            json["question_order"] == null ? null : json["question_order"],
        parent: json["parent"] == null ? null : json["parent"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        score: json["score"] == null ? null : json["score"].toDouble(),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "coupling_type": couplingType == null ? null : couplingType,
        "type": type == null ? null : type,
        "question": question == null ? null : question,
        "question_order": questionOrder == null ? null : questionOrder,
        "parent": parent == null ? null : parent,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "score": score == null ? null : score,
        "message": message == null ? null : message,
      };
}
