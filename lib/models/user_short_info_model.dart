/*
// To parse this JSON data, do
//
//     final userShortInfoModel = userShortInfoModelFromJson(jsonString);

import 'dart:convert';

import 'package:coupled/Src/models/PlansAndPaymentModel.dart';

import 'Profile.dart';

UserShortInfoModel userShortInfoModelFromJson(String str) =>
    UserShortInfoModel.fromMap(json.decode(str));

String userShortInfoModelToJson(UserShortInfoModel data) =>
    json.encode(data.toMap());

class UserShortInfoModel {
  String status;
  List<UserShortInfoModelResponse> response;
  int code;

  UserShortInfoModel({
    this.status,
    this.response,
    this.code,
  });

  factory UserShortInfoModel.fromMap(Map<String, dynamic> json) =>
      UserShortInfoModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? null
            : List<UserShortInfoModelResponse>.from(json["response"]
                .map((x) => UserShortInfoModelResponse.fromMap(x))),
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

class UserShortInfoModelResponse {
  int id;
  String name;
  String lastName;
  String membershipCode;
  String profilePic;
  DateTime dob;
  String city;
  int govtIdStatus;
  int officeIdStatus;
  int linkedinIdStatus;
  Plan purchasePlan;
  UsersBasicDetails usersBasicDetails;
  OfficialDocuments officialDocuments;
  bool recommend;
  PhotoResponse dp;
  InfoResponse info;

  UserShortInfoModelResponse({
    this.id,
    this.name,
    this.lastName,
    this.membershipCode,
    this.profilePic,
    this.dob,
    this.city,
    this.govtIdStatus,
    this.officeIdStatus,
    this.linkedinIdStatus,
    this.purchasePlan,
    this.usersBasicDetails,
    this.officialDocuments,
    this.recommend,
    this.dp,
    this.info,
  });

  factory UserShortInfoModelResponse.fromMap(Map<String, dynamic> json) =>
      UserShortInfoModelResponse(
        id: json["id"] == null ? '' : json["id"],
        name: json["name"] == null ? '' : json["name"],
        lastName: json["last_name"] == null ? '' : json["last_name"],
        membershipCode:
            json["membership_code"] == null ? '' : json["membership_code"],
        profilePic: json["profile_pic"] == null ? '' : json["profile_pic"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        city: json["city"] == null ? '' : json["city"],
        govtIdStatus:
            json["govt_id_status"] == null ? 0 : json["govt_id_status"],
        officeIdStatus:
            json["office_id_status"] == null ? 0 : json["office_id_status"],
        linkedinIdStatus:
            json["linkedin_id_status"] == null ? 0 : json["linkedin_id_status"],
        purchasePlan: json["purchase_plan"] == null
            ? null
            : Plan.fromMap(json["purchase_plan"]),
        usersBasicDetails: json["users_basic_details"] == null
            ? UsersBasicDetails()
            : UsersBasicDetails.fromMap(json["users_basic_details"]),
        recommend: json["recommend"] == null ? null : json["recommend"],
        dp: json["dp"] == null
            ? PhotoResponse()
            : PhotoResponse.fromJson(json["dp"]),
        info: json["info"] == null
            ? InfoResponse()
            : InfoResponse.fromJson(json["info"]),
        officialDocuments: json["official_documents"] == null
            ? null
            : OfficialDocuments.fromJson(json["official_documents"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? '' : name,
        "last_name": lastName == null ? '' : lastName,
        "membership_code": membershipCode == null ? null : membershipCode,
        "profile_pic": profilePic == null ? null : profilePic,
        "dob": dob == null
            ? null
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "city": city == null ? null : city,
        "govt_id_status": govtIdStatus == null ? null : govtIdStatus,
        "office_id_status": officeIdStatus == null ? null : officeIdStatus,
        "linkedin_id_status":
            linkedinIdStatus == null ? null : linkedinIdStatus,
//        "payment_plan": purchasePlan == null ? null : purchasePlan,
        "users_basic_details":
            usersBasicDetails == null ? null : usersBasicDetails.toMap(),
        "dp": dp == null ? PhotoResponse() : dp.toJson(),
        "info": info == null ? InfoResponse() : info.toJson(),
      };

  @override
  String toString() {
    return 'UserShortInfoModelResponse{id: $id, name: $name, lastName: $lastName, membershipCode: $membershipCode, profilePic: $profilePic, dob: $dob, city: $city, govtIdStatus: $govtIdStatus, officeIdStatus: $officeIdStatus, linkedinIdStatus: $linkedinIdStatus, paymentPlan: $purchasePlan, usersBasicDetails: $usersBasicDetails, dp: $dp, info: $info}';
  }
}

class ImageTaken {
  int id;
  String type;
  String value;
  int parentId;
  String others;
  String status;

  ImageTaken({
    this.id,
    this.type,
    this.value,
    this.parentId,
    this.others,
    this.status,
  });

  factory ImageTaken.fromMap(Map<String, dynamic> json) => ImageTaken(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        value: json["value"] == null ? null : json["value"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        others: json["others"] == null ? null : json["others"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "value": value == null ? null : value,
        "parent_id": parentId == null ? null : parentId,
        "others": others == null ? null : others,
        "status": status == null ? null : status,
      };
}

class UserDetail {
  int id;
  String name;
  String lastName;
  String membershipCode;
  String gender;
  String profilePic;
  int emailVerification;
  int mobileVerification;
  int isActive;
  DateTime lastActive;
  dynamic hideAt;

  UserDetail({
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

  factory UserDetail.fromMap(Map<String, dynamic> json) => UserDetail(
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

  Map<String, dynamic> toMap() => {
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
}

class UsersBasicDetails {
  int id;
  int userId;
  UserDetail profileApprovedBy;
  dynamic profileRejectComment;
  DateTime profileApprovedAt;
  int paymentPlan;
  dynamic registeredBy;
  dynamic facebookId;
  dynamic googleId;
  dynamic linkedinId;
  String webRegistrationStep;
  String appRegistrationStep;
  int registrationStatus;
  dynamic couplingCompletedTime;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<PurchasePlan> purchasePlan;
  List<PurchaseTopup> purchaseTopup;
  List<dynamic> purchaseCoupling;

  UsersBasicDetails({
    this.id,
    this.userId,
    this.profileApprovedBy,
    this.profileRejectComment,
    this.profileApprovedAt,
    this.paymentPlan,
    this.registeredBy,
    this.facebookId,
    this.googleId,
    this.linkedinId,
    this.webRegistrationStep,
    this.appRegistrationStep,
    this.registrationStatus,
    this.couplingCompletedTime,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.purchasePlan,
    this.purchaseTopup,
    this.purchaseCoupling,
  });

  factory UsersBasicDetails.fromMap(Map<String, dynamic> json) =>
      UsersBasicDetails(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        profileApprovedBy: json["profile_approved_by"] == null
            ? null
            : UserDetail.fromMap(json["profile_approved_by"]),
        profileRejectComment: json["profile_reject_comment"],
        profileApprovedAt: json["profile_approved_at"] == null
            ? null
            : DateTime.parse(json["profile_approved_at"]),
        paymentPlan: json["payment_plan"] == null ? null : json["payment_plan"],
        registeredBy: json["registered_by"],
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
        linkedinId: json["linkedin_id"],
        webRegistrationStep: json["web_registration_step"] == null
            ? null
            : json["web_registration_step"],
        appRegistrationStep: json["app_registration_step"] == null
            ? null
            : json["app_registration_step"],
        registrationStatus: json["registration_status"] == null
            ? null
            : json["registration_status"],
        couplingCompletedTime: json["coupling_completed_time"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        purchasePlan: json["purchase_plan"] == null
            ? null
            : List<PurchasePlan>.from(
                json["purchase_plan"].map((x) => PurchasePlan.fromMap(x))),
        purchaseTopup: json["purchase_topup"] == null
            ? null
            : List<PurchaseTopup>.from(
                json["purchase_topup"].map((x) => PurchaseTopup.fromMap(x))),
        purchaseCoupling: json["purchase_coupling"] == null
            ? null
            : List<dynamic>.from(json["purchase_coupling"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "profile_approved_by":
            profileApprovedBy == null ? null : profileApprovedBy.toMap(),
        "profile_reject_comment": profileRejectComment,
        "profile_approved_at": profileApprovedAt == null
            ? null
            : profileApprovedAt.toIso8601String(),
        "payment_plan": paymentPlan == null ? null : paymentPlan,
        "registered_by": registeredBy,
        "facebook_id": facebookId,
        "google_id": googleId,
        "linkedin_id": linkedinId,
        "web_registration_step":
            webRegistrationStep == null ? null : webRegistrationStep,
        "app_registration_step":
            appRegistrationStep == null ? null : appRegistrationStep,
        "registration_status":
            registrationStatus == null ? null : registrationStatus,
        "coupling_completed_time": couplingCompletedTime,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "purchase_plan": purchasePlan == null
            ? null
            : List<dynamic>.from(purchasePlan.map((x) => x.toMap())),
        "purchase_topup": purchaseTopup == null
            ? null
            : List<dynamic>.from(purchaseTopup.map((x) => x.toMap())),
        "purchase_coupling": purchaseCoupling == null
            ? null
            : List<dynamic>.from(purchaseCoupling.map((x) => x)),
      };
}

class PurchasePlan {
  int id;
  int userId;
  int planId;
  String planName;
  String amount;
  int profilesCount;
  int scoreCount;
  String validity;
  int tokenOfLove;
  int searchProfile;
  int viewProfile;
  int sendInterests;
  int messages;
  int contactVisibility;
  int whatsappShare;
  int linkedinValidity;
  int csSummary;
  int csStatistics;
  int csMatch;
  int verificationBadge;
  int instantChat;
  int smsAlerts;
  int mailAlerts;
  String icon;
  String status;
  dynamic createdBy;
  DateTime expiredAt;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  PurchasePlan({
    this.id,
    this.userId,
    this.planId,
    this.planName,
    this.amount,
    this.profilesCount,
    this.scoreCount,
    this.validity,
    this.tokenOfLove,
    this.searchProfile,
    this.viewProfile,
    this.sendInterests,
    this.messages,
    this.contactVisibility,
    this.whatsappShare,
    this.linkedinValidity,
    this.csSummary,
    this.csStatistics,
    this.csMatch,
    this.verificationBadge,
    this.instantChat,
    this.smsAlerts,
    this.mailAlerts,
    this.icon,
    this.status,
    this.createdBy,
    this.expiredAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory PurchasePlan.fromMap(Map<String, dynamic> json) => PurchasePlan(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        planId: json["plan_id"] == null ? null : json["plan_id"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        amount: json["amount"] == null ? null : json["amount"],
        profilesCount:
            json["profiles_count"] == null ? null : json["profiles_count"],
        scoreCount: json["score_count"] == null ? null : json["score_count"],
        validity: json["validity"] == null ? null : json["validity"],
        tokenOfLove:
            json["token_of_love"] == null ? null : json["token_of_love"],
        searchProfile:
            json["search_profile"] == null ? null : json["search_profile"],
        viewProfile: json["view_profile"] == null ? null : json["view_profile"],
        sendInterests:
            json["send_interests"] == null ? null : json["send_interests"],
        messages: json["messages"] == null ? null : json["messages"],
        contactVisibility: json["contact_visibility"] == null
            ? null
            : json["contact_visibility"],
        whatsappShare:
            json["whatsapp_share"] == null ? null : json["whatsapp_share"],
        linkedinValidity: json["linkedin_validity"] == null
            ? null
            : json["linkedin_validity"],
        csSummary: json["cs_summary"] == null ? null : json["cs_summary"],
        csStatistics:
            json["cs_statistics"] == null ? null : json["cs_statistics"],
        csMatch: json["cs_match"] == null ? null : json["cs_match"],
        verificationBadge: json["verification_badge"] == null
            ? null
            : json["verification_badge"],
        instantChat: json["instant_chat"] == null ? null : json["instant_chat"],
        smsAlerts: json["sms_alerts"] == null ? null : json["sms_alerts"],
        mailAlerts: json["mail_alerts"] == null ? null : json["mail_alerts"],
        icon: json["icon"] == null ? null : json["icon"],
        status: json["status"] == null ? null : json["status"],
        createdBy: json["created_by"],
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "plan_id": planId == null ? null : planId,
        "plan_name": planName == null ? null : planName,
        "amount": amount == null ? null : amount,
        "profiles_count": profilesCount == null ? null : profilesCount,
        "score_count": scoreCount == null ? null : scoreCount,
        "validity": validity == null ? null : validity,
        "token_of_love": tokenOfLove == null ? null : tokenOfLove,
        "search_profile": searchProfile == null ? null : searchProfile,
        "view_profile": viewProfile == null ? null : viewProfile,
        "send_interests": sendInterests == null ? null : sendInterests,
        "messages": messages == null ? null : messages,
        "contact_visibility":
            contactVisibility == null ? null : contactVisibility,
        "whatsapp_share": whatsappShare == null ? null : whatsappShare,
        "linkedin_validity": linkedinValidity == null ? null : linkedinValidity,
        "cs_summary": csSummary == null ? null : csSummary,
        "cs_statistics": csStatistics == null ? null : csStatistics,
        "cs_match": csMatch == null ? null : csMatch,
        "verification_badge":
            verificationBadge == null ? null : verificationBadge,
        "instant_chat": instantChat == null ? null : instantChat,
        "sms_alerts": smsAlerts == null ? null : smsAlerts,
        "mail_alerts": mailAlerts == null ? null : mailAlerts,
        "icon": icon == null ? null : icon,
        "status": status == null ? null : status,
        "created_by": createdBy,
        "expired_at": expiredAt == null ? null : expiredAt.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class PurchaseTopup {
  int id;
  int purchasePlanId;
  int userId;
  int purchaseTopupId;
  String topupType;
  String amount;
  int validity;
  int profiles;
  dynamic status;
  dynamic activeAt;
  DateTime expiredAt;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  PurchaseTopup({
    this.id,
    this.purchasePlanId,
    this.userId,
    this.purchaseTopupId,
    this.topupType,
    this.amount,
    this.validity,
    this.profiles,
    this.status,
    this.activeAt,
    this.expiredAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory PurchaseTopup.fromMap(Map<String, dynamic> json) => PurchaseTopup(
        id: json["id"] == null ? null : json["id"],
        purchasePlanId:
            json["purchase_plan_id"] == null ? null : json["purchase_plan_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        purchaseTopupId: json["purchase_topup_id"] == null
            ? null
            : json["purchase_topup_id"],
        topupType: json["topup_type"] == null ? null : json["topup_type"],
        amount: json["amount"] == null ? null : json["amount"],
        validity: json["validity"] == null ? null : json["validity"],
        profiles: json["profiles"] == null ? null : json["profiles"],
        status: json["status"],
        activeAt: json["active_at"],
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "purchase_plan_id": purchasePlanId == null ? null : purchasePlanId,
        "user_id": userId == null ? null : userId,
        "purchase_topup_id": purchaseTopupId == null ? null : purchaseTopupId,
        "topup_type": topupType == null ? null : topupType,
        "amount": amount == null ? null : amount,
        "validity": validity == null ? null : validity,
        "profiles": profiles == null ? null : profiles,
        "status": status,
        "active_at": activeAt,
        "expired_at": expiredAt == null ? null : expiredAt.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
*/

// To parse this JSON data, do
//
//     final userShortInfoModel = userShortInfoModelFromJson(jsonString);

import 'dart:convert';

import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';

UserShortInfoModel userShortInfoModelFromJson(String str) =>
    UserShortInfoModel.fromJson(json.decode(str));

String userShortInfoModelToJson(UserShortInfoModel data) =>
    json.encode(data.toJson());

class UserShortInfoModel {
  UserShortInfoModel({
    this.status,
    this.response,
    this.code,
  });

  dynamic status;
  UserShortInfoResponse? response;
  dynamic code;

  factory UserShortInfoModel.fromJson(Map<String, dynamic> json) =>
      UserShortInfoModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? UserShortInfoResponse.fromJson({})
            : UserShortInfoResponse.fromJson(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response?.toJson(),
        "code": code == null ? null : code,
      };
}

class UserShortInfoResponse {
  UserShortInfoResponse({
    this.currentPage,
    required this.data,
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

  dynamic currentPage;
  List<Datum>? data;
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

  factory UserShortInfoResponse.fromJson(Map<String, dynamic> json) =>
      UserShortInfoResponse(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
    this.id,
    this.name,
    this.lastName,
    this.membershipCode,
    this.gender,
    this.dob,
    this.city,
    this.profilePic,
    this.emailVerification,
    this.mobileVerification,
    this.govtIdStatus,
    this.officeIdStatus,
    this.linkedinIdStatus,
    this.isActive,
    this.lastActive,
    this.hideAt,
    this.recommend,
    this.member,
    this.membership,
    this.dp,
    this.purchasePlan,
    this.officialDocuments,
    this.info,
    this.score,
    this.recomendCauseCount,
  });

  int? id;
  String? name;
  String? lastName;
  String? membershipCode;
  String? gender;
  DateTime? dob;
  String? city;
  String? profilePic;
  dynamic emailVerification;
  dynamic mobileVerification;
  dynamic govtIdStatus;
  dynamic officeIdStatus;
  dynamic linkedinIdStatus;
  dynamic isActive;
  dynamic lastActive;
  dynamic hideAt;
  dynamic recommend;
  dynamic member;
  Membership? membership;
  Dp? dp;
  dynamic purchasePlan = Plan(topups: []);
  OfficialDocuments? officialDocuments;
  Info? info;
  dynamic score;
  int? recomendCauseCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        membershipCode:
            json["membership_code"] == null ? null : json["membership_code"],
        gender: json["gender"] == null ? null : json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        city: json["city"] == null ? null : json["city"],
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
        govtIdStatus:
            json["govt_id_status"] == null ? 0 : json["govt_id_status"],
        officeIdStatus:
            json["office_id_status"] == null ? 0 : json["office_id_status"],
        linkedinIdStatus:
            json["linkedin_id_status"] == null ? 0 : json["linkedin_id_status"],
        recommend: json["recommend"] == null ? null : json["recommend"],
        member: json["member"] == null ? null : json["member"],
        membership: json["membership"] == null
            ? null
            : Membership.fromMap(json["membership"]),
        dp: json["dp"] == null ? null : Dp.fromMap(json["dp"]),
        purchasePlan: json["purchase_plan"] == null
            ? null
            : Plan.fromMap(json["purchase_plan"]),
        officialDocuments: json["official_documents"] == null
            ? null
            : OfficialDocuments.fromMap(json["official_documents"]),
        info: json["info"] == null ? null : Info.fromMap(json["info"]),
        score: json["score"] == null ? 0 : json["score"],
        recomendCauseCount: json["recomend_cause_count"] == null
            ? null
            : json["recomend_cause_count"],
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
        "govt_id_status": govtIdStatus == null ? null : govtIdStatus,
        "office_id_status": officeIdStatus == null ? null : officeIdStatus,
        "linkedin_id_status":
            linkedinIdStatus == null ? null : linkedinIdStatus,
        "recommend": recommend == null ? null : recommend,
        "member": member == null ? null : member,
        "dp": dp == null ? null : dp?.toMap(),
        "purchase_plan": purchasePlan == null ? null : purchasePlan.toMap(),
        "official_documents":
            officialDocuments == null ? null : officialDocuments!.toMap(),
        "info": info == null ? null : info!.toMap(),
      };
}

class ImageTaken {
  ImageTaken({
    this.id,
    this.type,
    this.value,
    this.parentId,
    this.others,
    this.status,
  });

  dynamic id;
  dynamic type;
  dynamic value;
  dynamic parentId;
  dynamic others;
  dynamic status;

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
