import 'dart:convert';

import 'package:coupled/models/profile.dart';

CommonResponseModel commonResponseModelFromMap(String str) =>
    CommonResponseModel.fromJson(json.decode(str));

String commonResponseModelToMap(CommonResponseModel data) =>
    json.encode(data.toMap());

class CommonResponseModel {
  CommonResponseModel({
    this.status,
    this.response,
    this.code,
  });

  dynamic status;
  CommonResponse? response;
  dynamic code;

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) =>
      CommonResponseModel(
        status: json["status"] == null ? null : json["status"],
        response: CommonResponse.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response!.toMap(),
        "code": code == null ? null : code,
      };
}

class CommonResponse {
  CommonResponse({
    this.data,
    this.msg,
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.createdAt,
    this.membershipCode,
    this.gender,
    this.phone,
    this.profilePic,
    this.emailVerification,
    this.mobileVerification,
    this.isActive,
    this.edited,
    this.online,
    this.lastActive,
    this.hideAt,
  });

  Data? data;
  String? msg;
  int? id;
  String? name;
  String? lastName;
  String? email;
  DateTime? createdAt;
  String? membershipCode;
  String? gender;
  String? phone;
  dynamic profilePic;
  int? emailVerification;
  int? mobileVerification;
  int? isActive;
  int? edited;
  int? online;
  dynamic lastActive;
  dynamic hideAt;

  factory CommonResponse.fromMap(Map<String, dynamic> json) => CommonResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msg: json["msg"] == null ? null : json["msg"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        membershipCode:
            json["membership_code"] == null ? null : json["membership_code"],
        gender: json["gender"] == null ? null : json["gender"],
        phone: json["phone"] == null ? null : json["phone"],
        profilePic: json["profile_pic"],
        emailVerification: json["email_verification"] == null
            ? null
            : json["email_verification"],
        mobileVerification: json["mobile_verification"] == null
            ? null
            : json["mobile_verification"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        edited: json["edited"] == null ? null : json["edited"],
        online: json["online"] == null ? null : json["online"],
        lastActive: json["last_active"],
        hideAt: json["hide_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "membership_code": membershipCode == null ? null : membershipCode,
        "gender": gender == null ? null : gender,
        "phone": phone == null ? null : phone,
        "profile_pic": profilePic,
        "email_verification":
            emailVerification == null ? null : emailVerification,
        "mobile_verification":
            mobileVerification == null ? null : mobileVerification,
        "is_active": isActive == null ? null : isActive,
        "edited": edited == null ? null : edited,
        "online": online == null ? null : online,
        "last_active": lastActive,
        "hide_at": hideAt,
      };
}

class Data {
  Data({
    this.recomendCause,
    this.recomendCauseCount = 0,
    this.mom,
    this.shortlistByMe,
  });

  List<RecomendCause>? recomendCause;
  int? recomendCauseCount;
  Mom? mom;
  Mom? shortlistByMe;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        recomendCause: json["recomend_cause"] == null
            ? []
            : List<RecomendCause>.from(
                json["recomend_cause"].map((x) => RecomendCause.fromMap(x))),
        recomendCauseCount:
            json["recomendCauseCount"] == null ? 0 : json["recomendCauseCount"],
        mom: json["mom"] == null ? null : Mom.fromMap(json["mom"]),
        shortlistByMe: json["shortlist_by_me"] == null
            ? null
            : Mom.fromMap(json["shortlist_by_me"]),
      );

  Map<String, dynamic> toJson() => {
        "recomend_cause": recomendCause == null
            ? null
            : List<dynamic>.from(recomendCause!.map((x) => x.toMap())),
        "recomendCauseCount": recomendCauseCount,
        "mom": mom?.toMap(),
      };
}
