// To parse this JSON data, do
//
//     final matchOMeterModel = matchOMeterModelFromJson(jsonString);

import 'dart:convert';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/match_o_meter_model.dart';

MatchOMeterModel matchOMeterModelFromJson(String str) =>
    MatchOMeterModel.fromJson(json.decode(str));

String matchOMeterModelToJson(MatchOMeterModel data) =>
    json.encode(data.toJson());

class MatchOMeterModel {
  String? status;
  MoMResponse? response;
  int? code;
  dynamic path;

  MatchOMeterModel({
    this.status = '',
    this.path,
    this.response,
    this.code = 0,
  });

  factory MatchOMeterModel.fromJson(Map<String, dynamic> json) =>
      MatchOMeterModel(
        status: json["status"] == null ? null : json["status"],
        response: MoMResponse.fromJson(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response!.toJson(),
        "code": code == null ? null : code,
      };
}

class MoMResponse {
  dynamic currentPage;
  List<MomDatum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  MoMResponse({
    this.currentPage = 1,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory MoMResponse.fromJson(Map<String, dynamic> json) => MoMResponse(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<MomDatum>.from(
                json["data"].map((x) => MomDatum.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class MomM {
  dynamic id;
  dynamic userId;
  dynamic partnerId;
  dynamic momType;
  dynamic momStatus;
  dynamic message;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic momHistory;

  MomM({
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

  factory MomM.fromJson(Map<String, dynamic> json) => MomM(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        momType: json["mom_type"] == null ? null : json["mom_type"],
        momStatus: json["mom_status"] == null ? null : json["mom_status"],
        message: json["message"] == null ? null : json["message"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        momHistory: json["mom_history"] == null
            ? []
            : List<MomDatum>.from(
                json["mom_history"].map((x) => MomDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "partner_id": partnerId == null ? null : partnerId,
        "mom_type": momType == null ? null : momType,
        "mom_status": momStatus == null ? null : momStatus,
        "message": message == null ? null : message,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "mom_history": momHistory == null
            ? null
            : List<dynamic>.from(momHistory.map((x) => x.toJson())),
      };
}

class MomDatum {
  int? id;
  int? userId;
  int? partnerId;
  int? momId;
  String? momType;
  String? momStatus;
  String? message;
  String? adminMessage;
  int? userHide;
  int? partnerHide;
  dynamic seenAt;
  DateTime? remindAt;
  dynamic snoozeAt;
  DateTime? actionAt;
  int? actionCount;
  dynamic statusPosition;
  DateTime? viewAt;
  DateTime? deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  String? historyText;
  PartnerDetails? user;
  PartnerDetails? partner;
  MomM? mom;
  List<MomReason>? momReasons;
  UserScore? partnerScore;
  UserScore? partnerUserScore;
  UserScore? userScore;
  UserScore? userPartnerScore;
  dynamic loveGiven;
  dynamic loveRecieve;
  dynamic isSelected = false;

  MomDatum({
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
    this.user,
    this.partner,
    this.mom,
    this.momReasons,
    this.partnerScore,
    this.partnerUserScore,
    this.userScore,
    this.userPartnerScore,
    this.loveGiven,
    this.loveRecieve,
    this.isSelected,
  });

  factory MomDatum.fromJson(Map<String, dynamic> json) => MomDatum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        momId: json["mom_id"] == null ? null : json["mom_id"],
        momType: json["mom_type"] == null ? null : json["mom_type"],
        momStatus: json["mom_status"] == null ? null : json["mom_status"],
        message: json["message"] == null ? null : json["message"],
        adminMessage: json["admin_message"],
        userHide: json["user_hide"] == null ? null : json["user_hide"],
        partnerHide: json["partner_hide"] == null ? null : json["partner_hide"],
        loveGiven: json["love_given"] == null ? null : json["love_given"],
        loveRecieve: json["love_recieve"] == null ? null : json["love_recieve"],
        seenAt:
            json["seen_at"] == null ? null : DateTime.parse(json["seen_at"]),
        remindAt: json["remind_at"] == null
            ? null
            : DateTime.parse(json["remind_at"]),
        snoozeAt: json["snooze_at"] == null
            ? null
            : DateTime.parse(json["snooze_at"]),
        actionAt: json["action_at"] == null
            ? null
            : DateTime.parse(json["action_at"]),
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
        user:
            json["user"] == null ? null : PartnerDetails.fromJson(json["user"]),
        partner: json["partner"] == null
            ? null
            : PartnerDetails.fromJson(json["partner"]),
        momReasons: json["mom_reasons"] == null
            ? null
            : List<MomReason>.from(
                json["mom_reasons"].map((x) => MomReason.fromJson(x))),
        mom: json["mom"] == null ? null : MomM.fromJson(json["mom"]),
        partnerScore: json["partner_score"] == null
            ? null
            : UserScore.fromJson(json["partner_score"]),
        partnerUserScore: json["partner_user_score"] == null
            ? null
            : UserScore.fromJson(json["partner_user_score"]),
        userScore: json["user_score"] == null
            ? null
            : UserScore.fromJson(json["user_score"]),
        userPartnerScore: json["user_partner_score"] == null
            ? null
            : UserScore.fromJson(json["user_partner_score"]),
      );

  Map<String, dynamic> toJson() => {
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
        "seen_at": seenAt == null ? null : seenAt?.toIso8601String(),
        "remind_at": remindAt,
        "snooze_at": snoozeAt,
        "action_at": actionAt,
        "action_count": actionCount,
        "status_position": statusPosition == null ? null : statusPosition,
        "view_at": viewAt,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "history_text": historyText == null ? null : historyText,
        "user": user == null ? null : user?.toJson(),
        "partner": partner == null ? null : partner?.toJson(),
        "mom": mom == null ? null : mom?.toJson(),
        "partner_score": partnerScore,
        "partner_user_score": partnerUserScore,
      };
}

class MomReason {
  dynamic id;
  dynamic momHistoryId;
  dynamic userId;
  dynamic partnerId;
  dynamic reasonId;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  Reason? reason;

  MomReason({
    this.id,
    this.momHistoryId,
    this.userId,
    this.partnerId,
    this.reasonId,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.reason,
  });

  factory MomReason.fromJson(Map<String, dynamic> json) => MomReason(
        id: json["id"] == null ? null : json["id"],
        momHistoryId:
            json["mom_history_id"] == null ? null : json["mom_history_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        reasonId: json["reason_id"] == null ? null : json["reason_id"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        reason: json["reason"] == null ? null : Reason.fromJson(json["reason"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "mom_history_id": momHistoryId == null ? null : momHistoryId,
        "user_id": userId == null ? null : userId,
        "partner_id": partnerId == null ? null : partnerId,
        "reason_id": reasonId == null ? null : reasonId,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "reason": reason == null ? null : reason?.toJson(),
      };
}

class Reason {
  dynamic id;
  dynamic type;
  dynamic value;
  dynamic parentId;
  dynamic others;
  dynamic status;

  Reason({
    this.id,
    this.type,
    this.value,
    this.parentId,
    this.others,
    this.status,
  });

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        value: json["value"] == null ? null : json["value"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        others: json["others"] == null ? null : json["others"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "value": value == null ? null : value,
        "parent_id": parentId == null ? null : parentId,
        "others": others == null ? null : others,
        "status": status == null ? null : status,
      };
}

class UserScore {
  dynamic id;
  dynamic userId;
  dynamic partnerId;
  dynamic score;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  UserScore({
    this.id,
    this.userId,
    this.partnerId,
    this.score,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserScore.fromJson(Map<String, dynamic> json) => UserScore(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        score: json["score"] == null ? null : json["score"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "partner_id": partnerId == null ? null : partnerId,
        "score": score == null ? null : score,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class PartnerDetails {
  int? id;
  String? name;
  String? lastName;
  String? membershipCode;
  String? gender;
  String? profilePic;
  int? emailVerification;
  int? mobileVerification;
  int? isActive;
  DateTime? lastActive;
  dynamic hideAt;
  bool? recommend;
  Info? info;
  int? score;
  Dp? dp;
  List<Dp>? photos;

  PartnerDetails({
    this.score,
    this.id,
    this.name,
    this.lastName,
    this.membershipCode,
    this.gender,
    this.profilePic,
    this.emailVerification,
    this.mobileVerification,
    this.isActive,
    this.lastActive,
    this.hideAt,
    this.recommend,
    this.info,
    this.dp,
    this.photos,
  });

  factory PartnerDetails.fromJson(Map<String, dynamic> json) => PartnerDetails(
        id: json["id"] == null ? null : json["id"],
        score: json["score"] == null ? null : json["score"],
        name: json["name"] == null ? null : json["name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        membershipCode:
            json["membership_code"] == null ? '' : json["membership_code"],
        gender: json["gender"] == null ? null : json["gender"],
        profilePic: json["profile_pic"] == null ? null : json["profile_pic"],
        emailVerification: json["email_verification"] == null
            ? null
            : json["email_verification"],
        mobileVerification: json["mobile_verification"] == null
            ? null
            : json["mobile_verification"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        lastActive: json["last_active"] == null
            ? null
            : DateTime.parse(json["last_active"]),
        hideAt: json["hide_at"],
        recommend: json["recommend"] == null ? null : json["recommend"],
        info: json["info"] == null ? null : Info.fromMap(json["info"]),
        dp: json["dp"] == null ? null : Dp.fromMap(json["dp"]),
        photos: json["photos"] == null
            ? null
            : List<Dp>.from(json["photos"].map((x) => Dp.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "last_name": lastName == null ? null : lastName,
        "membership_code": membershipCode == null ? '' : membershipCode,
        "gender": gender == null ? null : gender,
        "profile_pic": profilePic == null ? null : profilePic,
        "email_verification":
            emailVerification == null ? null : emailVerification,
        "mobile_verification":
            mobileVerification == null ? null : mobileVerification,
        "is_active": isActive == null ? null : isActive,
        "last_active":
            lastActive == null ? null : lastActive?.toIso8601String(),
        "hide_at": hideAt,
        "recommend": recommend == null ? null : recommend,
        "info": info == null ? null : info!.toMap(),
        "dp": dp == null ? null : dp?.toMap(),
        "photos": photos == null
            ? null
            : List<dynamic>.from(photos!.map((x) => x.toMap())),
      };
}

class ImageTaken {
  dynamic id;
  dynamic type;
  dynamic value;
  dynamic parentId;
  dynamic others;
  dynamic status;

  ImageTaken({
    this.id,
    this.type,
    this.value,
    this.parentId,
    this.others,
    this.status,
  });

  factory ImageTaken.fromJson(Map<String, dynamic> json) => ImageTaken(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        value: json["value"] == null ? null : json["value"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        others: json["others"] == null ? null : json["others"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "value": value == null ? null : value,
        "parent_id": parentId == null ? null : parentId,
        "others": others == null ? null : others,
        "status": status == null ? null : status,
      };
}

// To parse this JSON data, do
//
//     final matchOMeterModel = matchOMeterModelFromMap(jsonString);

// import 'dart:convert';

// MatchOMeterModel matchOMeterModelFromMap(String str) => MatchOMeterModel.fromMap(json.decode(str));

// String matchOMeterModelToMap(MatchOMeterModel data) => json.encode(data.toMap());

// class MatchOMeterModel {
//     MatchOMeterModel({
//         this.status='',
//         required this.response,
//         this.code=0,
//     });

//     String status;
//     MoMResponse response;
//     int code;

//     factory MatchOMeterModel.fromMap(Map<String, dynamic> json) => MatchOMeterModel(
//         status: json["status"],
//         response: MoMResponse.fromMap(json["response"]),
//         code: json["code"],
//     );

//     Map<String, dynamic> toMap() => {
//         "status": status,
//         "response": response.toMap(),
//         "code": code,
//     };
// }

// class MoMResponse {
//     MoMResponse({
//         this.currentPage,
//         this.data,
//         this.firstPageUrl,
//         this.from,
//         this.lastPage,
//         this.lastPageUrl,
//         this.nextPageUrl,
//         this.path,
//         this.perPage,
//         this.prevPageUrl,
//         this.to,
//         this.total,
//     });

//     int currentPage;
//     List<MomDatum> data;
//     String firstPageUrl;
//     int from;
//     int lastPage;
//     String lastPageUrl;
//     dynamic nextPageUrl;
//     String path;
//     int perPage;
//     dynamic prevPageUrl;
//     int to;
//     int total;

//     factory MoMResponse.fromMap(Map<String, dynamic> json) => MoMResponse(
//         currentPage: json["current_page"],
//         data: List<MomDatum>.from(json["data"].map((x) => MomDatum.fromMap(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//     );

//     Map<String, dynamic> toMap() => {
//         "current_page": currentPage,
//         "data": List<dynamic>.from(data.map((x) => x.toMap())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//     };
// }

// class MomDatum {
//     MomDatum({
//         this.id,
//         this.userId,
//         this.partnerId,
//         this.momId,
//         this.momType,
//         this.momStatus,
//         this.message,
//         this.adminMessage,
//         this.userHide,
//         this.partnerHide,
//         this.seenAt,
//         this.remindAt,
//         this.snoozeAt,
//         this.actionAt,
//         this.actionCount,
//         this.statusPosition,
//         this.viewAt,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.historyText,
//         this.loveGiven,
//         this.loveRecieve,
//         this.user,
//         this.partner,
//         this.mom,
//     });

//     int id;
//     int userId;
//     int partnerId;
//     int momId;
//     MomType momType;
//     dynamic momStatus;
//     String message;
//     dynamic adminMessage;
//     int userHide;
//     int partnerHide;
//     dynamic seenAt;
//     dynamic remindAt;
//     dynamic snoozeAt;
//     dynamic actionAt;
//     dynamic actionCount;
//     StatusPosition statusPosition;
//     dynamic viewAt;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;
//     HistoryText historyText;
//     int loveGiven;
//     int loveRecieve;
//     User user;
//     Partner partner;
//     MomM mom;

//     factory MomDatum.fromMap(Map<String, dynamic> json) => MomDatum(
//         id: json["id"],
//         userId: json["user_id"],
//         partnerId: json["partner_id"],
//         momId: json["mom_id"],
//         momType: momTypeValues.map[json["mom_type"]],
//         momStatus: json["mom_status"],
//         message: json["message"] == null ? null : json["message"],
//         adminMessage: json["admin_message"],
//         userHide: json["user_hide"],
//         partnerHide: json["partner_hide"],
//         seenAt: json["seen_at"],
//         remindAt: json["remind_at"],
//         snoozeAt: json["snooze_at"],
//         actionAt: json["action_at"],
//         actionCount: json["action_count"],
//         statusPosition: statusPositionValues.map[json["status_position"]],
//         viewAt: json["view_at"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         historyText: historyTextValues.map[json["history_text"]],
//         loveGiven: json["love_given"],
//         loveRecieve: json["love_recieve"],
//         user: User.fromMap(json["user"]),
//         partner: Partner.fromMap(json["partner"]),
//         mom: MomM.fromMap(json["mom"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "partner_id": partnerId,
//         "mom_id": momId,
//         "mom_type": momTypeValues.reverse[momType],
//         "mom_status": momStatus,
//         "message": message == null ? null : message,
//         "admin_message": adminMessage,
//         "user_hide": userHide,
//         "partner_hide": partnerHide,
//         "seen_at": seenAt,
//         "remind_at": remindAt,
//         "snooze_at": snoozeAt,
//         "action_at": actionAt,
//         "action_count": actionCount,
//         "status_position": statusPositionValues.reverse[statusPosition],
//         "view_at": viewAt,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "history_text": historyTextValues.reverse[historyText],
//         "love_given": loveGiven,
//         "love_recieve": loveRecieve,
//         "user": user.toMap(),
//         "partner": partner.toMap(),
//         "mom": mom.toMap(),
//     };
// }

// enum HistoryText { REQUESTED_TO_CONNECT, VIEWED_THE_PROFILE }

// final historyTextValues = EnumValues({
//     "Requested to connect": HistoryText.REQUESTED_TO_CONNECT,
//     "Viewed the profile": HistoryText.VIEWED_THE_PROFILE
// });

// class MomM {
//     MomM({
//         this.id,
//         this.userId,
//         this.partnerId,
//         this.momType,
//         this.momStatus,
//         this.message,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.momHistory,
//     });

//     int id;
//     int userId;
//     int partnerId;
//     MomType momType;
//     MomStatus momStatus;
//     String message;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;
//     List<MomHistory> momHistory;

//     factory MomM.fromMap(Map<String, dynamic> json) => MomM(
//         id: json["id"],
//         userId: json["user_id"],
//         partnerId: json["partner_id"],
//         momType: momTypeValues.map[json["mom_type"]],
//         momStatus: momStatusValues.map[json["mom_status"]],
//         message: json["message"] == null ? null : json["message"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         momHistory: List<MomHistory>.from(json["mom_history"].map((x) => MomHistory.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "partner_id": partnerId,
//         "mom_type": momTypeValues.reverse[momType],
//         "mom_status": momStatusValues.reverse[momStatus],
//         "message": message == null ? null : message,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "mom_history": List<dynamic>.from(momHistory.map((x) => x.toMap())),
//     };
// }

// class MomHistory {
//     MomHistory({
//         this.id,
//         this.userId,
//         this.partnerId,
//         this.momId,
//         this.momType,
//         this.momStatus,
//         this.message,
//         this.adminMessage,
//         this.userHide,
//         this.partnerHide,
//         this.seenAt,
//         this.remindAt,
//         this.snoozeAt,
//         this.actionAt,
//         this.actionCount,
//         this.statusPosition,
//         this.viewAt,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.historyText,
//         this.loveGiven,
//         this.loveRecieve,
//     });

//     int id;
//     int userId;
//     int partnerId;
//     int momId;
//     MomType momType;
//     dynamic momStatus;
//     String message;
//     dynamic adminMessage;
//     int userHide;
//     int partnerHide;
//     dynamic seenAt;
//     dynamic remindAt;
//     dynamic snoozeAt;
//     dynamic actionAt;
//     dynamic actionCount;
//     StatusPosition statusPosition;
//     dynamic viewAt;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;
//     HistoryText historyText;
//     int loveGiven;
//     int loveRecieve;

//     factory MomHistory.fromMap(Map<String, dynamic> json) => MomHistory(
//         id: json["id"],
//         userId: json["user_id"],
//         partnerId: json["partner_id"],
//         momId: json["mom_id"],
//         momType: momTypeValues.map[json["mom_type"]],
//         momStatus: json["mom_status"],
//         message: json["message"] == null ? null : json["message"],
//         adminMessage: json["admin_message"],
//         userHide: json["user_hide"],
//         partnerHide: json["partner_hide"],
//         seenAt: json["seen_at"],
//         remindAt: json["remind_at"],
//         snoozeAt: json["snooze_at"],
//         actionAt: json["action_at"],
//         actionCount: json["action_count"],
//         statusPosition: statusPositionValues.map[json["status_position"]],
//         viewAt: json["view_at"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         historyText: historyTextValues.map[json["history_text"]],
//         loveGiven: json["love_given"],
//         loveRecieve: json["love_recieve"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "partner_id": partnerId,
//         "mom_id": momId,
//         "mom_type": momTypeValues.reverse[momType],
//         "mom_status": momStatus,
//         "message": message == null ? null : message,
//         "admin_message": adminMessage,
//         "user_hide": userHide,
//         "partner_hide": partnerHide,
//         "seen_at": seenAt,
//         "remind_at": remindAt,
//         "snooze_at": snoozeAt,
//         "action_at": actionAt,
//         "action_count": actionCount,
//         "status_position": statusPositionValues.reverse[statusPosition],
//         "view_at": viewAt,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "history_text": historyTextValues.reverse[historyText],
//         "love_given": loveGiven,
//         "love_recieve": loveRecieve,
//     };
// }

// enum MomType { CONNECT, VIEW }

// final momTypeValues = EnumValues({
//     "connect": MomType.CONNECT,
//     "view": MomType.VIEW
// });

// enum StatusPosition { ACTIVATE, DEACTIVATE }

// final statusPositionValues = EnumValues({
//     "activate": StatusPosition.ACTIVATE,
//     "deactivate": StatusPosition.DEACTIVATE
// });

// enum MomStatus { SENT }

// final momStatusValues = EnumValues({
//     "sent": MomStatus.SENT
// });

// class Partner {
//     Partner({
//         this.id,
//         this.name,
//         this.lastName,
//         this.notification,
//         this.membershipCode,
//         this.gender,
//         this.profilePic,
//         this.emailVerification,
//         this.mobileVerification,
//         this.isActive,
//         this.edited,
//         this.online,
//         this.lastActive,
//         this.hideAt,
//         this.govtIdAt,
//         this.officeIdAt,
//         this.photoAt,
//         this.loginCount,
//         this.recommend,
//         this.membership,
//         this.score,
//         this.recomendCauseCount,
//         this.passwordStatus,
//         this.info,
//         this.dp,
//         this.photos,
//         this.officialDocuments,
//     });

//     int id;
//     String name;
//     String lastName;
//     int notification;
//     String membershipCode;
//     PartnerGender gender;
//     dynamic profilePic;
//     int emailVerification;
//     int mobileVerification;
//     int isActive;
//     int edited;
//     int online;
//     DateTime lastActive;
//     dynamic hideAt;
//     dynamic govtIdAt;
//     dynamic officeIdAt;
//     dynamic photoAt;
//     int loginCount;
//     bool recommend;
//     Membership membership;
//     int score;
//     int recomendCauseCount;
//     bool passwordStatus;
//     PartnerInfo info;
//     PartnerDp dp;
//     List<PartnerPhoto> photos;
//     PartnerOfficialDocuments officialDocuments;

//     factory Partner.fromMap(Map<String, dynamic> json) => Partner(
//         id: json["id"],
//         name: json["name"],
//         lastName: json["last_name"],
//         notification: json["notification"],
//         membershipCode: json["membership_code"],
//         gender: partnerGenderValues.map[json["gender"]],
//         profilePic: json["profile_pic"],
//         emailVerification: json["email_verification"],
//         mobileVerification: json["mobile_verification"],
//         isActive: json["is_active"],
//         edited: json["edited"],
//         online: json["online"],
//         lastActive: DateTime.parse(json["last_active"]),
//         hideAt: json["hide_at"],
//         govtIdAt: json["govt_id_at"],
//         officeIdAt: json["office_id_at"],
//         photoAt: json["photo_at"],
//         loginCount: json["login_count"] == null ? null : json["login_count"],
//         recommend: json["recommend"],
//         membership: Membership.fromMap(json["membership"]),
//         score: json["score"],
//         recomendCauseCount: json["recomend_cause_count"],
//         passwordStatus: json["password_status"],
//         info: PartnerInfo.fromMap(json["info"]),
//         dp: PartnerDp.fromMap(json["dp"]),
//         photos: List<PartnerPhoto>.from(json["photos"].map((x) => PartnerPhoto.fromMap(x))),
//         officialDocuments: PartnerOfficialDocuments.fromMap(json["official_documents"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "last_name": lastName,
//         "notification": notification,
//         "membership_code": membershipCode,
//         "gender": partnerGenderValues.reverse[gender],
//         "profile_pic": profilePic,
//         "email_verification": emailVerification,
//         "mobile_verification": mobileVerification,
//         "is_active": isActive,
//         "edited": edited,
//         "online": online,
//         "last_active": lastActive.toIso8601String(),
//         "hide_at": hideAt,
//         "govt_id_at": govtIdAt,
//         "office_id_at": officeIdAt,
//         "photo_at": photoAt,
//         "login_count": loginCount == null ? null : loginCount,
//         "recommend": recommend,
//         "membership": membership.toMap(),
//         "score": score,
//         "recomend_cause_count": recomendCauseCount,
//         "password_status": passwordStatus,
//         "info": info.toMap(),
//         "dp": dp.toMap(),
//         "photos": List<dynamic>.from(photos.map((x) => x.toMap())),
//         "official_documents": officialDocuments.toMap(),
//     };
// }

// class PartnerDp {
//     PartnerDp({
//         this.id,
//         this.userId,
//         this.fromType,
//         this.imageType,
//         this.status,
//         this.rejectStatus,
//         this.approvedBy,
//         this.photoApprovedAt,
//         this.comments,
//         this.trash,
//         this.imageTaken,
//         this.dpStatus,
//         this.sortOrder,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.photoNames,
//         this.userDetail,
//     });

//     int id;
//     int userId;
//     FromType fromType;
//     ImageType imageType;
//     int status;
//     int rejectStatus;
//     String approvedBy;
//     DateTime photoApprovedAt;
//     dynamic comments;
//     int trash;
//     ImageTaken imageTaken;
//     int dpStatus;
//     int sortOrder;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;
//     PurplePhotoNames photoNames;
//     PurpleUserDetail userDetail;

//     factory PartnerDp.fromMap(Map<String, dynamic> json) => PartnerDp(
//         id: json["id"],
//         userId: json["user_id"],
//         fromType: fromTypeValues.map[json["from_type"]],
//         imageType: ImageType.fromMap(json["image_type"]),
//         status: json["status"],
//         rejectStatus: json["reject_status"],
//         approvedBy: json["approved_by"] == null ? null : json["approved_by"],
//         photoApprovedAt: json["photo_approved_at"] == null ? null : DateTime.parse(json["photo_approved_at"]),
//         comments: json["comments"],
//         trash: json["trash"],
//         imageTaken: ImageTaken.fromMap(json["image_taken"]),
//         dpStatus: json["dp_status"],
//         sortOrder: json["sort_order"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         photoNames: purplePhotoNamesValues.map[json["photo_names"]],
//         userDetail: PurpleUserDetail.fromMap(json["user_detail"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "from_type": fromTypeValues.reverse[fromType],
//         "image_type": imageType.toMap(),
//         "status": status,
//         "reject_status": rejectStatus,
//         "approved_by": approvedBy == null ? null : approvedBy,
//         "photo_approved_at": photoApprovedAt == null ? null : photoApprovedAt.toIso8601String(),
//         "comments": comments,
//         "trash": trash,
//         "image_taken": imageTaken.toMap(),
//         "dp_status": dpStatus,
//         "sort_order": sortOrder,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "photo_names": purplePhotoNamesValues.reverse[photoNames],
//         "user_detail": userDetail.toMap(),
//     };
// }

// enum FromType { GALLERY, FACEBOOK }

// final fromTypeValues = EnumValues({
//     "facebook": FromType.FACEBOOK,
//     "gallery": FromType.GALLERY
// });

// class ImageTaken {
//     ImageTaken({
//         this.id,
//         this.type,
//         this.value,
//         this.parentId,
//         this.others,
//         this.status,
//     });

//     int id;
//     ImageTakenType type;
//     ImageTakenValue value;
//     int parentId;
//     String others;
//     Status status;

//     factory ImageTaken.fromMap(Map<String, dynamic> json) => ImageTaken(
//         id: json["id"],
//         type: imageTakenTypeValues.map[json["type"]],
//         value: imageTakenValueValues.map[json["value"]],
//         parentId: json["parent_id"],
//         others: json["others"],
//         status: statusValues.map[json["status"]],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "type": imageTakenTypeValues.reverse[type],
//         "value": imageTakenValueValues.reverse[value],
//         "parent_id": parentId,
//         "others": others,
//         "status": statusValues.reverse[status],
//     };
// }

// enum Status { ACTIVE }

// final statusValues = EnumValues({
//     "active": Status.ACTIVE
// });

// enum ImageTakenType { PHOTO_AGE }

// final imageTakenTypeValues = EnumValues({
//     "photo_age": ImageTakenType.PHOTO_AGE
// });

// enum ImageTakenValue { RECENT, THE_3_MONTHS, THE_6_MONTHS, OLD }

// final imageTakenValueValues = EnumValues({
//     "Old": ImageTakenValue.OLD,
//     "Recent": ImageTakenValue.RECENT,
//     "3 Months": ImageTakenValue.THE_3_MONTHS,
//     "6 Months": ImageTakenValue.THE_6_MONTHS
// });

// class ImageType {
//     ImageType({
//         this.id,
//         this.type,
//         this.value,
//         this.parentId,
//         this.others,
//         this.status,
//     });

//     int id;
//     ImageTypeType type;
//     ImageTypeValue value;
//     int parentId;
//     String others;
//     Status status;

//     factory ImageType.fromMap(Map<String, dynamic> json) => ImageType(
//         id: json["id"],
//         type: imageTypeTypeValues.map[json["type"]],
//         value: imageTypeValueValues.map[json["value"]],
//         parentId: json["parent_id"],
//         others: json["others"],
//         status: statusValues.map[json["status"]],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "type": imageTypeTypeValues.reverse[type],
//         "value": imageTypeValueValues.reverse[value],
//         "parent_id": parentId,
//         "others": others,
//         "status": statusValues.reverse[status],
//     };
// }

// enum ImageTypeType { PHOTO_TYPE }

// final imageTypeTypeValues = EnumValues({
//     "photo_type": ImageTypeType.PHOTO_TYPE
// });

// enum ImageTypeValue { SELFIE, NORMAL_PROFILE, FULL_PROFILE, NO_FILTER }

// final imageTypeValueValues = EnumValues({
//     "Full Profile": ImageTypeValue.FULL_PROFILE,
//     "Normal Profile": ImageTypeValue.NORMAL_PROFILE,
//     "No Filter": ImageTypeValue.NO_FILTER,
//     "Selfie": ImageTypeValue.SELFIE
// });

// enum PurplePhotoNames { DEFAULT_PNG, THE_1657350739705_JPEG, THE_1650889797448_JPEG }

// final purplePhotoNamesValues = EnumValues({
//     "default.png": PurplePhotoNames.DEFAULT_PNG,
//     "1650889797448.jpeg": PurplePhotoNames.THE_1650889797448_JPEG,
//     "1657350739705.jpeg": PurplePhotoNames.THE_1657350739705_JPEG
// });

// class PurpleUserDetail {
//     PurpleUserDetail({
//         this.id,
//         this.name,
//         this.lastName,
//         this.notification,
//         this.membershipCode,
//         this.gender,
//         this.profilePic,
//         this.emailVerification,
//         this.mobileVerification,
//         this.isActive,
//         this.edited,
//         this.online,
//         this.lastActive,
//         this.hideAt,
//         this.govtIdAt,
//         this.officeIdAt,
//         this.photoAt,
//         this.loginCount,
//         this.recommend,
//         this.membership,
//         this.score,
//         this.recomendCauseCount,
//         this.passwordStatus,
//     });

//     int id;
//     String name;
//     String lastName;
//     int notification;
//     String membershipCode;
//     PartnerGender gender;
//     dynamic profilePic;
//     int emailVerification;
//     int mobileVerification;
//     int isActive;
//     int edited;
//     int online;
//     DateTime lastActive;
//     dynamic hideAt;
//     dynamic govtIdAt;
//     dynamic officeIdAt;
//     dynamic photoAt;
//     int loginCount;
//     bool recommend;
//     Membership membership;
//     int score;
//     int recomendCauseCount;
//     bool passwordStatus;

//     factory PurpleUserDetail.fromMap(Map<String, dynamic> json) => PurpleUserDetail(
//         id: json["id"],
//         name: json["name"],
//         lastName: json["last_name"],
//         notification: json["notification"],
//         membershipCode: json["membership_code"],
//         gender: partnerGenderValues.map[json["gender"]],
//         profilePic: json["profile_pic"],
//         emailVerification: json["email_verification"],
//         mobileVerification: json["mobile_verification"],
//         isActive: json["is_active"],
//         edited: json["edited"],
//         online: json["online"],
//         lastActive: DateTime.parse(json["last_active"]),
//         hideAt: json["hide_at"],
//         govtIdAt: json["govt_id_at"],
//         officeIdAt: json["office_id_at"],
//         photoAt: json["photo_at"],
//         loginCount: json["login_count"] == null ? null : json["login_count"],
//         recommend: json["recommend"],
//         membership: Membership.fromMap(json["membership"]),
//         score: json["score"],
//         recomendCauseCount: json["recomend_cause_count"],
//         passwordStatus: json["password_status"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "last_name": lastName,
//         "notification": notification,
//         "membership_code": membershipCode,
//         "gender": partnerGenderValues.reverse[gender],
//         "profile_pic": profilePic,
//         "email_verification": emailVerification,
//         "mobile_verification": mobileVerification,
//         "is_active": isActive,
//         "edited": edited,
//         "online": online,
//         "last_active": lastActive.toIso8601String(),
//         "hide_at": hideAt,
//         "govt_id_at": govtIdAt,
//         "office_id_at": officeIdAt,
//         "photo_at": photoAt,
//         "login_count": loginCount == null ? null : loginCount,
//         "recommend": recommend,
//         "membership": membership.toMap(),
//         "score": score,
//         "recomend_cause_count": recomendCauseCount,
//         "password_status": passwordStatus,
//     };
// }

// enum PartnerGender { FEMALE }

// final partnerGenderValues = EnumValues({
//     "female": PartnerGender.FEMALE
// });

// class Membership {
//     Membership({
//         this.paidMember,
//         this.planName,
//         this.chat,
//         this.statistics,
//         this.share,
//         this.verificationBadge,
//         this.expiredAt,
//     });

//     bool paidMember;
//     PlanName planName;
//     int chat;
//     int statistics;
//     int share;
//     int verificationBadge;
//     DateTime expiredAt;

//     factory Membership.fromMap(Map<String, dynamic> json) => Membership(
//         paidMember: json["paid_member"],
//         planName: planNameValues.map[json["plan_name"]],
//         chat: json["chat"],
//         statistics: json["statistics"],
//         share: json["share"],
//         verificationBadge: json["verification_badge"],
//         expiredAt: DateTime.parse(json["expired_at"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "paid_member": paidMember,
//         "plan_name": planNameValues.reverse[planName],
//         "chat": chat,
//         "statistics": statistics,
//         "share": share,
//         "verification_badge": verificationBadge,
//         "expired_at": expiredAt.toIso8601String(),
//     };
// }

// enum PlanName { SILVER, FREE, GOLD }

// final planNameValues = EnumValues({
//     "Free": PlanName.FREE,
//     "Gold": PlanName.GOLD,
//     "Silver": PlanName.SILVER
// });

// class PartnerInfo {
//     PartnerInfo({
//         this.id,
//         this.userId,
//         this.dob,
//         this.dobStatus,
//         this.height,
//         this.weight,
//         this.bodyType,
//         this.complexion,
//         this.specialCase,
//         this.specialCaseType,
//         this.specialCaseNotify,
//         this.adminApprovalStatus,
//         this.countryCode,
//         this.country,
//         this.state,
//         this.city,
//         this.locationId,
//         this.maritalStatus,
//         this.numberOfChildren,
//         this.childLivingStatus,
//         this.bornPlace,
//         this.bornTime,
//         this.aboutSelf,
//         this.aboutPartner,
//         this.completedStatus,
//         this.completedIn,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//     });

//     int id;
//     int userId;
//     DateTime dob;
//     int dobStatus;
//     int height;
//     int weight;
//     BodyType bodyType;
//     Complexion complexion;
//     int specialCase;
//     ChildLivingStatus specialCaseType;
//     int specialCaseNotify;
//     int adminApprovalStatus;
//     CountryCode countryCode;
//     Country country;
//     State state;
//     String city;
//     int locationId;
//     MaritalStatus maritalStatus;
//     int numberOfChildren;
//     ChildLivingStatus childLivingStatus;
//     String bornPlace;
//     String bornTime;
//     String aboutSelf;
//     String aboutPartner;
//     dynamic completedStatus;
//     dynamic completedIn;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;

//     factory PartnerInfo.fromMap(Map<String, dynamic> json) => PartnerInfo(
//         id: json["id"],
//         userId: json["user_id"],
//         dob: DateTime.parse(json["dob"]),
//         dobStatus: json["dob_status"],
//         height: json["height"],
//         weight: json["weight"],
//         bodyType: BodyType.fromMap(json["body_type"]),
//         complexion: Complexion.fromMap(json["complexion"]),
//         specialCase: json["special_case"],
//         specialCaseType: json["special_case_type"] == null ? null : ChildLivingStatus.fromMap(json["special_case_type"]),
//         specialCaseNotify: json["special_case_notify"],
//         adminApprovalStatus: json["admin_approval_status"],
//         countryCode: countryCodeValues.map[json["country_code"]],
//         country: countryValues.map[json["country"]],
//         state: stateValues.map[json["state"]],
//         city: json["city"],
//         locationId: json["location_id"],
//         maritalStatus: MaritalStatus.fromMap(json["marital_status"]),
//         numberOfChildren: json["number_of_children"],
//         childLivingStatus: json["child_living_status"] == null ? null : ChildLivingStatus.fromMap(json["child_living_status"]),
//         bornPlace: json["born_place"],
//         bornTime: json["born_time"],
//         aboutSelf: json["about_self"],
//         aboutPartner: json["about_partner"],
//         completedStatus: json["completed_status"],
//         completedIn: json["completed_in"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
//         "dob_status": dobStatus,
//         "height": height,
//         "weight": weight,
//         "body_type": bodyType.toMap(),
//         "complexion": complexion.toMap(),
//         "special_case": specialCase,
//         "special_case_type": specialCaseType == null ? null : specialCaseType.toMap(),
//         "special_case_notify": specialCaseNotify,
//         "admin_approval_status": adminApprovalStatus,
//         "country_code": countryCodeValues.reverse[countryCode],
//         "country": countryValues.reverse[country],
//         "state": stateValues.reverse[state],
//         "city": city,
//         "location_id": locationId,
//         "marital_status": maritalStatus.toMap(),
//         "number_of_children": numberOfChildren,
//         "child_living_status": childLivingStatus == null ? null : childLivingStatus.toMap(),
//         "born_place": bornPlace,
//         "born_time": bornTime,
//         "about_self": aboutSelf,
//         "about_partner": aboutPartner,
//         "completed_status": completedStatus,
//         "completed_in": completedIn,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//     };
// }

// class BodyType {
//     BodyType({
//         this.id,
//         this.type,
//         this.value,
//         this.parentId,
//         this.others,
//         this.status,
//     });

//     int id;
//     BodyTypeType type;
//     BodyTypeValue value;
//     int parentId;
//     Others others;
//     Status status;

//     factory BodyType.fromMap(Map<String, dynamic> json) => BodyType(
//         id: json["id"],
//         type: bodyTypeTypeValues.map[json["type"]],
//         value: bodyTypeValueValues.map[json["value"]],
//         parentId: json["parent_id"],
//         others: othersValues.map[json["others"]],
//         status: statusValues.map[json["status"]],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "type": bodyTypeTypeValues.reverse[type],
//         "value": bodyTypeValueValues.reverse[value],
//         "parent_id": parentId,
//         "others": othersValues.reverse[others],
//         "status": statusValues.reverse[status],
//     };
// }

// enum Others { REGULAR, SLIM_FIT }

// final othersValues = EnumValues({
//     "regular": Others.REGULAR,
//     "slim_fit": Others.SLIM_FIT
// });

// enum BodyTypeType { BODY_TYPE }

// final bodyTypeTypeValues = EnumValues({
//     "body_type": BodyTypeType.BODY_TYPE
// });

// enum BodyTypeValue { REGULAR, SLIM_FIT }

// final bodyTypeValueValues = EnumValues({
//     "Regular": BodyTypeValue.REGULAR,
//     "Slim Fit": BodyTypeValue.SLIM_FIT
// });

// class ChildLivingStatus {
//     ChildLivingStatus({
//         this.id,
//         this.type,
//         this.value,
//         this.parentId,
//         this.others,
//         this.status,
//     });

//     int id;
//     String type;
//     String value;
//     int parentId;
//     String others;
//     Status status;

//     factory ChildLivingStatus.fromMap(Map<String, dynamic> json) => ChildLivingStatus(
//         id: json["id"],
//         type: json["type"],
//         value: json["value"],
//         parentId: json["parent_id"],
//         others: json["others"],
//         status: statusValues.map[json["status"]],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "type": type,
//         "value": value,
//         "parent_id": parentId,
//         "others": others,
//         "status": statusValues.reverse[status],
//     };
// }

// class Complexion {
//     Complexion({
//         this.id,
//         this.type,
//         this.value,
//         this.parentId,
//         this.others,
//         this.status,
//     });

//     int id;
//     ComplexionType type;
//     ComplexionValue value;
//     int parentId;
//     String others;
//     Status status;

//     factory Complexion.fromMap(Map<String, dynamic> json) => Complexion(
//         id: json["id"],
//         type: complexionTypeValues.map[json["type"]],
//         value: complexionValueValues.map[json["value"]],
//         parentId: json["parent_id"],
//         others: json["others"],
//         status: statusValues.map[json["status"]],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "type": complexionTypeValues.reverse[type],
//         "value": complexionValueValues.reverse[value],
//         "parent_id": parentId,
//         "others": others,
//         "status": statusValues.reverse[status],
//     };
// }

// enum ComplexionType { COMPLEXION }

// final complexionTypeValues = EnumValues({
//     "complexion": ComplexionType.COMPLEXION
// });

// enum ComplexionValue { FAIR, DARK }

// final complexionValueValues = EnumValues({
//     "Dark": ComplexionValue.DARK,
//     "Fair": ComplexionValue.FAIR
// });

// enum Country { INDIA }

// final countryValues = EnumValues({
//     "India": Country.INDIA
// });

// enum CountryCode { IN }

// final countryCodeValues = EnumValues({
//     "IN": CountryCode.IN
// });

// class MaritalStatus {
//     MaritalStatus({
//         this.id,
//         this.type,
//         this.value,
//         this.parentId,
//         this.others,
//         this.status,
//     });

//     int id;
//     MaritalStatusType type;
//     MaritalStatusValue value;
//     int parentId;
//     String others;
//     Status status;

//     factory MaritalStatus.fromMap(Map<String, dynamic> json) => MaritalStatus(
//         id: json["id"],
//         type: maritalStatusTypeValues.map[json["type"]],
//         value: maritalStatusValueValues.map[json["value"]],
//         parentId: json["parent_id"],
//         others: json["others"],
//         status: statusValues.map[json["status"]],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "type": maritalStatusTypeValues.reverse[type],
//         "value": maritalStatusValueValues.reverse[value],
//         "parent_id": parentId,
//         "others": others,
//         "status": statusValues.reverse[status],
//     };
// }

// enum MaritalStatusType { MARITAL_STATUS }

// final maritalStatusTypeValues = EnumValues({
//     "marital_status": MaritalStatusType.MARITAL_STATUS
// });

// enum MaritalStatusValue { SINGLE, AWAITING_DIVORCE }

// final maritalStatusValueValues = EnumValues({
//     "Awaiting Divorce": MaritalStatusValue.AWAITING_DIVORCE,
//     "Single": MaritalStatusValue.SINGLE
// });

// enum State { KERALA, KARNATAKA, DELHI_NCR }

// final stateValues = EnumValues({
//     "Delhi NCR": State.DELHI_NCR,
//     "Karnataka": State.KARNATAKA,
//     "Kerala": State.KERALA
// });

// class PartnerOfficialDocuments {
//     PartnerOfficialDocuments({
//         this.id,
//         this.userId,
//         this.govtIdType,
//         this.govtIdFront,
//         this.govtIdBack,
//         this.govtIdStatus,
//         this.govtIdApprovedBy,
//         this.govtIdRejectComments,
//         this.officeIdRejectStatus,
//         this.govIdRejectStatus,
//         this.govtIdApprovedAt,
//         this.officeId,
//         this.officeIdStatus,
//         this.officeIdApprovedBy,
//         this.officeIdRejectComments,
//         this.officeIdApprovedAt,
//         this.linkedinId,
//         this.linkedinIdStatus,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.govtIdAt,
//         this.officeIdAt,
//     });

//     int id;
//     int userId;
//     int govtIdType;
//     String govtIdFront;
//     String govtIdBack;
//     int govtIdStatus;
//     IdApprovedBy govtIdApprovedBy;
//     String govtIdRejectComments;
//     int officeIdRejectStatus;
//     int govIdRejectStatus;
//     DateTime govtIdApprovedAt;
//     String officeId;
//     int officeIdStatus;
//     IdApprovedBy officeIdApprovedBy;
//     dynamic officeIdRejectComments;
//     DateTime officeIdApprovedAt;
//     dynamic linkedinId;
//     int linkedinIdStatus;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;
//     DateTime govtIdAt;
//     DateTime officeIdAt;

//     factory PartnerOfficialDocuments.fromMap(Map<String, dynamic> json) => PartnerOfficialDocuments(
//         id: json["id"],
//         userId: json["user_id"],
//         govtIdType: json["govt_id_type"],
//         govtIdFront: json["govt_id_front"] == null ? null : json["govt_id_front"],
//         govtIdBack: json["govt_id_back"] == null ? null : json["govt_id_back"],
//         govtIdStatus: json["govt_id_status"] == null ? null : json["govt_id_status"],
//         govtIdApprovedBy: json["govt_id_approved_by"] == null ? null : IdApprovedBy.fromMap(json["govt_id_approved_by"]),
//         govtIdRejectComments: json["govt_id_reject_comments"] == null ? null : json["govt_id_reject_comments"],
//         officeIdRejectStatus: json["office_id_reject_status"],
//         govIdRejectStatus: json["gov_id_reject_status"],
//         govtIdApprovedAt: json["govt_id_approved_at"] == null ? null : DateTime.parse(json["govt_id_approved_at"]),
//         officeId: json["office_id"] == null ? null : json["office_id"],
//         officeIdStatus: json["office_id_status"] == null ? null : json["office_id_status"],
//         officeIdApprovedBy: json["office_id_approved_by"] == null ? null : IdApprovedBy.fromMap(json["office_id_approved_by"]),
//         officeIdRejectComments: json["office_id_reject_comments"],
//         officeIdApprovedAt: json["office_id_approved_at"] == null ? null : DateTime.parse(json["office_id_approved_at"]),
//         linkedinId: json["linkedin_id"],
//         linkedinIdStatus: json["linkedin_id_status"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         govtIdAt: DateTime.parse(json["govt_id_at"]),
//         officeIdAt: DateTime.parse(json["office_id_at"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "govt_id_type": govtIdType,
//         "govt_id_front": govtIdFront == null ? null : govtIdFront,
//         "govt_id_back": govtIdBack == null ? null : govtIdBack,
//         "govt_id_status": govtIdStatus == null ? null : govtIdStatus,
//         "govt_id_approved_by": govtIdApprovedBy == null ? null : govtIdApprovedBy.toMap(),
//         "govt_id_reject_comments": govtIdRejectComments == null ? null : govtIdRejectComments,
//         "office_id_reject_status": officeIdRejectStatus,
//         "gov_id_reject_status": govIdRejectStatus,
//         "govt_id_approved_at": govtIdApprovedAt == null ? null : govtIdApprovedAt.toIso8601String(),
//         "office_id": officeId == null ? null : officeId,
//         "office_id_status": officeIdStatus == null ? null : officeIdStatus,
//         "office_id_approved_by": officeIdApprovedBy == null ? null : officeIdApprovedBy.toMap(),
//         "office_id_reject_comments": officeIdRejectComments,
//         "office_id_approved_at": officeIdApprovedAt == null ? null : officeIdApprovedAt.toIso8601String(),
//         "linkedin_id": linkedinId,
//         "linkedin_id_status": linkedinIdStatus,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "govt_id_at": govtIdAt.toIso8601String(),
//         "office_id_at": officeIdAt.toIso8601String(),
//     };
// }

// class IdApprovedBy {
//     IdApprovedBy({
//         this.id,
//         this.name,
//         this.lastName,
//         this.notification,
//         this.membershipCode,
//         this.gender,
//         this.profilePic,
//         this.emailVerification,
//         this.mobileVerification,
//         this.isActive,
//         this.edited,
//         this.online,
//         this.lastActive,
//         this.hideAt,
//         this.govtIdAt,
//         this.officeIdAt,
//         this.photoAt,
//         this.loginCount,
//         this.recommend,
//         this.membership,
//         this.score,
//         this.recomendCauseCount,
//         this.passwordStatus,
//     });

//     int id;
//     String name;
//     String lastName;
//     int notification;
//     dynamic membershipCode;
//     String gender;
//     dynamic profilePic;
//     int emailVerification;
//     int mobileVerification;
//     int isActive;
//     int edited;
//     int online;
//     dynamic lastActive;
//     dynamic hideAt;
//     dynamic govtIdAt;
//     dynamic officeIdAt;
//     dynamic photoAt;
//     dynamic loginCount;
//     bool recommend;
//     dynamic membership;
//     int score;
//     int recomendCauseCount;
//     bool passwordStatus;

//     factory IdApprovedBy.fromMap(Map<String, dynamic> json) => IdApprovedBy(
//         id: json["id"],
//         name: json["name"],
//         lastName: json["last_name"],
//         notification: json["notification"],
//         membershipCode: json["membership_code"],
//         gender: json["gender"],
//         profilePic: json["profile_pic"],
//         emailVerification: json["email_verification"],
//         mobileVerification: json["mobile_verification"],
//         isActive: json["is_active"],
//         edited: json["edited"],
//         online: json["online"],
//         lastActive: json["last_active"],
//         hideAt: json["hide_at"],
//         govtIdAt: json["govt_id_at"],
//         officeIdAt: json["office_id_at"],
//         photoAt: json["photo_at"],
//         loginCount: json["login_count"],
//         recommend: json["recommend"],
//         membership: json["membership"],
//         score: json["score"],
//         recomendCauseCount: json["recomend_cause_count"],
//         passwordStatus: json["password_status"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "last_name": lastName,
//         "notification": notification,
//         "membership_code": membershipCode,
//         "gender": gender,
//         "profile_pic": profilePic,
//         "email_verification": emailVerification,
//         "mobile_verification": mobileVerification,
//         "is_active": isActive,
//         "edited": edited,
//         "online": online,
//         "last_active": lastActive,
//         "hide_at": hideAt,
//         "govt_id_at": govtIdAt,
//         "office_id_at": officeIdAt,
//         "photo_at": photoAt,
//         "login_count": loginCount,
//         "recommend": recommend,
//         "membership": membership,
//         "score": score,
//         "recomend_cause_count": recomendCauseCount,
//         "password_status": passwordStatus,
//     };
// }

// class PartnerPhoto {
//     PartnerPhoto({
//         this.id,
//         this.userId,
//         this.fromType,
//         this.imageType,
//         this.status,
//         this.rejectStatus,
//         this.approvedBy,
//         this.photoApprovedAt,
//         this.comments,
//         this.trash,
//         this.imageTaken,
//         this.dpStatus,
//         this.sortOrder,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.photoNames,
//         this.userDetail,
//     });

//     int id;
//     int userId;
//     FromType fromType;
//     ImageType imageType;
//     int status;
//     int rejectStatus;
//     String approvedBy;
//     DateTime photoApprovedAt;
//     dynamic comments;
//     int trash;
//     ImageTaken imageTaken;
//     int dpStatus;
//     int sortOrder;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;
//     String photoNames;
//     PurpleUserDetail userDetail;

//     factory PartnerPhoto.fromMap(Map<String, dynamic> json) => PartnerPhoto(
//         id: json["id"],
//         userId: json["user_id"],
//         fromType: fromTypeValues.map[json["from_type"]],
//         imageType: ImageType.fromMap(json["image_type"]),
//         status: json["status"],
//         rejectStatus: json["reject_status"],
//         approvedBy: json["approved_by"] == null ? null : json["approved_by"],
//         photoApprovedAt: json["photo_approved_at"] == null ? null : DateTime.parse(json["photo_approved_at"]),
//         comments: json["comments"],
//         trash: json["trash"],
//         imageTaken: ImageTaken.fromMap(json["image_taken"]),
//         dpStatus: json["dp_status"],
//         sortOrder: json["sort_order"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         photoNames: json["photo_names"],
//         userDetail: PurpleUserDetail.fromMap(json["user_detail"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "from_type": fromTypeValues.reverse[fromType],
//         "image_type": imageType.toMap(),
//         "status": status,
//         "reject_status": rejectStatus,
//         "approved_by": approvedBy == null ? null : approvedBy,
//         "photo_approved_at": photoApprovedAt == null ? null : photoApprovedAt.toIso8601String(),
//         "comments": comments,
//         "trash": trash,
//         "image_taken": imageTaken.toMap(),
//         "dp_status": dpStatus,
//         "sort_order": sortOrder,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "photo_names": photoNames,
//         "user_detail": userDetail.toMap(),
//     };
// }

// class User {
//     User({
//         this.id,
//         this.name,
//         this.lastName,
//         this.notification,
//         this.membershipCode,
//         this.gender,
//         this.profilePic,
//         this.emailVerification,
//         this.mobileVerification,
//         this.isActive,
//         this.edited,
//         this.online,
//         this.lastActive,
//         this.hideAt,
//         this.govtIdAt,
//         this.officeIdAt,
//         this.photoAt,
//         this.loginCount,
//         this.recommend,
//         this.membership,
//         this.score,
//         this.recomendCauseCount,
//         this.passwordStatus,
//         this.info,
//         this.photos,
//         this.dp,
//         this.officialDocuments,
//     });

//     int id;
//     Name name;
//     LastName lastName;
//     int notification;
//     MembershipCode membershipCode;
//     UserGender gender;
//     dynamic profilePic;
//     int emailVerification;
//     int mobileVerification;
//     int isActive;
//     int edited;
//     int online;
//     DateTime lastActive;
//     dynamic hideAt;
//     dynamic govtIdAt;
//     dynamic officeIdAt;
//     dynamic photoAt;
//     int loginCount;
//     bool recommend;
//     Membership membership;
//     int score;
//     int recomendCauseCount;
//     bool passwordStatus;
//     UserInfo info;
//     List<UserPhoto> photos;
//     UserDp dp;
//     UserOfficialDocuments officialDocuments;

//     factory User.fromMap(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: nameValues.map[json["name"]],
//         lastName: lastNameValues.map[json["last_name"]],
//         notification: json["notification"],
//         membershipCode: membershipCodeValues.map[json["membership_code"]],
//         gender: userGenderValues.map[json["gender"]],
//         profilePic: json["profile_pic"],
//         emailVerification: json["email_verification"],
//         mobileVerification: json["mobile_verification"],
//         isActive: json["is_active"],
//         edited: json["edited"],
//         online: json["online"],
//         lastActive: DateTime.parse(json["last_active"]),
//         hideAt: json["hide_at"],
//         govtIdAt: json["govt_id_at"],
//         officeIdAt: json["office_id_at"],
//         photoAt: json["photo_at"],
//         loginCount: json["login_count"],
//         recommend: json["recommend"],
//         membership: Membership.fromMap(json["membership"]),
//         score: json["score"],
//         recomendCauseCount: json["recomend_cause_count"],
//         passwordStatus: json["password_status"],
//         info: UserInfo.fromMap(json["info"]),
//         photos: List<UserPhoto>.from(json["photos"].map((x) => UserPhoto.fromMap(x))),
//         dp: UserDp.fromMap(json["dp"]),
//         officialDocuments: UserOfficialDocuments.fromMap(json["official_documents"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": nameValues.reverse[name],
//         "last_name": lastNameValues.reverse[lastName],
//         "notification": notification,
//         "membership_code": membershipCodeValues.reverse[membershipCode],
//         "gender": userGenderValues.reverse[gender],
//         "profile_pic": profilePic,
//         "email_verification": emailVerification,
//         "mobile_verification": mobileVerification,
//         "is_active": isActive,
//         "edited": edited,
//         "online": online,
//         "last_active": lastActive.toIso8601String(),
//         "hide_at": hideAt,
//         "govt_id_at": govtIdAt,
//         "office_id_at": officeIdAt,
//         "photo_at": photoAt,
//         "login_count": loginCount,
//         "recommend": recommend,
//         "membership": membership.toMap(),
//         "score": score,
//         "recomend_cause_count": recomendCauseCount,
//         "password_status": passwordStatus,
//         "info": info.toMap(),
//         "photos": List<dynamic>.from(photos.map((x) => x.toMap())),
//         "dp": dp.toMap(),
//         "official_documents": officialDocuments.toMap(),
//     };
// }

// class UserDp {
//     UserDp({
//         this.id,
//         this.userId,
//         this.fromType,
//         this.imageType,
//         this.status,
//         this.rejectStatus,
//         this.approvedBy,
//         this.photoApprovedAt,
//         this.comments,
//         this.trash,
//         this.imageTaken,
//         this.dpStatus,
//         this.sortOrder,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.photoNames,
//         this.userDetail,
//     });

//     int id;
//     int userId;
//     FromType fromType;
//     ImageType imageType;
//     int status;
//     int rejectStatus;
//     dynamic approvedBy;
//     dynamic photoApprovedAt;
//     dynamic comments;
//     int trash;
//     ImageTaken imageTaken;
//     int dpStatus;
//     int sortOrder;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;
//     PhotoPhotoNames photoNames;
//     FluffyUserDetail userDetail;

//     factory UserDp.fromMap(Map<String, dynamic> json) => UserDp(
//         id: json["id"],
//         userId: json["user_id"],
//         fromType: fromTypeValues.map[json["from_type"]],
//         imageType: ImageType.fromMap(json["image_type"]),
//         status: json["status"],
//         rejectStatus: json["reject_status"],
//         approvedBy: json["approved_by"],
//         photoApprovedAt: json["photo_approved_at"],
//         comments: json["comments"],
//         trash: json["trash"],
//         imageTaken: ImageTaken.fromMap(json["image_taken"]),
//         dpStatus: json["dp_status"],
//         sortOrder: json["sort_order"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         photoNames: photoPhotoNamesValues.map[json["photo_names"]],
//         userDetail: FluffyUserDetail.fromMap(json["user_detail"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "from_type": fromTypeValues.reverse[fromType],
//         "image_type": imageType.toMap(),
//         "status": status,
//         "reject_status": rejectStatus,
//         "approved_by": approvedBy,
//         "photo_approved_at": photoApprovedAt,
//         "comments": comments,
//         "trash": trash,
//         "image_taken": imageTaken.toMap(),
//         "dp_status": dpStatus,
//         "sort_order": sortOrder,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "photo_names": photoPhotoNamesValues.reverse[photoNames],
//         "user_detail": userDetail.toMap(),
//     };
// }

// enum PhotoPhotoNames { THE_1649849395947_JPEG, THE_1649849412769_JPEG, THE_1649849427716_JPEG }

// final photoPhotoNamesValues = EnumValues({
//     "1649849395947.jpeg": PhotoPhotoNames.THE_1649849395947_JPEG,
//     "1649849412769.jpeg": PhotoPhotoNames.THE_1649849412769_JPEG,
//     "1649849427716.jpeg": PhotoPhotoNames.THE_1649849427716_JPEG
// });

// class FluffyUserDetail {
//     FluffyUserDetail({
//         this.id,
//         this.name,
//         this.lastName,
//         this.notification,
//         this.membershipCode,
//         this.gender,
//         this.profilePic,
//         this.emailVerification,
//         this.mobileVerification,
//         this.isActive,
//         this.edited,
//         this.online,
//         this.lastActive,
//         this.hideAt,
//         this.govtIdAt,
//         this.officeIdAt,
//         this.photoAt,
//         this.loginCount,
//         this.recommend,
//         this.membership,
//         this.score,
//         this.recomendCauseCount,
//         this.passwordStatus,
//     });

//     int id;
//     Name name;
//     LastName lastName;
//     int notification;
//     MembershipCode membershipCode;
//     UserGender gender;
//     dynamic profilePic;
//     int emailVerification;
//     int mobileVerification;
//     int isActive;
//     int edited;
//     int online;
//     DateTime lastActive;
//     dynamic hideAt;
//     dynamic govtIdAt;
//     dynamic officeIdAt;
//     dynamic photoAt;
//     int loginCount;
//     bool recommend;
//     Membership membership;
//     int score;
//     int recomendCauseCount;
//     bool passwordStatus;

//     factory FluffyUserDetail.fromMap(Map<String, dynamic> json) => FluffyUserDetail(
//         id: json["id"],
//         name: nameValues.map[json["name"]],
//         lastName: lastNameValues.map[json["last_name"]],
//         notification: json["notification"],
//         membershipCode: membershipCodeValues.map[json["membership_code"]],
//         gender: userGenderValues.map[json["gender"]],
//         profilePic: json["profile_pic"],
//         emailVerification: json["email_verification"],
//         mobileVerification: json["mobile_verification"],
//         isActive: json["is_active"],
//         edited: json["edited"],
//         online: json["online"],
//         lastActive: DateTime.parse(json["last_active"]),
//         hideAt: json["hide_at"],
//         govtIdAt: json["govt_id_at"],
//         officeIdAt: json["office_id_at"],
//         photoAt: json["photo_at"],
//         loginCount: json["login_count"],
//         recommend: json["recommend"],
//         membership: Membership.fromMap(json["membership"]),
//         score: json["score"],
//         recomendCauseCount: json["recomend_cause_count"],
//         passwordStatus: json["password_status"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": nameValues.reverse[name],
//         "last_name": lastNameValues.reverse[lastName],
//         "notification": notification,
//         "membership_code": membershipCodeValues.reverse[membershipCode],
//         "gender": userGenderValues.reverse[gender],
//         "profile_pic": profilePic,
//         "email_verification": emailVerification,
//         "mobile_verification": mobileVerification,
//         "is_active": isActive,
//         "edited": edited,
//         "online": online,
//         "last_active": lastActive.toIso8601String(),
//         "hide_at": hideAt,
//         "govt_id_at": govtIdAt,
//         "office_id_at": officeIdAt,
//         "photo_at": photoAt,
//         "login_count": loginCount,
//         "recommend": recommend,
//         "membership": membership.toMap(),
//         "score": score,
//         "recomend_cause_count": recomendCauseCount,
//         "password_status": passwordStatus,
//     };
// }

// enum UserGender { MALE }

// final userGenderValues = EnumValues({
//     "male": UserGender.MALE
// });

// enum LastName { KRISHNA }

// final lastNameValues = EnumValues({
//     "Krishna": LastName.KRISHNA
// });

// enum MembershipCode { CM22_WSNG }

// final membershipCodeValues = EnumValues({
//     "CM22WSNG": MembershipCode.CM22_WSNG
// });

// enum Name { ANAY }

// final nameValues = EnumValues({
//     "Anay": Name.ANAY
// });

// class UserInfo {
//     UserInfo({
//         this.id,
//         this.userId,
//         this.dob,
//         this.dobStatus,
//         this.height,
//         this.weight,
//         this.bodyType,
//         this.complexion,
//         this.specialCase,
//         this.specialCaseType,
//         this.specialCaseNotify,
//         this.adminApprovalStatus,
//         this.countryCode,
//         this.country,
//         this.state,
//         this.city,
//         this.locationId,
//         this.maritalStatus,
//         this.numberOfChildren,
//         this.childLivingStatus,
//         this.bornPlace,
//         this.bornTime,
//         this.aboutSelf,
//         this.aboutPartner,
//         this.completedStatus,
//         this.completedIn,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//     });

//     int id;
//     int userId;
//     DateTime dob;
//     int dobStatus;
//     int height;
//     int weight;
//     BodyType bodyType;
//     Complexion complexion;
//     int specialCase;
//     dynamic specialCaseType;
//     int specialCaseNotify;
//     int adminApprovalStatus;
//     CountryCode countryCode;
//     Country country;
//     State state;
//     City city;
//     int locationId;
//     MaritalStatus maritalStatus;
//     int numberOfChildren;
//     dynamic childLivingStatus;
//     BornPlace bornPlace;
//     String bornTime;
//     About aboutSelf;
//     About aboutPartner;
//     dynamic completedStatus;
//     dynamic completedIn;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;

//     factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
//         id: json["id"],
//         userId: json["user_id"],
//         dob: DateTime.parse(json["dob"]),
//         dobStatus: json["dob_status"],
//         height: json["height"],
//         weight: json["weight"],
//         bodyType: BodyType.fromMap(json["body_type"]),
//         complexion: Complexion.fromMap(json["complexion"]),
//         specialCase: json["special_case"],
//         specialCaseType: json["special_case_type"],
//         specialCaseNotify: json["special_case_notify"],
//         adminApprovalStatus: json["admin_approval_status"],
//         countryCode: countryCodeValues.map[json["country_code"]],
//         country: countryValues.map[json["country"]],
//         state: stateValues.map[json["state"]],
//         city: cityValues.map[json["city"]],
//         locationId: json["location_id"],
//         maritalStatus: MaritalStatus.fromMap(json["marital_status"]),
//         numberOfChildren: json["number_of_children"],
//         childLivingStatus: json["child_living_status"],
//         bornPlace: bornPlaceValues.map[json["born_place"]],
//         bornTime: json["born_time"],
//         aboutSelf: aboutValues.map[json["about_self"]],
//         aboutPartner: aboutValues.map[json["about_partner"]],
//         completedStatus: json["completed_status"],
//         completedIn: json["completed_in"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
//         "dob_status": dobStatus,
//         "height": height,
//         "weight": weight,
//         "body_type": bodyType.toMap(),
//         "complexion": complexion.toMap(),
//         "special_case": specialCase,
//         "special_case_type": specialCaseType,
//         "special_case_notify": specialCaseNotify,
//         "admin_approval_status": adminApprovalStatus,
//         "country_code": countryCodeValues.reverse[countryCode],
//         "country": countryValues.reverse[country],
//         "state": stateValues.reverse[state],
//         "city": cityValues.reverse[city],
//         "location_id": locationId,
//         "marital_status": maritalStatus.toMap(),
//         "number_of_children": numberOfChildren,
//         "child_living_status": childLivingStatus,
//         "born_place": bornPlaceValues.reverse[bornPlace],
//         "born_time": bornTime,
//         "about_self": aboutValues.reverse[aboutSelf],
//         "about_partner": aboutValues.reverse[aboutPartner],
//         "completed_status": completedStatus,
//         "completed_in": completedIn,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//     };
// }

// enum About { TEST_TEST_TEST }

// final aboutValues = EnumValues({
//     "Test test test": About.TEST_TEST_TEST
// });

// enum BornPlace { THRISSUR_KERALA_INDIA }

// final bornPlaceValues = EnumValues({
//     "Thrissur, Kerala, India": BornPlace.THRISSUR_KERALA_INDIA
// });

// enum City { KOCHI }

// final cityValues = EnumValues({
//     "Kochi": City.KOCHI
// });

// class UserOfficialDocuments {
//     UserOfficialDocuments({
//         this.id,
//         this.userId,
//         this.govtIdType,
//         this.govtIdFront,
//         this.govtIdBack,
//         this.govtIdStatus,
//         this.govtIdApprovedBy,
//         this.govtIdRejectComments,
//         this.officeIdRejectStatus,
//         this.govIdRejectStatus,
//         this.govtIdApprovedAt,
//         this.officeId,
//         this.officeIdStatus,
//         this.officeIdApprovedBy,
//         this.officeIdRejectComments,
//         this.officeIdApprovedAt,
//         this.linkedinId,
//         this.linkedinIdStatus,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.govtIdAt,
//         this.officeIdAt,
//     });

//     int id;
//     int userId;
//     int govtIdType;
//     dynamic govtIdFront;
//     dynamic govtIdBack;
//     dynamic govtIdStatus;
//     dynamic govtIdApprovedBy;
//     dynamic govtIdRejectComments;
//     int officeIdRejectStatus;
//     int govIdRejectStatus;
//     dynamic govtIdApprovedAt;
//     dynamic officeId;
//     dynamic officeIdStatus;
//     dynamic officeIdApprovedBy;
//     dynamic officeIdRejectComments;
//     dynamic officeIdApprovedAt;
//     dynamic linkedinId;
//     int linkedinIdStatus;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;
//     DateTime govtIdAt;
//     DateTime officeIdAt;

//     factory UserOfficialDocuments.fromMap(Map<String, dynamic> json) => UserOfficialDocuments(
//         id: json["id"],
//         userId: json["user_id"],
//         govtIdType: json["govt_id_type"],
//         govtIdFront: json["govt_id_front"],
//         govtIdBack: json["govt_id_back"],
//         govtIdStatus: json["govt_id_status"],
//         govtIdApprovedBy: json["govt_id_approved_by"],
//         govtIdRejectComments: json["govt_id_reject_comments"],
//         officeIdRejectStatus: json["office_id_reject_status"],
//         govIdRejectStatus: json["gov_id_reject_status"],
//         govtIdApprovedAt: json["govt_id_approved_at"],
//         officeId: json["office_id"],
//         officeIdStatus: json["office_id_status"],
//         officeIdApprovedBy: json["office_id_approved_by"],
//         officeIdRejectComments: json["office_id_reject_comments"],
//         officeIdApprovedAt: json["office_id_approved_at"],
//         linkedinId: json["linkedin_id"],
//         linkedinIdStatus: json["linkedin_id_status"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         govtIdAt: DateTime.parse(json["govt_id_at"]),
//         officeIdAt: DateTime.parse(json["office_id_at"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "govt_id_type": govtIdType,
//         "govt_id_front": govtIdFront,
//         "govt_id_back": govtIdBack,
//         "govt_id_status": govtIdStatus,
//         "govt_id_approved_by": govtIdApprovedBy,
//         "govt_id_reject_comments": govtIdRejectComments,
//         "office_id_reject_status": officeIdRejectStatus,
//         "gov_id_reject_status": govIdRejectStatus,
//         "govt_id_approved_at": govtIdApprovedAt,
//         "office_id": officeId,
//         "office_id_status": officeIdStatus,
//         "office_id_approved_by": officeIdApprovedBy,
//         "office_id_reject_comments": officeIdRejectComments,
//         "office_id_approved_at": officeIdApprovedAt,
//         "linkedin_id": linkedinId,
//         "linkedin_id_status": linkedinIdStatus,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "govt_id_at": govtIdAt.toIso8601String(),
//         "office_id_at": officeIdAt.toIso8601String(),
//     };
// }

// class UserPhoto {
//     UserPhoto({
//         this.id,
//         this.userId,
//         this.fromType,
//         this.imageType,
//         this.status,
//         this.rejectStatus,
//         this.approvedBy,
//         this.photoApprovedAt,
//         this.comments,
//         this.trash,
//         this.imageTaken,
//         this.dpStatus,
//         this.sortOrder,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.photoNames,
//         this.userDetail,
//     });

//     int id;
//     int userId;
//     FromType fromType;
//     ImageType imageType;
//     int status;
//     int rejectStatus;
//     dynamic approvedBy;
//     dynamic photoApprovedAt;
//     dynamic comments;
//     int trash;
//     ImageTaken imageTaken;
//     int dpStatus;
//     int sortOrder;
//     dynamic deletedAt;
//     DateTime createdAt;
//     DateTime updatedAt;
//     PhotoPhotoNames photoNames;
//     FluffyUserDetail userDetail;

//     factory UserPhoto.fromMap(Map<String, dynamic> json) => UserPhoto(
//         id: json["id"],
//         userId: json["user_id"],
//         fromType: fromTypeValues.map[json["from_type"]],
//         imageType: ImageType.fromMap(json["image_type"]),
//         status: json["status"],
//         rejectStatus: json["reject_status"],
//         approvedBy: json["approved_by"],
//         photoApprovedAt: json["photo_approved_at"],
//         comments: json["comments"],
//         trash: json["trash"],
//         imageTaken: ImageTaken.fromMap(json["image_taken"]),
//         dpStatus: json["dp_status"],
//         sortOrder: json["sort_order"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         photoNames: photoPhotoNamesValues.map[json["photo_names"]],
//         userDetail: FluffyUserDetail.fromMap(json["user_detail"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "user_id": userId,
//         "from_type": fromTypeValues.reverse[fromType],
//         "image_type": imageType.toMap(),
//         "status": status,
//         "reject_status": rejectStatus,
//         "approved_by": approvedBy,
//         "photo_approved_at": photoApprovedAt,
//         "comments": comments,
//         "trash": trash,
//         "image_taken": imageTaken.toMap(),
//         "dp_status": dpStatus,
//         "sort_order": sortOrder,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "photo_names": photoPhotoNamesValues.reverse[photoNames],
//         "user_detail": userDetail.toMap(),
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
