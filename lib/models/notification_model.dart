// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel1 notificationModelFromJson(String str) =>
    NotificationModel1.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel1 data) =>
    json.encode(data.toJson());

class NotificationModel1 {
  dynamic status;
  NotificationModelResponse? response;
  dynamic code;

  NotificationModel1({
    this.status,
    this.response,
    this.code,
  });

  factory NotificationModel1.fromJson(Map<String, dynamic> json) =>
      NotificationModel1(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? null
            : NotificationModelResponse.fromJson(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response!.toJson(),
        "code": code == null ? null : code,
      };

  @override
  String toString() {
    return 'NotificationModel1{status: $status, response: $response, code: $code}';
  }
}

class NotificationModelResponse {
  dynamic momCount;
  dynamic couplingCount;
  dynamic currentPage;
  List<NotificationModelDatum>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  NotificationModelResponse({
    this.momCount,
    this.couplingCount,
    this.currentPage,
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

  factory NotificationModelResponse.fromJson(Map<String, dynamic> json) =>
      NotificationModelResponse(
        momCount: json["match_meter"] == null ? null : json["match_meter"],
        couplingCount: json["coupled"] == null ? null : json["coupled"],
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? []
            : List<NotificationModelDatum>.from(
                json["data"].map((x) => NotificationModelDatum.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == '' ? null : json["per_page"],
        prevPageUrl:
            json["prev_page_url"] == null ? null : json["prev_page_url"],
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
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl == null ? null : prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };

  @override
  String toString() {
    return 'NotificationModelResponse{momCount: $momCount, couplingCount: $couplingCount, currentPage: $currentPage, data: $data, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total}';
  }
}

class NotificationModelDatum {
  dynamic id;
  dynamic userId;
  DoneBy doneBy;
  dynamic type;
  dynamic mode;
  dynamic typeId;
  dynamic title;
  dynamic content;
  dynamic image;
  dynamic read;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  DoneBy user;
  dynamic types;

  NotificationModelDatum({
    this.id,
    this.userId,
    required this.doneBy,
    this.type = '',
    this.mode,
    this.typeId,
    this.title,
    this.content,
    this.image,
    this.read,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    required this.user,
    this.types,
  });

  factory NotificationModelDatum.fromJson(Map<String, dynamic> json) =>
      NotificationModelDatum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        doneBy: json["done_by"] == null
            ? DoneBy.fromJson({})
            : DoneBy.fromJson(json["done_by"]),
        type: json["type"] == null ? null : json["type"],
        mode: json["mode"] == null ? null : json["mode"],
        typeId: json["type_id"] == null ? null : json["type_id"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        image: json["image"],
        read: json["read"] == null ? null : json["read"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null
            ? DoneBy.fromJson({})
            : DoneBy.fromJson(json["user"]),
        types: json["types"] == null ? null : Types.fromJson(json["types"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? '' : id,
        "user_id": userId == null ? '' : userId,
        "done_by": doneBy == null ? '' : doneBy.toJson(),
        "type": type == null ? '' : type,
        "mode": mode == null ? '' : mode,
        "type_id": typeId == null ? '' : typeId,
        "title": title == null ? '' : title,
        "content": content == null ? '' : content,
        "image": image,
        "read": read == null ? '' : read,
        "status": status == null ? '' : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? '' : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? '' : updatedAt.toIso8601String(),
        "user": user == null ? '' : user.toJson(),
        "types": types == null ? '' : types.toJson(),
      };

  @override
  String toString() {
    return 'NotificationModelDatum{id: $id, userId: $userId, doneBy: $doneBy, type: $type, mode: $mode, typeId: $typeId, title: $title, content: $content, image: $image, read: $read, status: $status, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, types: $types}';
  }
}

class DoneBy {
  dynamic id;
  dynamic name;
  dynamic lastName;
  dynamic membershipCode;
  dynamic gender;
  dynamic profilePic;
  dynamic emailVerification;
  dynamic mobileVerification;
  dynamic isActive;
  dynamic lastActive;
  dynamic hideAt;

  DoneBy({
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
  });

  factory DoneBy.fromJson(Map<String, dynamic> json) => DoneBy(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        membershipCode:
            json["membership_code"] == null ? null : json["membership_code"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "last_name": lastName == null ? null : lastName,
        "membership_code": membershipCode == null ? null : membershipCode,
        "gender": gender == null ? null : gender,
        "profile_pic": profilePic == null ? null : profilePic,
        "email_verification":
            emailVerification == null ? null : emailVerification,
        "mobile_verification":
            mobileVerification == null ? null : mobileVerification,
        "is_active": isActive == null ? null : isActive,
        "last_active": lastActive == null ? null : lastActive.toIso8601String(),
        "hide_at": hideAt,
      };

  @override
  String toString() {
    return 'DoneBy{id: $id, name: $name, lastName: $lastName, membershipCode: $membershipCode, gender: $gender, profilePic: $profilePic, emailVerification: $emailVerification, mobileVerification: $mobileVerification, isActive: $isActive, lastActive: $lastActive, hideAt: $hideAt}';
  }
}

class Types {
  dynamic id;
  dynamic type;
  dynamic value;
  dynamic parentId;
  dynamic others;
  dynamic status;

  Types({
    this.id,
    this.type,
    this.value,
    this.parentId,
    this.others,
    this.status,
  });

  factory Types.fromJson(Map<String, dynamic> json) => Types(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        value: json["value"] == null ? null : json["value"],
        parentId: json["parent_id"],
        others: json["others"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "value": value == null ? null : value,
        "parent_id": parentId,
        "others": others,
        "status": status == null ? null : status,
      };

  @override
  String toString() {
    return 'Types{id: $id, type: $type, value: $value, parentId: $parentId, others: $others, status: $status}';
  }
}
