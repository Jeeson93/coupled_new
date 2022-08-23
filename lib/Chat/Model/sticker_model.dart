// To parse this JSON data, do
//
//     final stickerModel = stickerModelFromMap(jsonString);

import 'dart:convert';

StickerModel stickerModelFromMap(String str) =>
    StickerModel.fromMap(json.decode(str));

String stickerModelToMap(StickerModel data) => json.encode(data.toMap());

class StickerModel {
  StickerModel({
    this.status = '',
    this.response = const <StickerResponse>[],
    this.code = 0,
  });

  String status;
  List<StickerResponse> response;
  int code;

  factory StickerModel.fromMap(Map<String, dynamic> json) => StickerModel(
        status: json["status"],
        response: List<StickerResponse>.from(
            json["response"].map((x) => StickerResponse.fromMap(x))),
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "response": List<dynamic>.from(response.map((x) => x.toMap())),
        "code": code,
      };
}

class StickerResponse {
  StickerResponse({
    this.id = 0,
    this.image = '',
    this.group = '',
    this.status = '',
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String image;
  String group;
  String status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory StickerResponse.fromMap(Map<String, dynamic> json) => StickerResponse(
        id: json["id"],
        image: json["image"],
        group: json["group"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "group": group,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
