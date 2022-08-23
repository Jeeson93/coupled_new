// To parse this JSON data, do
//
//     final cmsModel = cmsModelFromMap(jsonString);

import 'dart:convert';

CmsModel cmsModelFromMap(String str) => CmsModel.fromMap(json.decode(str));

String cmsModelToMap(CmsModel data) => json.encode(data.toMap());

class CmsModel {
  CmsModel({
    this.status,
    required this.response,
    this.code,
  });

  dynamic status;
  List<CmsModelResponse> response;
  dynamic code;

  factory CmsModel.fromMap(Map<String, dynamic> json) => CmsModel(
        status: json["status"] == null ? null : json["status"],
        response: List<CmsModelResponse>.from(
            json["response"].map((x) => CmsModelResponse.fromMap(x))),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toMap())),
        "code": code == null ? null : code,
      };
}

class CmsModelResponse {
  CmsModelResponse({
    this.id,
    this.cmsPageType,
    this.cmsPageItem,
    this.cmsContent,
    this.cmsStatus,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic cmsPageType;
  dynamic cmsPageItem;
  dynamic cmsContent;
  dynamic cmsStatus;
  dynamic createdAt;
  dynamic updatedAt;

  factory CmsModelResponse.fromMap(Map<String, dynamic> json) =>
      CmsModelResponse(
        id: json["id"] == null ? null : json["id"],
        cmsPageType:
            json["cms_page_type"] == null ? null : json["cms_page_type"],
        cmsPageItem:
            json["cms_page_item"] == null ? null : json["cms_page_item"],
        cmsContent: json["cms_content"] == null ? null : json["cms_content"],
        cmsStatus: json["cms_status"] == null ? null : json["cms_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "cms_page_type": cmsPageType == null ? null : cmsPageType,
        "cms_page_item": cmsPageItem == null ? null : cmsPageItem,
        "cms_content": cmsContent == null ? null : cmsContent,
        "cms_status": cmsStatus == null ? null : cmsStatus,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
