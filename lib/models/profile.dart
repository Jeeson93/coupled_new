// To parse this JSON data, do
//
//     final profileModel = profileModelFromMap(jsonString);

import 'dart:convert';
import 'dart:io';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:date_format/date_format.dart';

ProfileModel profileModelFromMap(String str) =>
    ProfileModel.fromMap(json.decode(str));

String profileModelToMap(ProfileModel data) => json.encode(data.toMap());

class ProfileModel {
  ProfileModel({
    this.status = '',
    required this.response,
    this.code = 0,
  });

  String status;
  ProfileResponse response;
  int code;

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        status: json["status"] == null ? null : json["status"],
        response: ProfileResponse.fromMap(json["response"]),
        code: json["code"] == null ? 0 : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? '' : status,
        "response": response == null ? {} : response.toMap(),
        "code": code == null ? 0 : code,
      };
}

class ProfileResponse {
  ProfileResponse({
    this.id = 0,
    this.name,
    this.lastName,
    this.notification = 0,
    this.membershipCode = '',
    this.gender = 'male',
    this.profilePic,
    this.emailVerification = 0,
    this.mobileVerification = 0,
    this.isActive = 0,
    this.edited = 0,
    this.online = 0,
    this.lastActive,
    this.hideAt,
    this.recommendGiven = 0,
    this.recommendReceived = 0,
    this.userEmail = '',
    this.userPhone = '',
    this.planName = '',
    this.planAmount = '',
    this.planValidity = '',
    this.totalCredits = 0,
    this.pendingCredits = 0,
    this.usedCredits = 0,
    this.planExpiry,
    this.planRechargedDate,
    this.recommend = false,
    this.membership,
    this.score = 0,
    this.recomendCause = const [],
    this.recomendCauseCount = 0,
    this.freeCoupling = const [],
    this.passwordStatus = false,
    this.address,
    this.educationJob,
    this.family,
    this.info,
    this.officialDocuments,
    this.photos = const [],
    this.dp,
    this.mom,
    this.reportMe,
    this.photoModel,
    this.chatCount = 0,
    this.blockMe,
    this.shortlistByMe,
    this.shortlistMe,
    this.preference,
    this.usersBasicDetails,
    this.siblings = const [],
    this.photoData = const [],
    this.userCoupling = const [],
    this.currentCsStatistics,
  });

  int id;
  dynamic name;
  dynamic lastName;
  int notification;
  dynamic membershipCode;
  dynamic gender;
  dynamic profilePic;
  int emailVerification;
  int mobileVerification;
  int isActive;
  int edited;
  int online;
  Mom? shortlistByMe;
  Mom? shortlistMe;
  dynamic lastActive;
  dynamic hideAt;
  int recommendGiven;
  int recommendReceived;
  dynamic userEmail;
  dynamic userPhone;
  dynamic planName;
  dynamic planAmount;
  dynamic planValidity;
  int totalCredits;
  int pendingCredits;
  int usedCredits;
  dynamic planExpiry;
  dynamic planRechargedDate;
  bool recommend;
  Membership? membership;
  PhotoModel? photoModel;
  int score;
  int recomendCauseCount;
  List<RecomendCause> recomendCause;
  List<FreeCoupling> freeCoupling;
  bool passwordStatus;
  Address? address;
  EducationJob? educationJob;
  Family? family;
  Info? info = Info(maritalStatus: BaseSettings(options: []));
  OfficialDocuments? officialDocuments;
  List<Dp?> photos;
  Dp? dp;
  int chatCount;
  Mom? mom;
  Mom? blockMe;
  Mom? reportMe;
  Preference? preference;
  UsersBasicDetails? usersBasicDetails;
  List<Sibling> siblings;
  List<UserCoupling> userCoupling;
  CurrentCsStatistics? currentCsStatistics;
  List<PhotoModel> photoData = <PhotoModel>[];
  dynamic officeId = File('');

  factory ProfileResponse.fromMap(Map<String, dynamic> json) => ProfileResponse(
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? '' : json["name"],
        lastName: json["last_name"] == null ? '' : json["last_name"],
        mom: json["mom"] == null ? null : Mom.fromMap(json["mom"]),
        reportMe: json["mom"] == null ? null : Mom.fromMap(json["mom"]),
        blockMe: json["mom"] == null ? null : Mom.fromMap(json["mom"]),
        chatCount: json["chat_count"] == null ? 0 : json["chat_count"],
        notification: json["notification"] == null ? '' : json["notification"],
        membershipCode:
            json["membership_code"] == null ? '' : json["membership_code"],
        gender: json["gender"] == null ? 'male' : json["gender"],
        profilePic: json["profile_pic"],
        emailVerification:
            json["email_verification"] == null ? 0 : json["email_verification"],
        mobileVerification: json["mobile_verification"] == null
            ? 0
            : json["mobile_verification"],
        isActive: json["is_active"] == null ? 0 : json["is_active"],
        edited: json["edited"] == null ? 0 : json["edited"],
        online: json["online"] == null ? 0 : json["online"],
        lastActive: json["last_active"] == null
            ? ''
            : DateTime.parse(json["last_active"]),
        hideAt: json["hide_at"],
        shortlistByMe: json["shortlist_by_me"] == null
            ? null
            : Mom.fromMap(json["shortlist_by_me"]),
        shortlistMe: json["shortlist_me"] == null
            ? null
            : Mom.fromMap(json["shortlist_me"]),
        recommendGiven:
            json["recommend_given"] == null ? 0 : json["recommend_given"],
        recommendReceived:
            json["recommend_received"] == null ? 0 : json["recommend_received"],
        freeCoupling: json["free_coupling"] == null
            ? []
            : List<FreeCoupling>.from(
                json["free_coupling"].map((x) => FreeCoupling.fromMap(x))),
        userEmail: json["user_email"] == null ? '' : json["user_email"],
        userPhone: json["user_phone"] == null ? '' : json["user_phone"],
        planName: json["plan_name"] == null ? '' : json["plan_name"],
        planAmount: json["plan_amount"] == null ? 0 : json["plan_amount"],
        planValidity:
            json["plan_validity"] == null ? '' : json["plan_validity"],
        totalCredits: json["total_credits"] == null ? 0 : json["total_credits"],
        pendingCredits:
            json["pending_credits"] == null ? 0 : json["pending_credits"],
        usedCredits: json["used_credits"] == null ? 0 : json["used_credits"],
        planExpiry: json["plan_expiry"] == null
            ? ''
            : DateTime.parse(json["plan_expiry"]),
        planRechargedDate: json["plan_recharged_date"] == null
            ? ''
            : DateTime.parse(json["plan_recharged_date"]),
        recommend: json["recommend"] == null ? false : json["recommend"],
        membership: json["membership"] == null
            ? null
            : Membership.fromMap(json["membership"]),
        score: json["score"] == null ? null : json["score"],
        recomendCauseCount: json["recomend_cause_count"] == null
            ? 0
            : json["recomend_cause_count"],
        recomendCause: json["recomend_cause"] == null
            ? []
            : List<RecomendCause>.from(
                json["recomend_cause"].map((x) => RecomendCause.fromMap(x))),
        passwordStatus:
            json["password_status"] == null ? false : json["password_status"],
        address:
            json["address"] == null ? null : Address.fromMap(json["address"]),
        educationJob: json["education_job"] == null
            ? null
            : EducationJob.fromMap(json["education_job"]),
        family: json["family"] == null ? null : Family.fromMap(json["family"]),
        info: json["info"] == null ? null : Info.fromMap(json["info"]),
        officialDocuments: json["official_documents"] == null
            ? null
            : OfficialDocuments.fromMap(json["official_documents"]),
        photos: json["photos"] == null
            ? []
            : List<Dp>.from(json["photos"].map((x) => Dp.fromMap(x))),
        dp: json["dp"] == null ? null : Dp.fromMap(json["dp"]),
        preference: json["preference"] == null
            ? null
            : Preference.fromMap(json["preference"]),
        usersBasicDetails: json["users_basic_details"] == null
            ? null
            : UsersBasicDetails.fromMap(json["users_basic_details"]),
        siblings: json["siblings"] == null
            ? []
            : List<Sibling>.from(
                json["siblings"].map((x) => Sibling.fromMap(x))),
        userCoupling: json["user_coupling"] == null
            ? []
            : List<UserCoupling>.from(
                json["user_coupling"].map((x) => UserCoupling.fromMap(x))),
        currentCsStatistics: json["current_cs_statistics"] == null
            ? null
            : CurrentCsStatistics.fromMap(json["current_cs_statistics"]),
        photoData: [],
        photoModel: PhotoModel(),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? 0 : id,
        "name": name == null ? '' : name,
        "last_name": lastName == null ? '' : lastName,
        "notification": notification == null ? 0 : notification,
        "membership_code": membershipCode == null ? '' : membershipCode,
        "gender": gender == null ? '' : gender,
        "profile_pic": profilePic == null ? '' : profilePic,
        "email_verification": emailVerification == null ? 0 : emailVerification,
        "mobile_verification":
            mobileVerification == null ? 0 : mobileVerification,
        "is_active": isActive == null ? 0 : isActive,
        "edited": edited == null ? 0 : edited,
        "online": online == null ? 0 : online,
        "last_active": lastActive == null ? '' : lastActive,
        "hide_at": hideAt == null ? 0 : hideAt,
        "recommend_given": recommendGiven == null ? 0 : recommendGiven,
        "recommend_received": recommendReceived == null ? 0 : recommendReceived,
        "user_email": userEmail == null ? '' : userEmail,
        "user_phone": userPhone == null ? '' : userPhone,
        "plan_name": planName == null ? '' : planName,
        "plan_amount": planAmount == null ? '' : planAmount,
        "plan_validity": planValidity == null ? '' : planValidity,
        "total_credits": totalCredits == null ? 0 : totalCredits,
        "pending_credits": pendingCredits == null ? 0 : pendingCredits,
        "used_credits": usedCredits == null ? 0 : usedCredits,
        "plan_expiry": planExpiry == null ? '' : planExpiry.toIso8601String(),
        "plan_recharged_date": planRechargedDate == null
            ? ''
            : planRechargedDate.toIso8601String(),
        "recommend": recommend == null ? false : recommend,
        "membership": membership == null ? null : membership!.toMap(),
        "score": score == null ? 0 : score,
        "recomend_cause_count":
            recomendCauseCount == null ? 0 : recomendCauseCount,
        "password_status": passwordStatus == null ? false : passwordStatus,
        "address": address == null ? '' : address!.toMap(),
        "education_job": educationJob == null ? '' : educationJob!.toMap(),
        "family": family == null ? '' : family!.toMap(),
        "info": info == null ? '' : info!.toMap(),
        "official_documents":
            officialDocuments == null ? '' : officialDocuments!.toMap(),
        "photos": photos == null
            ? []
            : List<dynamic>.from(photos.map((x) => x?.toMap())),
        "dp": dp == null ? '' : dp!.toMap(),
        "preference": preference == null ? '' : preference!.toMap(),
        "users_basic_details":
            usersBasicDetails == null ? '' : usersBasicDetails!.toMap(),
        "siblings": siblings == null
            ? []
            : List<dynamic>.from(siblings.map((x) => x.toMap())),
        "user_coupling": userCoupling == null
            ? []
            : List<dynamic>.from(userCoupling.map((x) => x.toMap())),
        "current_cs_statistics":
            currentCsStatistics == null ? '' : currentCsStatistics!.toMap(),
      };
}

class FreeCoupling {
  FreeCoupling({
    this.id = 0,
    this.couplingType = '',
    this.type = '',
    this.question = '',
    this.questionOrder = 0,
    this.parent = 0,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.score = 0.0,
    this.message = '',
  });

  int id;
  String couplingType;
  String type;
  String question;
  int questionOrder;
  int parent;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  double score;
  String message;

  factory FreeCoupling.fromMap(Map<String, dynamic> json) => FreeCoupling(
        id: json["id"] == null ? 0 : json["id"],
        couplingType:
            json["coupling_type"] == null ? '' : json["coupling_type"],
        type: json["type"] == null ? '' : json["type"],
        question: json["question"] == null ? '' : json["question"],
        questionOrder:
            json["question_order"] == null ? 0 : json["question_order"],
        parent: json["parent"] == null ? 0 : json["parent"],
        status: json["status"] == null ? '' : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        score: json["score"] == null ? 0.0 : json["score"].toDouble(),
        message: json["message"] == null ? '' : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? 0 : id,
        "coupling_type": couplingType == null ? '' : couplingType,
        "type": type == null ? '' : type,
        "question": question == null ? '' : question,
        "question_order": questionOrder == null ? '' : questionOrder,
        "parent": parent == null ? '' : parent,
        "status": status == null ? '' : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null
            ? DateTime.parse('')
            : createdAt.toIso8601String(),
        "updated_at": updatedAt == null
            ? DateTime.parse('')
            : updatedAt.toIso8601String(),
        "score": score == null ? null : score,
        "message": message == null ? '' : message,
      };
}

class Address {
  Address({
    this.id = 0,
    this.userId = 0,
    this.addressType,
    this.countryCode = '',
    this.country = '',
    this.state = '',
    this.city = '',
    this.locationId = 0,
    this.address = '',
    this.pincode = 0,
    this.presentAddress = 0,
    this.tolStatus = 0,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  dynamic addressType;
  String countryCode;
  String country;
  String state;
  String city;
  int? locationId;
  String address;
  int pincode;
  int presentAddress;
  int tolStatus;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? 0 : json["id"],
        userId: json["user_id"] == null ? 0 : json["user_id"],
        addressType: json["address_type"] == null ? '' : json["address_type"],
        countryCode: json["country_code"] == null ? '' : json["country_code"],
        country: json["country"] == null ? '' : json["country"],
        state: json["state"] == null ? '' : json["state"],
        city: json["city"] == null ? '' : json["city"],
        locationId: json["location_id"] == null ? 0 : json["location_id"],
        address: json["address"] == null ? '' : json["address"],
        pincode: json["pincode"] == null ? 0 : json["pincode"],
        presentAddress:
            json["present_address"] == null ? 0 : json["present_address"],
        tolStatus: json["tol_status"] == null ? 0 : json["tol_status"],
        status: json["status"] == null ? '' : json["status"],
        deletedAt: json["deleted_at"] == null
            ? ''
            : DateTime.parse(json["deleted_at"]),
        createdAt: json["created_at"] == null
            ? ''
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? ''
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? 0 : id,
        "user_id": userId == null ? 0 : userId,
        "address_type": addressType == null ? '' : addressType,
        "country_code": countryCode == null ? '' : countryCode,
        "country": country == null ? 'country' : country,
        "state": state == null ? 'state' : state,
        "city": city == null ? 'city' : city,
        "location_id": locationId == null ? 0 : locationId,
        "address": address == null ? '' : address,
        "pincode": pincode == null ? 0 : pincode,
        "present_address": presentAddress == null ? 0 : presentAddress,
        "tol_status": tolStatus == null ? 0 : tolStatus,
        "status": status == null ? '' : status,
        "deleted_at": deletedAt == null ? null : deletedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    return 'Address{id: $id, userId: $userId, addressType: $addressType, countryCode: $countryCode, country: $country, state: $state, city: $city, locationId: $locationId, address: $address, pincode: $pincode, presentAddress: $presentAddress, tolStatus: $tolStatus, status: $status, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class CurrentCsStatistics {
  CurrentCsStatistics({
    this.id = 0,
    this.userId = 0,
    this.couplingScoreId = 0,
    this.activationFee = 0,
    this.validity = 0,
    this.couplingScorePlanOption,
    this.status = '',
    this.activeAt,
    this.expiredAt,
    this.deletedAt,
    this.createdAt = '',
    this.updatedAt = '',
  });

  int id;
  int userId;
  int couplingScoreId;
  int activationFee;
  int validity;
  dynamic couplingScorePlanOption;
  String status;
  dynamic activeAt;
  dynamic expiredAt;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory CurrentCsStatistics.fromMap(Map<String, dynamic> json) =>
      CurrentCsStatistics(
        id: json["id"] == null ? 0 : json["id"],
        userId: json["user_id"] == null ? 0 : json["user_id"],
        couplingScoreId:
            json["coupling_score_id"] == null ? 0 : json["coupling_score_id"],
        activationFee:
            json["activation_fee"] == null ? 0 : json["activation_fee"],
        validity: json["validity"] == null ? 0 : json["validity"],
        couplingScorePlanOption: json["coupling_score_plan_option"],
        status: json["status"] == null ? '' : json["status"],
        activeAt:
            json["active_at"] == null ? '' : DateTime.parse(json["active_at"]),
        expiredAt: json["expired_at"] == null
            ? ''
            : DateTime.parse(json["expired_at"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? ''
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? ''
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? 0 : id,
        "user_id": userId == null ? 0 : userId,
        "coupling_score_id": couplingScoreId == null ? 0 : couplingScoreId,
        "activation_fee": activationFee == null ? 0 : activationFee,
        "validity": validity == null ? 0 : validity,
        "coupling_score_plan_option": couplingScorePlanOption,
        "status": status == null ? '' : status,
        "active_at": activeAt == null ? '' : activeAt.toIso8601String(),
        "expired_at": expiredAt == null ? '' : expiredAt.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? '' : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? '' : updatedAt.toIso8601String(),
      };
}

class Dp {
  Dp({
    this.id = 0,
    this.userId = 0,
    this.photoName = '',
    this.fromType = '',
    this.imageType,
    this.status = 0,
    this.rejectStatus = 0,
    this.approvedBy,
    this.photoApprovedAt,
    this.comments,
    this.trash = 0,
    this.imageTaken,
    this.dpStatus = 0,
    this.sortOrder = 0,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.userDetail,
  });

  int id;
  int userId;
  String photoName = '';
  String fromType;
  BaseSettings? imageType;
  int status;
  int rejectStatus;
  dynamic approvedBy;
  dynamic photoApprovedAt;
  dynamic comments;
  int trash;
  BaseSettings? imageTaken;
  int dpStatus;
  int sortOrder;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  UserDetail? userDetail;

  factory Dp.fromMap(Map<String, dynamic> json) => Dp(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        photoName: json["photo_names"] == null ? '' : json["photo_names"],
        fromType: json["from_type"] == null ? '' : json["from_type"],
        imageType: json["image_type"] == null
            ? null
            : BaseSettings.fromJson(json["image_type"]),
        status: json["status"] == null ? 0 : json["status"],
        rejectStatus: json["reject_status"] == null ? 0 : json["reject_status"],
        approvedBy: json["approved_by"] == null ? '' : json["approved_by"],
        photoApprovedAt: json["photo_approved_at"] == null
            ? null
            : json["photo_approved_at"],
        comments: json["comments"] == null ? null : json["comments"],
        trash: json["trash"] == null ? 0 : json["trash"],
        imageTaken: json["image_taken"] == null
            ? null
            : BaseSettings.fromJson(json["image_taken"]),
        dpStatus: json["dp_status"] == null ? 0 : json["dp_status"],
        sortOrder: json["sort_order"] == null ? 0 : json["sort_order"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? ''
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? ''
            : DateTime.parse(json["updated_at"]),
        userDetail: json["user_detail"] == null
            ? null
            : UserDetail.fromMap(json["user_detail"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? 0 : id,
        "user_id": userId == null ? 0 : userId,
        "photo_names": photoName == null ? '' : photoName,
        "from_type": fromType == null ? null : fromType,
        "image_type": imageType == null ? null : imageType!.toJson(),
        "status": status == null ? null : status,
        "reject_status": rejectStatus == null ? null : rejectStatus,
        "approved_by": approvedBy,
        "photo_approved_at": photoApprovedAt,
        "comments": comments,
        "trash": trash == null ? null : trash,
        "image_taken": imageTaken == null ? null : imageTaken!.toJson(),
        "dp_status": dpStatus == null ? null : dpStatus,
        "sort_order": sortOrder == null ? null : sortOrder,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "user_detail": userDetail == null ? null : userDetail!.toMap(),
      };
}

class UserDetail {
  UserDetail({
    this.id,
    this.name,
    this.lastName,
    this.notification,
    this.membershipCode,
    this.gender,
    this.profilePic,
    this.emailVerification,
    this.mobileVerification,
    this.isActive,
    this.edited,
    this.online,
    this.lastActive,
    this.hideAt,
    this.recommend,
    this.membership,
    this.score,
    this.recomendCauseCount,
    this.passwordStatus,
  });

   int? id;
  String? name;
  String? lastName;
  int? notification;
  String? membershipCode;
  String? gender;
  dynamic profilePic;
  int? emailVerification;
  int? mobileVerification;
  int? isActive;
  int? edited;
  int? online;
  dynamic lastActive;
  dynamic hideAt;
  bool? recommend;
  Membership? membership;
  int? score;
  int? recomendCauseCount;
  bool? passwordStatus;

  factory UserDetail.fromMap(Map<String, dynamic> json) => UserDetail(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        notification:
            json["notification"] == null ? null : json["notification"],
        membershipCode:
            json["membership_code"] == null ? null : json["membership_code"],
        gender: json["gender"] == null ? null : json["gender"],
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
        recommend: json["recommend"] == null ? null : json["recommend"],
        membership: json["membership"] == null
            ? null
            : Membership.fromMap(json["membership"]),
        score: json["score"] == null ? null : json["score"],
        recomendCauseCount: json["recomend_cause_count"] == null
            ? null
            : json["recomend_cause_count"],
        passwordStatus:
            json["password_status"] == null ? null : json["password_status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "last_name": lastName == null ? null : lastName,
        "notification": notification == null ? null : notification,
        "membership_code": membershipCode == null ? null : membershipCode,
        "gender": gender == null ? null : gender,
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
        "recommend": recommend == null ? null : recommend,
        "membership": membership == null ? null : membership!.toMap(),
        "score": score == null ? null : score,
        "recomend_cause_count":
            recomendCauseCount == null ? null : recomendCauseCount,
        "password_status": passwordStatus == null ? null : passwordStatus,
      };
}

class Membership {
  Membership({
    this.paidMember,
    this.planName,
    this.chat,
    this.statistics,
    this.share,
    this.verificationBadge,
    this.expiredAt,
  });

    bool? paidMember;
  String? planName;
  int? chat;
  int? statistics;
  int? share;
  int? verificationBadge;
  DateTime? expiredAt;

  factory Membership.fromMap(Map<String, dynamic> json) => Membership(
        paidMember: json["paid_member"] == null ? false : json["paid_member"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        chat: json["chat"] == null ? null : json["chat"],
        statistics: json["statistics"] == null ? null : json["statistics"],
        share: json["share"] == null ? null : json["share"],
        verificationBadge: json["verification_badge"] == null
            ? null
            : json["verification_badge"],
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
      );

  Map<String, dynamic> toMap() => {
        "paid_member": paidMember == null ? null : paidMember,
        "plan_name": planName == null ? null : planName,
        "chat": chat == null ? null : chat,
        "statistics": statistics == null ? null : statistics,
        "share": share == null ? null : share,
        "verification_badge":
            verificationBadge == null ? null : verificationBadge,
        "expired_at": expiredAt == null ? null : expiredAt?.toIso8601String(),
      };
}

class EducationJob {
  EducationJob({
    this.id,
    this.userId,
    this.linkedInStatus,
    this.jobStatus,
    this.companyName = '',
    this.industry,
    this.profession,
    this.experience,
    this.highestEducation,
    this.educationBranch,
    this.incomeRange,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic userId;
  dynamic linkedInStatus;
  dynamic jobStatus;
  dynamic companyName;
  BaseSettings? industry;
  BaseSettings? profession;
  BaseSettings? experience;
  BaseSettings? highestEducation;
  BaseSettings? educationBranch;
  BaseSettings? incomeRange;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory EducationJob.fromMap(Map<String, dynamic> json) => EducationJob(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        linkedInStatus: json["linked_in_status"],
        jobStatus: json["job_status"] == null ? null : json["job_status"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        industry: json["industry"] == null
            ? null
            : BaseSettings.fromJson(json["industry"]),
        profession: json["profession"] == null
            ? null
            : BaseSettings.fromJson(json["profession"]),
        experience: json["experience"] == null
            ? null
            : BaseSettings.fromJson(json["experience"]),
        highestEducation: json["highest_education"] == null
            ? null
            : BaseSettings.fromJson(json["highest_education"]),
        educationBranch: json["education_branch"] == null
            ? null
            : BaseSettings.fromJson(json["education_branch"]),
        incomeRange: json["income_range"] == null
            ? null
            : BaseSettings.fromJson(json["income_range"]),
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
        "linked_in_status": linkedInStatus,
        "job_status": jobStatus == null ? null : jobStatus,
        "company_name": companyName,
        "industry": industry == null ? null : industry!.toJson(),
        "profession": profession,
        "experience": experience == null ? null : experience!.toJson(),
        "highest_education":
            highestEducation == null ? null : highestEducation!.toJson(),
        "education_branch":
            educationBranch == null ? null : educationBranch!.toJson(),
        "income_range": incomeRange == null ? null : incomeRange!.toJson(),
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Family {
  Family({
    this.id,
    this.userId,
    this.fatherName,
    this.fatherOccupationStatus,
    this.motherName,
    this.motherOccupationStatus,
    this.familyType,
    this.familyValues,
    this.religion,
    this.cast,
    this.subcast,
    this.gothram,
    this.countryCode,
    this.country,
    this.state,
    this.city,
    this.locationId,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic userId;
  dynamic fatherName;
  BaseSettings? fatherOccupationStatus;
  dynamic motherName;
  BaseSettings? motherOccupationStatus;
  BaseSettings? familyType;
  BaseSettings? familyValues;
  BaseSettings? religion;
  BaseSettings? cast;
  BaseSettings? subcast;
  BaseSettings? gothram;
  dynamic countryCode;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic locationId;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory Family.fromMap(Map<String, dynamic> json) => Family(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        fatherName: json["father_name"],
        fatherOccupationStatus: json["father_occupation_status"] == null
            ? null
            : BaseSettings.fromJson(json["father_occupation_status"]),
        motherName: json["mother_name"],
        motherOccupationStatus: json["mother_occupation_status"] == null
            ? null
            : BaseSettings.fromJson(json["mother_occupation_status"]),
        familyType: json["family_type"] == null
            ? null
            : BaseSettings.fromJson(json["family_type"]),
        familyValues: json["family_values"] == null
            ? null
            : BaseSettings.fromJson(json["family_values"]),
        religion: json["religion"] == null
            ? null
            : BaseSettings.fromJson(json["religion"]),
        cast: json["cast"] == null ? null : BaseSettings.fromJson(json["cast"]),
        subcast: json["subcast"] == null
            ? null
            : BaseSettings.fromJson(json["subcast"]),
        gothram: json["gothram"] == null
            ? null
            : BaseSettings.fromJson(json["gothram"]),
        countryCode: json["country_code"] == null ? null : json["country_code"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        locationId: json["location_id"] == null ? null : json["location_id"],
        status: json["status"],
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
        "father_name": fatherName,
        "father_occupation_status": fatherOccupationStatus,
        "mother_name": motherName,
        "mother_occupation_status": motherOccupationStatus,
        "family_type": familyType,
        "family_values": familyValues,
        "religion": religion == null ? null : religion!.toJson(),
        "cast": cast,
        "subcast": subcast,
        "gothram": gothram,
        "country_code": countryCode == null ? null : countryCode,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "location_id": locationId == null ? null : locationId,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Info {
  Info({
    this.id,
    this.userId,
    this.dob,
    this.dobStatus,
    this.height,
    this.weight,
    this.bodyType,
    this.complexion,
    this.specialCase = 0,
    this.specialCaseType,
    this.specialCaseNotify = 0,
    this.adminApprovalStatus,
    this.countryCode,
    this.country,
    this.state,
    this.city,
    this.locationId,
    this.maritalStatus,
    this.numberOfChildren,
    this.childLivingStatus,
    this.bornPlace,
    this.bornTime = '',
    this.aboutSelf,
    this.aboutPartner = '',
    this.completedStatus,
    this.completedIn,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  DateTime? dob;
  int? dobStatus;
  int? height;
  int? weight;
  BaseSettings? bodyType;
  BaseSettings? complexion;
  int? specialCase;
  BaseSettings? specialCaseType;
  int? specialCaseNotify;
  int? adminApprovalStatus;
  String? countryCode;
  String? country;
  String? state;
  String? city;
  int? locationId;
  BaseSettings? maritalStatus;
  int? numberOfChildren;
  BaseSettings? childLivingStatus;
  dynamic bornPlace;
  String? bornTime;
  String? aboutSelf;
  String? aboutPartner;
  dynamic completedStatus;
  dynamic completedIn;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Info.fromMap(Map<String, dynamic> json) => Info(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        dobStatus: json["dob_status"] == null ? null : json["dob_status"],
        height: json["height"] == null ? null : json["height"],
        weight: json["weight"] == null ? null : json["weight"],
        bodyType: json["body_type"] == null
            ? null
            : BaseSettings.fromJson(json["body_type"]),
        complexion: json["complexion"] == null
            ? null
            : BaseSettings.fromJson(json["complexion"]),
        specialCase: json["special_case"] == null ? 0 : json["special_case"],
        specialCaseType: json["special_case_type"] == null
            ? null
            : BaseSettings.fromJson(json["special_case_type"]),
        specialCaseNotify: json["special_case_notify"] == null
            ? 0
            : json["special_case_notify"],
        adminApprovalStatus: json["admin_approval_status"] == null
            ? null
            : json["admin_approval_status"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        locationId: json["location_id"] == null ? null : json["location_id"],
        maritalStatus: json["marital_status"] == null
            ? null
            : BaseSettings.fromJson(json["marital_status"]),
        numberOfChildren: json["number_of_children"] == null
            ? null
            : json["number_of_children"],
        childLivingStatus: json["child_living_status"] == null
            ? null
            : BaseSettings.fromJson(json["child_living_status"]),
        bornPlace: json["born_place"] == null ? null : json["born_place"],
        bornTime: json["born_time"] == null ? '' : json["born_time"],
        aboutSelf: json["about_self"] == null ? null : json["about_self"],
        aboutPartner:
            json["about_partner"] == null ? null : json["about_partner"],
        completedStatus: json["completed_status"],
        completedIn: json["completed_in"],
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
        "dob": dob == null
            ? null
            : "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "dob_status": dobStatus == null ? null : dobStatus,
        "height": height == null ? null : height,
        "weight": weight == null ? null : weight,
        "body_type": bodyType == null ? null : bodyType?.toJson(),
        "complexion": complexion == null ? null : complexion?.toJson(),
        "special_case": specialCase == null ? null : specialCase,
        "special_case_type":
            specialCaseType == null ? null : specialCaseType?.toJson(),
        "special_case_notify":
            specialCaseNotify == null ? null : specialCaseNotify,
        "admin_approval_status":
            adminApprovalStatus == null ? null : adminApprovalStatus,
        "country_code": countryCode == null ? null : countryCode,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "location_id": locationId == null ? null : locationId,
        "marital_status":
            maritalStatus == null ? null : maritalStatus!.toJson(),
        "number_of_children":
            numberOfChildren == null ? null : numberOfChildren,
        "child_living_status":
            childLivingStatus == null ? null : childLivingStatus?.toJson(),
        "born_place": bornPlace,
        "born_time": bornTime == null ? null : bornTime,
        "about_self": aboutSelf == null ? null : aboutSelf,
        "about_partner": aboutPartner == null ? null : aboutPartner,
        "completed_status": completedStatus,
        "completed_in": completedIn,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}

class OfficialDocuments {
  OfficialDocuments({
    this.id,
    this.userId,
    this.govtIdType,
    this.govtIdFront,
    this.govtIdBack,
    this.govtIdStatus,
    this.govtIdApprovedBy,
    this.govtIdRejectComments,
    this.officeIdRejectStatus,
    this.govIdRejectStatus,
    this.govtIdApprovedAt,
    this.officeId,
    this.officeIdStatus,
    this.officeIdApprovedBy,
    this.officeIdRejectComments,
    this.officeIdApprovedAt,
    this.linkedinId,
    this.linkedinIdStatus,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic userId;
  dynamic govtIdType;
  dynamic govtIdFront;
  dynamic govtIdBack;
  dynamic govtIdStatus;
  dynamic govtIdApprovedBy;
  dynamic govtIdRejectComments;
  dynamic officeIdRejectStatus;
  dynamic govIdRejectStatus;
  dynamic govtIdApprovedAt;
  dynamic officeId;
  dynamic officeIdStatus;
  dynamic officeIdApprovedBy;
  dynamic officeIdRejectComments;
  dynamic officeIdApprovedAt;
  dynamic linkedinId;
  dynamic linkedinIdStatus;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory OfficialDocuments.fromMap(Map<String, dynamic> json) =>
      OfficialDocuments(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        govtIdType: json["govt_id_type"] == null ? null : json["govt_id_type"],
        govtIdFront: json["govt_id_front"],
        govtIdBack: json["govt_id_back"],
        govtIdStatus: json["govt_id_status"],
        govtIdApprovedBy: json["govt_id_approved_by"],
        govtIdRejectComments: json["govt_id_reject_comments"],
        officeIdRejectStatus: json["office_id_reject_status"] == null
            ? null
            : json["office_id_reject_status"],
        govIdRejectStatus: json["gov_id_reject_status"] == null
            ? null
            : json["gov_id_reject_status"],
        govtIdApprovedAt: json["govt_id_approved_at"],
        officeId: json["office_id"] == null ? null : json["office_id"],
        officeIdStatus:
            json["office_id_status"] == null ? null : json["office_id_status"],
        officeIdApprovedBy: json["office_id_approved_by"],
        officeIdRejectComments: json["office_id_reject_comments"],
        officeIdApprovedAt: json["office_id_approved_at"],
        linkedinId: json["linkedin_id"],
        linkedinIdStatus: json["linkedin_id_status"] == null
            ? null
            : json["linkedin_id_status"],
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
        "govt_id_type": govtIdType == null ? null : govtIdType,
        "govt_id_front": govtIdFront,
        "govt_id_back": govtIdBack,
        "govt_id_status": govtIdStatus,
        "govt_id_approved_by": govtIdApprovedBy,
        "govt_id_reject_comments": govtIdRejectComments,
        "office_id_reject_status":
            officeIdRejectStatus == null ? null : officeIdRejectStatus,
        "gov_id_reject_status":
            govIdRejectStatus == null ? null : govIdRejectStatus,
        "govt_id_approved_at": govtIdApprovedAt,
        "office_id": officeId,
        "office_id_status": officeIdStatus == null ? null : officeIdStatus,
        "office_id_approved_by": officeIdApprovedBy,
        "office_id_reject_comments": officeIdRejectComments,
        "office_id_approved_at": officeIdApprovedAt,
        "linkedin_id": linkedinId,
        "linkedin_id_status":
            linkedinIdStatus == null ? null : linkedinIdStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    return 'OfficialDocuments{id: $id, userId: $userId, govtIdType: $govtIdType, govtIdFront: $govtIdFront, govtIdBack: $govtIdBack, govtIdStatus: $govtIdStatus, govtIdApprovedBy: $govtIdApprovedBy, govtIdRejectComments: $govtIdRejectComments, officeIdRejectStatus: $officeIdRejectStatus, govIdRejectStatus: $govIdRejectStatus, govtIdApprovedAt: $govtIdApprovedAt, officeId: $officeId, officeIdStatus: $officeIdStatus, officeIdApprovedBy: $officeIdApprovedBy, officeIdRejectComments: $officeIdRejectComments, officeIdApprovedAt: $officeIdApprovedAt, linkedinId: $linkedinId, linkedinIdStatus: $linkedinIdStatus, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class Preference {
  Preference({
    this.id,
    this.userId,
    this.preferenceType,
    this.ageMin,
    this.ageMax,
    this.heightMin,
    this.heightMax,
    this.weightMin,
    this.weightMax,
    this.bodyType,
    this.complexion,
    this.countryCode,
    this.country,
    this.state,
    this.city,
    this.locationId,
    this.maritalStatus,
    this.specialcase,
    this.religion,
    this.cast,
    this.subCast,
    this.gothram,
    this.fatherOccupationStatus,
    this.motherOccupationStatus,
    this.sibling,
    this.familyCountryCode,
    this.familyCountry,
    this.familyState,
    this.familyCity,
    this.familyLocationId,
    this.familyType,
    this.familyValues,
    this.occupation,
    this.profession,
    this.designation,
    this.workingExperience,
    this.education,
    this.incomeRange,
    this.saveAs,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  dynamic preferenceType;
  dynamic ageMin;
  dynamic ageMax;
  int? heightMin;
  int? heightMax;
  dynamic weightMin;
  dynamic weightMax;
  BaseSettings? bodyType;
  BaseSettings? complexion;
  String? countryCode;
  dynamic country;
  dynamic state;
  dynamic city;
  int? locationId;
  dynamic maritalStatus;
  dynamic specialcase;
  dynamic religion;
  dynamic cast;
  dynamic subCast;
  dynamic gothram;
  dynamic fatherOccupationStatus;
  dynamic motherOccupationStatus;
  dynamic sibling;
  String? familyCountryCode;
  dynamic familyCountry;
  dynamic familyState;
  dynamic familyCity;
  int? familyLocationId;
  dynamic familyType;
  dynamic familyValues;
  dynamic occupation;
  dynamic profession;
  dynamic designation;
  dynamic workingExperience;
  dynamic education;
  dynamic incomeRange;
  dynamic saveAs;
  dynamic status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Preference.fromMap(Map<String, dynamic> json) => Preference(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        preferenceType: json["preference_type"],
        ageMin: json["age_min"],
        ageMax: json["age_max"],
        heightMin: json["height_min"] == null ? null : json["height_min"],
        heightMax: json["height_max"] == null ? null : json["height_max"],
        weightMin: json["weight_min"],
        weightMax: json["weight_max"],
        bodyType: json["body_type"] == null
            ? null
            : BaseSettings.fromJson(json["body_type"]),
        complexion: json["complexion"] == null
            ? null
            : BaseSettings.fromJson(json["complexion"]),
        countryCode: json["country_code"] == null ? null : json["country_code"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        locationId: json["location_id"] == null ? null : json["location_id"],
        maritalStatus: json["marital_status"],
        specialcase: json["specialcase"],
        religion: json["religion"],
        cast: json["cast"],
        subCast: json["sub_cast"],
        gothram: json["gothram"],
        fatherOccupationStatus: json["father_occupation_status"],
        motherOccupationStatus: json["mother_occupation_status"],
        sibling: json["sibling"],
        familyCountryCode: json["family_country_code"] == null
            ? null
            : json["family_country_code"],
        familyCountry: json["family_country"],
        familyState: json["family_state"],
        familyCity: json["family_city"],
        familyLocationId: json["family_location_id"] == null
            ? null
            : json["family_location_id"],
        familyType: json["family_type"],
        familyValues: json["family_values"],
        occupation: json["occupation"],
        profession: json["profession"],
        designation: json["designation"],
        workingExperience: json["working_experience"],
        education: json["education"],
        incomeRange: json["income_range"],
        saveAs: json["save_as"],
        status: json["status"],
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
        "preference_type": preferenceType,
        "age_min": ageMin,
        "age_max": ageMax,
        "height_min": heightMin == null ? null : heightMin,
        "height_max": heightMax == null ? null : heightMax,
        "weight_min": weightMin,
        "weight_max": weightMax,
        "body_type": bodyType,
        "complexion": complexion,
        "country_code": countryCode == null ? null : countryCode,
        "country": country,
        "state": state,
        "city": city,
        "location_id": locationId == null ? null : locationId,
        "marital_status": maritalStatus,
        "specialcase": specialcase,
        "religion": religion,
        "cast": cast,
        "sub_cast": subCast,
        "gothram": gothram,
        "father_occupation_status": fatherOccupationStatus,
        "mother_occupation_status": motherOccupationStatus,
        "sibling": sibling,
        "family_country_code":
            familyCountryCode == null ? null : familyCountryCode,
        "family_country": familyCountry,
        "family_state": familyState,
        "family_city": familyCity,
        "family_location_id":
            familyLocationId == null ? null : familyLocationId,
        "family_type": familyType,
        "family_values": familyValues,
        "occupation": occupation,
        "profession": profession,
        "designation": designation,
        "working_experience": workingExperience,
        "education": education,
        "income_range": incomeRange,
        "save_as": saveAs,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}

class Sibling {
  Sibling({
    this.id,
    this.userId,
    this.siblingName,
    this.role,
    this.profession,
    this.maritalStatus,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic userId;
  dynamic siblingName;
  BaseSettings? role;
  BaseSettings? profession;
  BaseSettings? maritalStatus;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory Sibling.fromMap(Map<String, dynamic> json) => Sibling(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        siblingName: json["sibling_name"],
        role: json["role"] == null ? null : BaseSettings.fromJson(json["role"]),
        profession: json["profession"] == null
            ? null
            : BaseSettings.fromJson(json["profession"]),
        maritalStatus: json["marital_status"] == null
            ? null
            : BaseSettings.fromJson(json["marital_status"]),
        status: json["status"],
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
        "sibling_name": siblingName,
        "role": role,
        "profession": profession,
        "marital_status": maritalStatus,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    return 'Sibling{id: $id, userId: $userId, siblingName: $siblingName, role: $role, profession: $profession, maritalStatus: $maritalStatus, status: $status, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class UserCoupling {
  UserCoupling({
    this.id,
    this.userId,
    this.questionId,
    this.answer,
    this.status,
    this.qType,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic userId;
  dynamic questionId;
  dynamic answer;
  dynamic qType;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory UserCoupling.fromMap(Map<String, dynamic> json) => UserCoupling(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        questionId: json["question_id"] == null ? null : json["question_id"],
        answer: json["answer"] == null ? null : json["answer"],
        status: json["status"],
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
        "question_id": questionId == null ? null : questionId,
        "answer": answer == null ? null : answer,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    return 'UserCoupling{id: $id, userId: $userId, questionId: $questionId, answer: $answer, qType: $qType, status: $status, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class UsersBasicDetails {
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
    this.registrationStatus = 0,
    this.couplingCompletedTime,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.purchasePlan,
    this.purchaseTopup,
    this.purchaseCoupling,
  });

  dynamic id;
  dynamic userId;
  dynamic profileApprovedBy;
  dynamic profileRejectComment;
  dynamic profileApprovedAt;
  dynamic paymentPlan;
  dynamic registeredBy;
  dynamic facebookId;
  dynamic googleId;
  dynamic linkedinId;
  dynamic webRegistrationStep;
  dynamic appRegistrationStep;
  int registrationStatus;
  dynamic couplingCompletedTime;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic purchasePlan;
  dynamic purchaseTopup;
  dynamic purchaseCoupling;

  factory UsersBasicDetails.fromMap(Map<String, dynamic> json) =>
      UsersBasicDetails(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        profileApprovedBy: json["profile_approved_by"],
        profileRejectComment: json["profile_reject_comment"],
        profileApprovedAt: json["profile_approved_at"],
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
            ? 0
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
            : List<dynamic>.from(json["purchase_topup"].map((x) => x)),
        purchaseCoupling: json["purchase_coupling"] == null
            ? null
            : List<CurrentCsStatistics>.from(json["purchase_coupling"]
                .map((x) => CurrentCsStatistics.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "profile_approved_by": profileApprovedBy,
        "profile_reject_comment": profileRejectComment,
        "profile_approved_at": profileApprovedAt,
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
            registrationStatus == null ? 0 : registrationStatus,
        "coupling_completed_time": couplingCompletedTime,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "purchase_plan": purchasePlan == null
            ? null
            : List<dynamic>.from(purchasePlan.map((x) => x.toMap())),
        "purchase_topup": purchaseTopup == null
            ? null
            : List<dynamic>.from(purchaseTopup.map((x) => x)),
        "purchase_coupling": purchaseCoupling == null
            ? null
            : List<dynamic>.from(purchaseCoupling.map((x) => x.toMap())),
      };
}

class PurchasePlan {
  PurchasePlan({
    this.id,
    this.userId,
    this.planId,
    this.planName,
    this.amount,
    this.profilesCount,
    this.currentProfilesCount,
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
    this.currentCsStatistics,
    this.csMatch,
    this.verificationBadge,
    this.instantChat,
    this.smsAlerts,
    this.mailAlerts,
    this.icon,
    this.status,
    this.expiredAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic userId;
  dynamic planId;
  dynamic planName;
  dynamic amount;
  dynamic profilesCount;
  dynamic currentProfilesCount;
  dynamic validity;
  dynamic tokenOfLove;
  dynamic searchProfile;
  dynamic viewProfile;
  dynamic sendInterests;
  dynamic messages;
  dynamic contactVisibility;
  dynamic whatsappShare;
  dynamic linkedinValidity;
  dynamic csSummary;
  dynamic csStatistics;
  dynamic currentCsStatistics;
  dynamic csMatch;
  dynamic verificationBadge;
  dynamic instantChat;
  dynamic smsAlerts;
  dynamic mailAlerts;
  dynamic icon;
  dynamic status;
  dynamic expiredAt;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory PurchasePlan.fromMap(Map<String, dynamic> json) => PurchasePlan(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        planId: json["plan_id"] == null ? null : json["plan_id"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        amount: json["amount"] == null ? null : json["amount"],
        profilesCount:
            json["profiles_count"] == null ? null : json["profiles_count"],
        currentProfilesCount: json["current_profiles_count"] == null
            ? null
            : json["current_profiles_count"],
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
        currentCsStatistics: json["current_cs_statistics"] == null
            ? null
            : json["current_cs_statistics"],
        csMatch: json["cs_match"] == null ? null : json["cs_match"],
        verificationBadge: json["verification_badge"] == null
            ? null
            : json["verification_badge"],
        instantChat: json["instant_chat"] == null ? null : json["instant_chat"],
        smsAlerts: json["sms_alerts"] == null ? null : json["sms_alerts"],
        mailAlerts: json["mail_alerts"] == null ? null : json["mail_alerts"],
        icon: json["icon"] == null ? null : json["icon"],
        status: json["status"] == null ? null : json["status"],
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
        "current_profiles_count":
            currentProfilesCount == null ? null : currentProfilesCount,
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
        "current_cs_statistics":
            currentCsStatistics == null ? null : currentCsStatistics,
        "cs_match": csMatch == null ? null : csMatch,
        "verification_badge":
            verificationBadge == null ? null : verificationBadge,
        "instant_chat": instantChat == null ? null : instantChat,
        "sms_alerts": smsAlerts == null ? null : smsAlerts,
        "mail_alerts": mailAlerts == null ? null : mailAlerts,
        "icon": icon == null ? null : icon,
        "status": status == null ? null : status,
        "expired_at": expiredAt == null ? null : expiredAt.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Mom {
  Mom({
    this.id = 0,
    this.userId = 0,
    this.partnerId = 0,
    this.momType = '',
    this.momStatus = '',
    this.message,
    this.deletedAt,
    this.createdAt = '',
    this.updatedAt,
    this.seenAt,
    this.remindAt,
    this.snoozeAt,
    this.momHistory = const [],
  });

  int id;
  int userId;
  int partnerId;
  String? momType;
  String? momStatus;
  dynamic message;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic seenAt;
  dynamic remindAt;
  dynamic snoozeAt;
  List<MomHistory> momHistory;

  factory Mom.fromMap(Map<String, dynamic> json) => Mom(
        id: json["id"] == null ? 0 : json["id"],
        userId: json["user_id"] == null ? 0 : json["user_id"],
        partnerId: json["partner_id"] == null ? 0 : json["partner_id"],
        momType: json["mom_type"] == null ? null : json["mom_type"],
        momStatus: json["mom_status"] == null ? '' : json["mom_status"],
        message: json["message"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? ''
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? ''
            : DateTime.parse(json["updated_at"]),
        seenAt:
            json["seen_at"] == null ? null : DateTime.parse(json["seen_at"]),
        remindAt: json["remind_at"] == null
            ? null
            : DateTime.parse(json["remind_at"]),
        snoozeAt: json["snooze_at"] == null
            ? null
            : DateTime.parse(json["snooze_at"]),
        momHistory: json["mom_history"] == null
            ? []
            : List<MomHistory>.from(
                json["mom_history"].map((x) => MomHistory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? 0 : id,
        "user_id": userId == null ? 0 : userId,
        "partner_id": partnerId == null ? 0 : partnerId,
        "mom_type": momType == null ? '' : momType,
        "mom_status": momStatus == null ? '' : momStatus,
        "message": message,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "seen_at": seenAt == null ? null : seenAt.toIso8601String(),
        "remind_at": remindAt == null ? null : remindAt.toIso8601String(),
        "snooze_at": snoozeAt == null ? null : snoozeAt.toIso8601String(),
        "mom_history": momHistory == null
            ? []
            : List<dynamic>.from(momHistory.map((x) => x.toMap())),
      };
}

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
        id: json["id"] == null ? 0 : json["id"],
        userId: json["user_id"] == null ? 0 : json["user_id"],
        partnerId: json["partner_id"] == null ? 0 : json["partner_id"],
        momId: json["mom_id"] == null ? 0 : json["mom_id"],
        momType: json["mom_type"] == null ? null : json["mom_type"],
        momStatus: json["mom_status"] == null ? null : json["mom_status"],
        message: json["message"] == null ? null : json["message"],
        adminMessage: json["admin_message"],
        userHide: json["user_hide"] == null ? null : json["user_hide"],
        partnerHide: json["partner_hide"] == null ? null : json["partner_hide"],
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
            json["status_position"] == null ? '' : json["status_position"],
        viewAt: json["view_at"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? ''
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? ''
            : DateTime.parse(json["updated_at"]),
        historyText: json["history_text"] == null ? '' : json["history_text"],
        loveGiven: json["love_given"] == null ? '' : json["love_given"],
        loveRecieve: json["love_recieve"] == null ? '' : json["love_recieve"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? 0 : id,
        "user_id": userId == null ? 0 : userId,
        "partner_id": partnerId == null ? 0 : partnerId,
        "mom_id": momId == null ? 0 : momId,
        "mom_type": momType == null ? '' : momType,
        "mom_status": momStatus == null ? '' : momStatus,
        "message": message == null ? '' : message,
        "admin_message": adminMessage,
        "user_hide": userHide == null ? '' : userHide,
        "partner_hide": partnerHide == '' ? null : partnerHide,
        "seen_at": seenAt == null ? '' : seenAt.toIso8601String(),
        "remind_at": remindAt == null ? '' : remindAt.toIso8601String(),
        "snooze_at": snoozeAt == null ? '' : snoozeAt.toIso8601String(),
        "action_at": actionAt == null ? '' : actionAt.toIso8601String(),
        "action_count": actionCount,
        "status_position": statusPosition == null ? '' : statusPosition,
        "view_at": viewAt,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? '' : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? '' : updatedAt.toIso8601String(),
        "history_text": historyText == null ? '' : historyText,
        "love_given": loveGiven == null ? '' : loveGiven,
        "love_recieve": loveRecieve == null ? '' : loveRecieve,
      };
}

class RecomendCause {
  RecomendCause({
    this.id,
    this.value,
    this.count,
    this.checked,
  });

  dynamic id;
  dynamic value;
  dynamic count;
  dynamic checked;

  factory RecomendCause.fromMap(Map<String, dynamic> json) => RecomendCause(
        id: json["id"] == null ? null : json["id"],
        value: json["value"] == null ? null : json["value"],
        count: json["count"] == null ? null : json["count"],
        checked: json["checked"] == null ? null : json["checked"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "value": value == null ? null : value,
        "count": count == null ? null : count,
        "checked": checked == null ? null : checked,
      };
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// To parse this JSON data, do
//
//     final profileModel = profileModelFromMap(jsonString);

// import 'dart:convert';
// import 'dart:io';
// import 'package:coupled/models/base_settings_model.dart';
// import 'package:coupled/models/photo_model.dart';
// import 'package:date_format/date_format.dart';

// ProfileModel profileModelFromMap(String str) =>
//     ProfileModel.fromMap(json.decode(str));

// String profileModelToMap(ProfileModel data) => json.encode(data.toMap());

// class ProfileModel {
//   ProfileModel({
//     this.status = '',
//     required this.response,
//     this.code = 0,
//   });

//   String status;
//   ProfileResponse response;
//   int code;

//   factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
//         status: json["status"] == null ? null : json["status"],
//         response: json["response"] == null
//             ? ProfileResponse.fromMap(json[""])
//             : ProfileResponse.fromMap(json["response"]),
//         code: json["code"] == null ? null : json["code"],
//       );

//   Map<String, dynamic> toMap() => {
//         "status": status == null ? null : status,
//         "response": response == null ? null : response.toMap(),
//         "code": code == null ? null : code,
//       };
// }

// class ProfileResponse {
//   ProfileResponse({
//     this.id=0,
//     this.name='',
//     this.lastName='',
//     this.notification=0,
//     this.membershipCode='',
//     this.gender = 'male',
//     this.profilePic,
//     this.emailVerification=0,
//     this.mobileVerification=0,
//     this.isActive=0,
//     this.edited=0,
//     this.online=0,
//      this.lastActive,
//     this.hideAt,
//     this.recommendGiven=0,
//     this.recommendReceived=0,
//     this.userEmail='',
//     this.userPhone='',
//     this.planName='',
//     this.planAmount='',
//     this.planValidity='',
//     this.totalCredits=0,
//     this.pendingCredits=0,
//     this.usedCredits=0,
//     this.planExpiry,
//     this.planRechargedDate,
//     this.recommend=false,
//     this.membership,
//     this.score,
//     this.recomendCause,
//     this.recomendCauseCount,
//     this.freeCoupling,
//     this.passwordStatus,
//     this.address,
//     this.educationJob,
//     this.family,
//     this.info,
//     this.officialDocuments,
//     this.photos,
//     this.dp,
//     this.mom ,
//     this.reportMe,
//     this.photoModel,
//     this.chatCount,
//     this.blockMe,
//     this.shortlistByMe,
//     this.shortlistMe,
//     this.preference,
//     this.usersBasicDetails,
//     this.siblings,
//     this.photoData,
//     this.userCoupling,
//     this.currentCsStatistics,
//   });

//   int id = 0;
//   String name = '';
//   String lastName = '';
//   int notification = 0;
//   String membershipCode = '';
//   String gender = '';
//   dynamic profilePic;
//   int emailVerification = 0;
//   int mobileVerification = 0;
//   int isActive = 0;
//   int edited = 0;
//   int online = 0;
//   Mom shortlistByMe = Mom();
//   Mom shortlistMe = Mom();
//   DateTime lastActive = DateTime.parse(DateTime.now().toString());
//   dynamic hideAt;
//   int recommendGiven = 0;
//   int recommendReceived = 0;
//   String userEmail = '';
//   String userPhone = '';
//   String planName = '';
//   String planAmount = '';
//   String planValidity = '';
//   int totalCredits = 0;
//   int pendingCredits = 0;
//   int usedCredits = 0;
//   DateTime planExpiry=DateTime.parse(DateTime.now().toString());
//   DateTime planRechargedDate=DateTime.parse(DateTime.now().toString());
//   bool recommend=false;
//   Membership membership=Membership();
//   PhotoModel photoModel = PhotoModel();
//   int score=0;
//   int recomendCauseCount=0;
//   List<RecomendCause> recomendCause=[];
//   List<FreeCoupling> freeCoupling=[];
//   bool passwordStatus=false;
//   Address address=Address();
//   EducationJob educationJob=EducationJob();
//   Family family=Family();
//   Info info=Info();
//   OfficialDocuments officialDocuments=OfficialDocuments();
//   List<Dp> photos=[];
//   Dp dp=Dp();
//   int chatCount=0;
//   Mom mom=Mom();
//   Mom blockMe=Mom();
//   Mom reportMe=Mom();
//   Preference preference=Preference();
//   UsersBasicDetails usersBasicDetails=UsersBasicDetails();
//   List<Sibling> siblings=[];
//   List<UserCoupling> userCoupling=[];
//   CurrentCsStatistics currentCsStatistics=CurrentCsStatistics();
//   List<PhotoModel> photoData=[];
//   File officeId=File('');

//   factory ProfileResponse.fromMap(Map<String, dynamic> json) => ProfileResponse(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//         lastName: json["last_name"] == null ? null : json["last_name"],
//         mom: json["mom"] == null ? Mom.fromMap({}) : Mom.fromMap(json["mom"]),
//         reportMe: json["mom"] == null ?  Mom.fromMap({}) : Mom.fromMap(json["mom"]),
//         blockMe: json["mom"] == null ? Mom.fromMap({}) : Mom.fromMap(json["mom"]),
//         chatCount: json["chat_count"] == null ? null : json["chat_count"],
//         notification:
//             json["notification"] == null ? null : json["notification"],
//         membershipCode:
//             json["membership_code"] == null ? null : json["membership_code"],
//         gender: json["gender"] == null ? 'male' : json["gender"],
//         profilePic: json["profile_pic"],
//         emailVerification: json["email_verification"] == null
//             ? null
//             : json["email_verification"],
//         mobileVerification: json["mobile_verification"] == null
//             ? null
//             : json["mobile_verification"],
//         isActive: json["is_active"] == null ? null : json["is_active"],
//         edited: json["edited"] == null ? null : json["edited"],
//         online: json["online"] == null ? null : json["online"],
//         lastActive: json["last_active"] == null
//             ? DateTime.parse(DateTime.now().toString())
//             : DateTime.parse(json["last_active"]),
//         hideAt: json["hide_at"],
//         shortlistByMe: json["shortlist_by_me"] == null
//             ? Mom.fromMap({})
//             : Mom.fromMap(json["shortlist_by_me"]),
//         shortlistMe: json["shortlist_me"] == null
//             ? Mom.fromMap({})
//             : Mom.fromMap(json["shortlist_me"]),
//         recommendGiven:
//             json["recommend_given"] == null ? null : json["recommend_given"],
//         recommendReceived: json["recommend_received"] == null
//             ? null
//             : json["recommend_received"],
//         freeCoupling: json["free_coupling"] == null
//             ? []
//             : List<FreeCoupling>.from(
//                 json["free_coupling"].map((x) => FreeCoupling.fromMap(x))),
//         userEmail: json["user_email"] == null ? null : json["user_email"],
//         userPhone: json["user_phone"] == null ? null : json["user_phone"],
//         planName: json["plan_name"] == null ? null : json["plan_name"],
//         planAmount: json["plan_amount"] == null ? null : json["plan_amount"],
//         planValidity:
//             json["plan_validity"] == null ? null : json["plan_validity"],
//         totalCredits:
//             json["total_credits"] == null ? null : json["total_credits"],
//         pendingCredits:
//             json["pending_credits"] == null ? null : json["pending_credits"],
//         usedCredits: json["used_credits"] == null ? null : json["used_credits"],
//         planExpiry: json["plan_expiry"] == null
//             ? DateTime.parse(DateTime.now().toString())
//             : DateTime.parse(json["plan_expiry"]),
//         planRechargedDate: json["plan_recharged_date"] == null
//             ? DateTime.parse(DateTime.now().toString())
//             : DateTime.parse(json["plan_recharged_date"]),
//         recommend: json["recommend"] == null ? null : json["recommend"],
//         membership: json["membership"] == null
//             ? Membership.fromMap({})
//             : Membership.fromMap(json["membership"]),
//         score: json["score"] == null ? null : json["score"],
//         recomendCauseCount: json["recomend_cause_count"] == null
//             ? null
//             : json["recomend_cause_count"],
//         recomendCause: json["recomend_cause"] == null
//             ? []
//             : List<RecomendCause>.from(
//                 json["recomend_cause"].map((x) => RecomendCause.fromMap(x))),
//         passwordStatus:
//             json["password_status"] == null ? null : json["password_status"],
//         address:
//             json["address"] == null ? Address.fromMap({}) : Address.fromMap(json["address"]),
//         educationJob: json["education_job"] == null
//             ? EducationJob.fromMap({})
//             : EducationJob.fromMap(json["education_job"]),
//         family: json["family"] == null ? Family.fromMap({}) : Family.fromMap(json["family"]),
//         info: json["info"] == null ? Info.fromMap({}) : Info.fromMap(json["info"]),
//         officialDocuments: json["official_documents"] == null
//             ? OfficialDocuments.fromMap({})
//             : OfficialDocuments.fromMap(json["official_documents"]),
//         photos: json["photos"] == null
//             ? []
//             : List<Dp>.from(json["photos"].map((x) => Dp.fromMap(x))),
//         dp: json["dp"] == null ? Dp.fromMap({}), : Dp.fromMap(json["dp"]),
//         preference: json["preference"] == null
//             ? Preference.fromMap({})
//             : Preference.fromMap(json["preference"]),
//         usersBasicDetails: json["users_basic_details"] == null
//             ? UsersBasicDetails.fromMap({})
//             : UsersBasicDetails.fromMap(json["users_basic_details"]),
//         siblings: json["siblings"] == null
//             ? []
//             : List<Sibling>.from(
//                 json["siblings"].map((x) => Sibling.fromMap(x))),
//         userCoupling: json["user_coupling"] == null
//             ? []
//             : List<UserCoupling>.from(
//                 json["user_coupling"].map((x) => UserCoupling.fromMap(x))),
//         currentCsStatistics: json["current_cs_statistics"] == null
//             ? CurrentCsStatistics.fromMap({})
//             : CurrentCsStatistics.fromMap(json["current_cs_statistics"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "name": name == null ? null : name,
//         "last_name": lastName == null ? null : lastName,
//         "notification": notification == null ? null : notification,
//         "membership_code": membershipCode == null ? null : membershipCode,
//         "gender": gender == null ? null : gender,
//         "profile_pic": profilePic,
//         "email_verification":
//             emailVerification == null ? null : emailVerification,
//         "mobile_verification":
//             mobileVerification == null ? null : mobileVerification,
//         "is_active": isActive == null ? null : isActive,
//         "edited": edited == null ? null : edited,
//         "online": online == null ? null : online,
//         "last_active": lastActive,
//         "hide_at": hideAt,
//         "recommend_given": recommendGiven == null ? null : recommendGiven,
//         "recommend_received":
//             recommendReceived == null ? null : recommendReceived,
//         "user_email": userEmail == null ? null : userEmail,
//         "user_phone": userPhone == null ? null : userPhone,
//         "plan_name": planName == null ? null : planName,
//         "plan_amount": planAmount == null ? null : planAmount,
//         "plan_validity": planValidity == null ? null : planValidity,
//         "total_credits": totalCredits == null ? null : totalCredits,
//         "pending_credits": pendingCredits == null ? null : pendingCredits,
//         "used_credits": usedCredits == null ? null : usedCredits,
//         "plan_expiry": planExpiry == null ? null : planExpiry.toIso8601String(),
//         "plan_recharged_date": planRechargedDate == null
//             ? null
//             : planRechargedDate.toIso8601String(),
//         "recommend": recommend == null ? null : recommend,
//         "membership": membership == null ? null : membership.toMap(),
//         "score": score == null ? null : score,
//         "recomend_cause_count":
//             recomendCauseCount == null ? null : recomendCauseCount,
//         "password_status": passwordStatus == null ? null : passwordStatus,
//         "address": address == null ? null : address.toMap(),
//         "education_job": educationJob == null ? null : educationJob.toMap(),
//         "family": family == null ? null : family.toMap(),
//         "info": info == null ? null : info.toMap(),
//         "official_documents":
//             officialDocuments == null ? null : officialDocuments.toMap(),
//         "photos": photos == null
//             ? null
//             : List<dynamic>.from(photos.map((x) => x.toMap())),
//         "dp": dp == null ? null : dp.toMap(),
//         "preference": preference == null ? null : preference.toMap(),
//         "users_basic_details":
//             usersBasicDetails == null ? null : usersBasicDetails.toMap(),
//         "siblings": siblings == null
//             ? null
//             : List<dynamic>.from(siblings.map((x) => x.toMap())),
//         "user_coupling": userCoupling == null
//             ? null
//             : List<dynamic>.from(userCoupling.map((x) => x.toMap())),
//         "current_cs_statistics":
//             currentCsStatistics == null ? null : currentCsStatistics.toMap(),
//       };
// }

// class FreeCoupling {
//   FreeCoupling({
//     this.id,
//     this.couplingType,
//     this.type,
//     this.question,
//     this.questionOrder,
//     this.parent,
//     this.status,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.score,
//     this.message,
//   });

//   int id;
//   String couplingType;
//   String type;
//   String question;
//   int questionOrder;
//   int parent;
//   dynamic status;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   double score;
//   String message;

//   factory FreeCoupling.fromMap(Map<String, dynamic> json) => FreeCoupling(
//         id: json["id"] == null ? null : json["id"],
//         couplingType:
//             json["coupling_type"] == null ? null : json["coupling_type"],
//         type: json["type"] == null ? null : json["type"],
//         question: json["question"] == null ? null : json["question"],
//         questionOrder:
//             json["question_order"] == null ? null : json["question_order"],
//         parent: json["parent"] == null ? null : json["parent"],
//         status: json["status"] == null ? null : json["status"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         score: json["score"] == null ? null : json["score"].toDouble(),
//         message: json["message"] == null ? null : json["message"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "coupling_type": couplingType == null ? null : couplingType,
//         "type": type == null ? null : type,
//         "question": question == null ? null : question,
//         "question_order": questionOrder == null ? null : questionOrder,
//         "parent": parent == null ? null : parent,
//         "status": status == null ? null : status,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//         "score": score == null ? null : score,
//         "message": message == null ? null : message,
//       };
// }

// class Address {
//   Address({
//     this.id,
//     this.userId,
//     this.addressType,
//     this.countryCode,
//     this.country,
//     this.state,
//     this.city,
//     this.locationId,
//     this.address,
//     this.pincode,
//     this.presentAddress,
//     this.tolStatus,
//     this.status,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   int userId;
//   dynamic addressType;
//   String countryCode;
//   String country;
//   String state;
//   String city;
//   int locationId;
//   String address;
//   int pincode;
//   int presentAddress;
//   int tolStatus;
//   dynamic status;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Address.fromMap(Map<String, dynamic> json) => Address(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         addressType: json["address_type"],
//         countryCode: json["country_code"] == null ? null : json["country_code"],
//         country: json["country"] == null ? null : json["country"],
//         state: json["state"] == null ? null : json["state"],
//         city: json["city"] == null ? null : json["city"],
//         locationId: json["location_id"] == null ? null : json["location_id"],
//         address: json["address"] == null ? null : json["address"],
//         pincode: json["pincode"] == null ? null : json["pincode"],
//         presentAddress:
//             json["present_address"] == null ? null : json["present_address"],
//         tolStatus: json["tol_status"] == null ? null : json["tol_status"],
//         status: json["status"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "address_type": addressType,
//         "country_code": countryCode == null ? null : countryCode,
//         "country": country == null ? null : country,
//         "state": state == null ? null : state,
//         "city": city == null ? null : city,
//         "location_id": locationId == null ? null : locationId,
//         "address": address == null ? null : address,
//         "pincode": pincode == null ? null : pincode,
//         "present_address": presentAddress == null ? null : presentAddress,
//         "tol_status": tolStatus == null ? null : tolStatus,
//         "status": status,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };

//   @override
//   String toString() {
//     return 'Address{id: $id, userId: $userId, addressType: $addressType, countryCode: $countryCode, country: $country, state: $state, city: $city, locationId: $locationId, address: $address, pincode: $pincode, presentAddress: $presentAddress, tolStatus: $tolStatus, status: $status, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// class CurrentCsStatistics {
//   CurrentCsStatistics({
//     this.id,
//     this.userId,
//     this.couplingScoreId,
//     this.activationFee,
//     this.validity,
//     this.couplingScorePlanOption,
//     this.status,
//     this.activeAt,
//     this.expiredAt,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   int userId;
//   int couplingScoreId;
//   int activationFee;
//   int validity;
//   dynamic couplingScorePlanOption;
//   String status;
//   DateTime activeAt;
//   DateTime expiredAt;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory CurrentCsStatistics.fromMap(Map<String, dynamic> json) =>
//       CurrentCsStatistics(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         couplingScoreId: json["coupling_score_id"] == null
//             ? null
//             : json["coupling_score_id"],
//         activationFee:
//             json["activation_fee"] == null ? null : json["activation_fee"],
//         validity: json["validity"] == null ? null : json["validity"],
//         couplingScorePlanOption: json["coupling_score_plan_option"],
//         status: json["status"] == null ? null : json["status"],
//         activeAt: json["active_at"] == null
//             ? null
//             : DateTime.parse(json["active_at"]),
//         expiredAt: json["expired_at"] == null
//             ? null
//             : DateTime.parse(json["expired_at"]),
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "coupling_score_id": couplingScoreId == null ? null : couplingScoreId,
//         "activation_fee": activationFee == null ? null : activationFee,
//         "validity": validity == null ? null : validity,
//         "coupling_score_plan_option": couplingScorePlanOption,
//         "status": status == null ? null : status,
//         "active_at": activeAt == null ? null : activeAt.toIso8601String(),
//         "expired_at": expiredAt == null ? null : expiredAt.toIso8601String(),
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };
// }

// class Dp {
//   Dp({
//     this.id,
//     this.userId,
//     this.photoName,
//     this.fromType,
//     this.imageType,
//     this.status,
//     this.rejectStatus,
//     this.approvedBy,
//     this.photoApprovedAt,
//     this.comments,
//     this.trash,
//     this.imageTaken,
//     this.dpStatus,
//     this.sortOrder,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.userDetail,
//   });

//   int id;
//   int userId;
//   String photoName;
//   String fromType;
//   BaseSettings imageType;
//   int status;
//   int rejectStatus;
//   dynamic approvedBy;
//   dynamic photoApprovedAt;
//   dynamic comments;
//   int trash;
//   BaseSettings imageTaken;
//   int dpStatus;
//   int sortOrder;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   UserDetail userDetail;

//   factory Dp.fromMap(Map<String, dynamic> json) => Dp(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         photoName: json["photo_names"] == null ? null : json["photo_names"],
//         fromType: json["from_type"] == null ? null : json["from_type"],
//         imageType: json["image_type"] == null
//             ? null
//             : BaseSettings.fromJson(json["image_type"]),
//         status: json["status"] == null ? null : json["status"],
//         rejectStatus:
//             json["reject_status"] == null ? null : json["reject_status"],
//         approvedBy: json["approved_by"],
//         photoApprovedAt: json["photo_approved_at"],
//         comments: json["comments"],
//         trash: json["trash"] == null ? null : json["trash"],
//         imageTaken: json["image_taken"] == null
//             ? null
//             : BaseSettings.fromJson(json["image_taken"]),
//         dpStatus: json["dp_status"] == null ? null : json["dp_status"],
//         sortOrder: json["sort_order"] == null ? null : json["sort_order"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         userDetail: json["user_detail"] == null
//             ? null
//             : UserDetail.fromMap(json["user_detail"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "photo_names": photoName == null ? null : photoName,
//         "from_type": fromType == null ? null : fromType,
//         "image_type": imageType == null ? null : imageType.toJson(),
//         "status": status == null ? null : status,
//         "reject_status": rejectStatus == null ? null : rejectStatus,
//         "approved_by": approvedBy,
//         "photo_approved_at": photoApprovedAt,
//         "comments": comments,
//         "trash": trash == null ? null : trash,
//         "image_taken": imageTaken == null ? null : imageTaken.toJson(),
//         "dp_status": dpStatus == null ? null : dpStatus,
//         "sort_order": sortOrder == null ? null : sortOrder,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//         "user_detail": userDetail == null ? null : userDetail.toMap(),
//       };
// }

// class UserDetail {
//   UserDetail({
//     this.id,
//     this.name,
//     this.lastName,
//     this.notification,
//     this.membershipCode,
//     this.gender,
//     this.profilePic,
//     this.emailVerification,
//     this.mobileVerification,
//     this.isActive,
//     this.edited,
//     this.online,
//     this.lastActive,
//     this.hideAt,
//     this.recommend,
//     this.membership,
//     this.score,
//     this.recomendCauseCount,
//     this.passwordStatus,
//   });

//   int id;
//   String name;
//   String lastName;
//   int notification;
//   String membershipCode;
//   String gender;
//   dynamic profilePic;
//   int emailVerification;
//   int mobileVerification;
//   int isActive;
//   int edited;
//   int online;
//   dynamic lastActive;
//   dynamic hideAt;
//   bool recommend;
//   Membership membership;
//   int score;
//   int recomendCauseCount;
//   bool passwordStatus;

//   factory UserDetail.fromMap(Map<String, dynamic> json) => UserDetail(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//         lastName: json["last_name"] == null ? null : json["last_name"],
//         notification:
//             json["notification"] == null ? null : json["notification"],
//         membershipCode:
//             json["membership_code"] == null ? null : json["membership_code"],
//         gender: json["gender"] == null ? null : json["gender"],
//         profilePic: json["profile_pic"],
//         emailVerification: json["email_verification"] == null
//             ? null
//             : json["email_verification"],
//         mobileVerification: json["mobile_verification"] == null
//             ? null
//             : json["mobile_verification"],
//         isActive: json["is_active"] == null ? null : json["is_active"],
//         edited: json["edited"] == null ? null : json["edited"],
//         online: json["online"] == null ? null : json["online"],
//         lastActive: json["last_active"],
//         hideAt: json["hide_at"],
//         recommend: json["recommend"] == null ? null : json["recommend"],
//         membership: json["membership"] == null
//             ? null
//             : Membership.fromMap(json["membership"]),
//         score: json["score"] == null ? null : json["score"],
//         recomendCauseCount: json["recomend_cause_count"] == null
//             ? null
//             : json["recomend_cause_count"],
//         passwordStatus:
//             json["password_status"] == null ? null : json["password_status"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "name": name == null ? null : name,
//         "last_name": lastName == null ? null : lastName,
//         "notification": notification == null ? null : notification,
//         "membership_code": membershipCode == null ? null : membershipCode,
//         "gender": gender == null ? null : gender,
//         "profile_pic": profilePic,
//         "email_verification":
//             emailVerification == null ? null : emailVerification,
//         "mobile_verification":
//             mobileVerification == null ? null : mobileVerification,
//         "is_active": isActive == null ? null : isActive,
//         "edited": edited == null ? null : edited,
//         "online": online == null ? null : online,
//         "last_active": lastActive,
//         "hide_at": hideAt,
//         "recommend": recommend == null ? null : recommend,
//         "membership": membership == null ? null : membership.toMap(),
//         "score": score == null ? null : score,
//         "recomend_cause_count":
//             recomendCauseCount == null ? null : recomendCauseCount,
//         "password_status": passwordStatus == null ? null : passwordStatus,
//       };
// }

// class Membership {
//   Membership({
//     this.paidMember,
//     this.planName,
//     this.chat,
//     this.statistics,
//     this.share,
//     this.verificationBadge,
//     this.expiredAt,
//   });

//   bool paidMember;
//   String planName;
//   int chat;
//   int statistics;
//   int share;
//   int verificationBadge;
//   DateTime expiredAt;

//   factory Membership.fromMap(Map<String, dynamic> json) => Membership(
//         paidMember: json["paid_member"] == null ? null : json["paid_member"],
//         planName: json["plan_name"] == null ? null : json["plan_name"],
//         chat: json["chat"] == null ? null : json["chat"],
//         statistics: json["statistics"] == null ? null : json["statistics"],
//         share: json["share"] == null ? null : json["share"],
//         verificationBadge: json["verification_badge"] == null
//             ? null
//             : json["verification_badge"],
//         expiredAt: json["expired_at"] == null
//             ? null
//             : DateTime.parse(json["expired_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "paid_member": paidMember == null ? null : paidMember,
//         "plan_name": planName == null ? null : planName,
//         "chat": chat == null ? null : chat,
//         "statistics": statistics == null ? null : statistics,
//         "share": share == null ? null : share,
//         "verification_badge":
//             verificationBadge == null ? null : verificationBadge,
//         "expired_at": expiredAt == null ? null : expiredAt.toIso8601String(),
//       };
// }

// class EducationJob {
//   EducationJob({
//     this.id,
//     this.userId,
//     this.linkedInStatus,
//     this.jobStatus,
//     this.companyName = '',
//     this.industry,
//     this.profession,
//     this.experience,
//     this.highestEducation,
//     this.educationBranch,
//     this.incomeRange,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   int userId;
//   dynamic linkedInStatus;
//   int jobStatus;
//   dynamic companyName;
//   BaseSettings industry;
//   BaseSettings profession;
//   BaseSettings experience;
//   BaseSettings highestEducation;
//   BaseSettings educationBranch;
//   BaseSettings incomeRange;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory EducationJob.fromMap(Map<String, dynamic> json) => EducationJob(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         linkedInStatus: json["linked_in_status"],
//         jobStatus: json["job_status"] == null ? null : json["job_status"],
//         companyName: json["company_name"] == null ? null : json["company_name"],
//         industry: json["industry"] == null
//             ? null
//             : BaseSettings.fromJson(json["industry"]),
//         profession: json["profession"] == null
//             ? null
//             : BaseSettings.fromJson(json["profession"]),
//         experience: json["experience"] == null
//             ? null
//             : BaseSettings.fromJson(json["experience"]),
//         highestEducation: json["highest_education"] == null
//             ? null
//             : BaseSettings.fromJson(json["highest_education"]),
//         educationBranch: json["education_branch"] == null
//             ? null
//             : BaseSettings.fromJson(json["education_branch"]),
//         incomeRange: json["income_range"] == null
//             ? null
//             : BaseSettings.fromJson(json["income_range"]),
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "linked_in_status": linkedInStatus,
//         "job_status": jobStatus == null ? null : jobStatus,
//         "company_name": companyName,
//         "industry": industry == null ? null : industry.toJson(),
//         "profession": profession,
//         "experience": experience == null ? null : experience.toJson(),
//         "highest_education":
//             highestEducation == null ? null : highestEducation.toJson(),
//         "education_branch":
//             educationBranch == null ? null : educationBranch.toJson(),
//         "income_range": incomeRange == null ? null : incomeRange.toJson(),
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };
// }

// class Family {
//   Family({
//     this.id,
//     this.userId,
//     this.fatherName,
//     this.fatherOccupationStatus,
//     this.motherName,
//     this.motherOccupationStatus,
//     this.familyType,
//     this.familyValues,
//     this.religion,
//     this.cast,
//     this.subcast,
//     this.gothram,
//     this.countryCode,
//     this.country,
//     this.state,
//     this.city,
//     this.locationId,
//     this.status,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   int userId;
//   dynamic fatherName;
//   BaseSettings fatherOccupationStatus;
//   dynamic motherName;
//   BaseSettings motherOccupationStatus;
//   BaseSettings familyType;
//   BaseSettings familyValues;
//   BaseSettings religion;
//   BaseSettings cast;
//   BaseSettings subcast;
//   BaseSettings gothram;
//   String countryCode;
//   String country;
//   String state;
//   String city;
//   int locationId;
//   dynamic status;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Family.fromMap(Map<String, dynamic> json) => Family(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         fatherName: json["father_name"],
//         fatherOccupationStatus: json["father_occupation_status"] == null
//             ? null
//             : BaseSettings.fromJson(json["father_occupation_status"]),
//         motherName: json["mother_name"],
//         motherOccupationStatus: json["mother_occupation_status"] == null
//             ? null
//             : BaseSettings.fromJson(json["mother_occupation_status"]),
//         familyType: json["family_type"] == null
//             ? null
//             : BaseSettings.fromJson(json["family_type"]),
//         familyValues: json["family_values"] == null
//             ? null
//             : BaseSettings.fromJson(json["family_values"]),
//         religion: json["religion"] == null
//             ? null
//             : BaseSettings.fromJson(json["religion"]),
//         cast: json["cast"] == null ? null : BaseSettings.fromJson(json["cast"]),
//         subcast: json["subcast"] == null
//             ? null
//             : BaseSettings.fromJson(json["subcast"]),
//         gothram: json["gothram"] == null
//             ? null
//             : BaseSettings.fromJson(json["gothram"]),
//         countryCode: json["country_code"] == null ? null : json["country_code"],
//         country: json["country"] == null ? null : json["country"],
//         state: json["state"] == null ? null : json["state"],
//         city: json["city"] == null ? null : json["city"],
//         locationId: json["location_id"] == null ? null : json["location_id"],
//         status: json["status"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "father_name": fatherName,
//         "father_occupation_status": fatherOccupationStatus,
//         "mother_name": motherName,
//         "mother_occupation_status": motherOccupationStatus,
//         "family_type": familyType,
//         "family_values": familyValues,
//         "religion": religion == null ? null : religion.toJson(),
//         "cast": cast,
//         "subcast": subcast,
//         "gothram": gothram,
//         "country_code": countryCode == null ? null : countryCode,
//         "country": country == null ? null : country,
//         "state": state == null ? null : state,
//         "city": city == null ? null : city,
//         "location_id": locationId == null ? null : locationId,
//         "status": status,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };
// }

// class Info {
//   Info({
//     this.id,
//     this.userId,
//     this.dob,
//     this.dobStatus,
//     this.height,
//     this.weight,
//     this.bodyType,
//     this.complexion,
//     this.specialCase = 0,
//     this.specialCaseType,
//     this.specialCaseNotify = 0,
//     this.adminApprovalStatus,
//     this.countryCode,
//     this.country,
//     this.state,
//     this.city,
//     this.locationId,
//     this.maritalStatus,
//     this.numberOfChildren,
//     this.childLivingStatus,
//     this.bornPlace,
//     this.bornTime,
//     this.aboutSelf,
//     this.aboutPartner,
//     this.completedStatus,
//     this.completedIn,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   int userId;
//   DateTime dob;
//   int dobStatus;
//   int height;
//   int weight;
//   BaseSettings bodyType;
//   BaseSettings complexion;
//   int specialCase;
//   BaseSettings specialCaseType;
//   int specialCaseNotify;
//   int adminApprovalStatus;
//   String countryCode;
//   String country;
//   String state;
//   String city;
//   int locationId;
//   BaseSettings maritalStatus;
//   int numberOfChildren;
//   BaseSettings childLivingStatus;
//   dynamic bornPlace;
//   String bornTime;
//   String aboutSelf;
//   String aboutPartner;
//   dynamic completedStatus;
//   dynamic completedIn;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Info.fromMap(Map<String, dynamic> json) => Info(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         dobStatus: json["dob_status"] == null ? null : json["dob_status"],
//         height: json["height"] == null ? null : json["height"],
//         weight: json["weight"] == null ? null : json["weight"],
//         bodyType: json["body_type"] == null
//             ? null
//             : BaseSettings.fromJson(json["body_type"]),
//         complexion: json["complexion"] == null
//             ? null
//             : BaseSettings.fromJson(json["complexion"]),
//         specialCase: json["special_case"] == null ? 0 : json["special_case"],
//         specialCaseType: json["special_case_type"] == null
//             ? null
//             : BaseSettings.fromJson(json["special_case_type"]),
//         specialCaseNotify: json["special_case_notify"] == null
//             ? 0
//             : json["special_case_notify"],
//         adminApprovalStatus: json["admin_approval_status"] == null
//             ? null
//             : json["admin_approval_status"],
//         countryCode: json["country_code"] == null ? null : json["country_code"],
//         country: json["country"] == null ? null : json["country"],
//         state: json["state"] == null ? null : json["state"],
//         city: json["city"] == null ? null : json["city"],
//         locationId: json["location_id"] == null ? null : json["location_id"],
//         maritalStatus: json["marital_status"] == null
//             ? null
//             : BaseSettings.fromJson(json["marital_status"]),
//         numberOfChildren: json["number_of_children"] == null
//             ? null
//             : json["number_of_children"],
//         childLivingStatus: json["child_living_status"] == null
//             ? null
//             : BaseSettings.fromJson(json["child_living_status"]),
//         bornPlace: json["born_place"] == null ? null : json["born_place"],
//         bornTime: json["born_time"] == null ? null : json["born_time"],
//         aboutSelf: json["about_self"] == null ? null : json["about_self"],
//         aboutPartner:
//             json["about_partner"] == null ? null : json["about_partner"],
//         completedStatus: json["completed_status"],
//         completedIn: json["completed_in"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "dob": dob == null
//             ? null
//             : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
//         "dob_status": dobStatus == null ? null : dobStatus,
//         "height": height == null ? null : height,
//         "weight": weight == null ? null : weight,
//         "body_type": bodyType == null ? null : bodyType.toJson(),
//         "complexion": complexion == null ? null : complexion.toJson(),
//         "special_case": specialCase == null ? null : specialCase,
//         "special_case_type":
//             specialCaseType == null ? null : specialCaseType.toJson(),
//         "special_case_notify":
//             specialCaseNotify == null ? null : specialCaseNotify,
//         "admin_approval_status":
//             adminApprovalStatus == null ? null : adminApprovalStatus,
//         "country_code": countryCode == null ? null : countryCode,
//         "country": country == null ? null : country,
//         "state": state == null ? null : state,
//         "city": city == null ? null : city,
//         "location_id": locationId == null ? null : locationId,
//         "marital_status": maritalStatus == null ? null : maritalStatus.toJson(),
//         "number_of_children":
//             numberOfChildren == null ? null : numberOfChildren,
//         "child_living_status":
//             childLivingStatus == null ? null : childLivingStatus.toJson(),
//         "born_place": bornPlace,
//         "born_time": bornTime == null ? null : bornTime,
//         "about_self": aboutSelf == null ? null : aboutSelf,
//         "about_partner": aboutPartner == null ? null : aboutPartner,
//         "completed_status": completedStatus,
//         "completed_in": completedIn,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };
// }

// class OfficialDocuments {
//   OfficialDocuments({
//     this.id,
//     this.userId,
//     this.govtIdType,
//     this.govtIdFront,
//     this.govtIdBack,
//     this.govtIdStatus,
//     this.govtIdApprovedBy,
//     this.govtIdRejectComments,
//     this.officeIdRejectStatus,
//     this.govIdRejectStatus,
//     this.govtIdApprovedAt,
//     this.officeId,
//     this.officeIdStatus,
//     this.officeIdApprovedBy,
//     this.officeIdRejectComments,
//     this.officeIdApprovedAt,
//     this.linkedinId,
//     this.linkedinIdStatus,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   int userId;
//   int govtIdType;
//   dynamic govtIdFront;
//   dynamic govtIdBack;
//   dynamic govtIdStatus;
//   dynamic govtIdApprovedBy;
//   dynamic govtIdRejectComments;
//   int officeIdRejectStatus;
//   int govIdRejectStatus;
//   dynamic govtIdApprovedAt;
//   dynamic officeId;
//   int officeIdStatus;
//   dynamic officeIdApprovedBy;
//   dynamic officeIdRejectComments;
//   dynamic officeIdApprovedAt;
//   dynamic linkedinId;
//   int linkedinIdStatus;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory OfficialDocuments.fromMap(Map<String, dynamic> json) =>
//       OfficialDocuments(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         govtIdType: json["govt_id_type"] == null ? null : json["govt_id_type"],
//         govtIdFront: json["govt_id_front"],
//         govtIdBack: json["govt_id_back"],
//         govtIdStatus: json["govt_id_status"],
//         govtIdApprovedBy: json["govt_id_approved_by"],
//         govtIdRejectComments: json["govt_id_reject_comments"],
//         officeIdRejectStatus: json["office_id_reject_status"] == null
//             ? null
//             : json["office_id_reject_status"],
//         govIdRejectStatus: json["gov_id_reject_status"] == null
//             ? null
//             : json["gov_id_reject_status"],
//         govtIdApprovedAt: json["govt_id_approved_at"],
//         officeId: json["office_id"] == null ? null : json["office_id"],
//         officeIdStatus:
//             json["office_id_status"] == null ? null : json["office_id_status"],
//         officeIdApprovedBy: json["office_id_approved_by"],
//         officeIdRejectComments: json["office_id_reject_comments"],
//         officeIdApprovedAt: json["office_id_approved_at"],
//         linkedinId: json["linkedin_id"],
//         linkedinIdStatus: json["linkedin_id_status"] == null
//             ? null
//             : json["linkedin_id_status"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "govt_id_type": govtIdType == null ? null : govtIdType,
//         "govt_id_front": govtIdFront,
//         "govt_id_back": govtIdBack,
//         "govt_id_status": govtIdStatus,
//         "govt_id_approved_by": govtIdApprovedBy,
//         "govt_id_reject_comments": govtIdRejectComments,
//         "office_id_reject_status":
//             officeIdRejectStatus == null ? null : officeIdRejectStatus,
//         "gov_id_reject_status":
//             govIdRejectStatus == null ? null : govIdRejectStatus,
//         "govt_id_approved_at": govtIdApprovedAt,
//         "office_id": officeId,
//         "office_id_status": officeIdStatus == null ? null : officeIdStatus,
//         "office_id_approved_by": officeIdApprovedBy,
//         "office_id_reject_comments": officeIdRejectComments,
//         "office_id_approved_at": officeIdApprovedAt,
//         "linkedin_id": linkedinId,
//         "linkedin_id_status":
//             linkedinIdStatus == null ? null : linkedinIdStatus,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };

//   @override
//   String toString() {
//     return 'OfficialDocuments{id: $id, userId: $userId, govtIdType: $govtIdType, govtIdFront: $govtIdFront, govtIdBack: $govtIdBack, govtIdStatus: $govtIdStatus, govtIdApprovedBy: $govtIdApprovedBy, govtIdRejectComments: $govtIdRejectComments, officeIdRejectStatus: $officeIdRejectStatus, govIdRejectStatus: $govIdRejectStatus, govtIdApprovedAt: $govtIdApprovedAt, officeId: $officeId, officeIdStatus: $officeIdStatus, officeIdApprovedBy: $officeIdApprovedBy, officeIdRejectComments: $officeIdRejectComments, officeIdApprovedAt: $officeIdApprovedAt, linkedinId: $linkedinId, linkedinIdStatus: $linkedinIdStatus, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// class Preference {
//   Preference({
//     this.id,
//     this.userId,
//     this.preferenceType,
//     this.ageMin,
//     this.ageMax,
//     this.heightMin,
//     this.heightMax,
//     this.weightMin,
//     this.weightMax,
//     this.bodyType,
//     this.complexion,
//     this.countryCode,
//     this.country,
//     this.state,
//     this.city,
//     this.locationId,
//     this.maritalStatus,
//     this.specialcase,
//     this.religion,
//     this.cast,
//     this.subCast,
//     this.gothram,
//     this.fatherOccupationStatus,
//     this.motherOccupationStatus,
//     this.sibling,
//     this.familyCountryCode,
//     this.familyCountry,
//     this.familyState,
//     this.familyCity,
//     this.familyLocationId,
//     this.familyType,
//     this.familyValues,
//     this.occupation,
//     this.profession,
//     this.designation,
//     this.workingExperience,
//     this.education,
//     this.incomeRange,
//     this.saveAs,
//     this.status,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   int userId;
//   dynamic preferenceType;
//   dynamic ageMin;
//   dynamic ageMax;
//   int heightMin;
//   int heightMax;
//   dynamic weightMin;
//   dynamic weightMax;
//   BaseSettings bodyType;
//   BaseSettings complexion;
//   String countryCode;
//   dynamic country;
//   dynamic state;
//   dynamic city;
//   int locationId;
//   dynamic maritalStatus;
//   dynamic specialcase;
//   dynamic religion;
//   dynamic cast;
//   dynamic subCast;
//   dynamic gothram;
//   dynamic fatherOccupationStatus;
//   dynamic motherOccupationStatus;
//   dynamic sibling;
//   String familyCountryCode;
//   dynamic familyCountry;
//   dynamic familyState;
//   dynamic familyCity;
//   int familyLocationId;
//   dynamic familyType;
//   dynamic familyValues;
//   dynamic occupation;
//   dynamic profession;
//   dynamic designation;
//   dynamic workingExperience;
//   dynamic education;
//   dynamic incomeRange;
//   dynamic saveAs;
//   dynamic status;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Preference.fromMap(Map<String, dynamic> json) => Preference(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         preferenceType: json["preference_type"],
//         ageMin: json["age_min"],
//         ageMax: json["age_max"],
//         heightMin: json["height_min"] == null ? null : json["height_min"],
//         heightMax: json["height_max"] == null ? null : json["height_max"],
//         weightMin: json["weight_min"],
//         weightMax: json["weight_max"],
//         bodyType: json["body_type"] == null
//             ? null
//             : BaseSettings.fromJson(json["body_type"]),
//         complexion: json["complexion"] == null
//             ? null
//             : BaseSettings.fromJson(json["complexion"]),
//         countryCode: json["country_code"] == null ? null : json["country_code"],
//         country: json["country"],
//         state: json["state"],
//         city: json["city"],
//         locationId: json["location_id"] == null ? null : json["location_id"],
//         maritalStatus: json["marital_status"],
//         specialcase: json["specialcase"],
//         religion: json["religion"],
//         cast: json["cast"],
//         subCast: json["sub_cast"],
//         gothram: json["gothram"],
//         fatherOccupationStatus: json["father_occupation_status"],
//         motherOccupationStatus: json["mother_occupation_status"],
//         sibling: json["sibling"],
//         familyCountryCode: json["family_country_code"] == null
//             ? null
//             : json["family_country_code"],
//         familyCountry: json["family_country"],
//         familyState: json["family_state"],
//         familyCity: json["family_city"],
//         familyLocationId: json["family_location_id"] == null
//             ? null
//             : json["family_location_id"],
//         familyType: json["family_type"],
//         familyValues: json["family_values"],
//         occupation: json["occupation"],
//         profession: json["profession"],
//         designation: json["designation"],
//         workingExperience: json["working_experience"],
//         education: json["education"],
//         incomeRange: json["income_range"],
//         saveAs: json["save_as"],
//         status: json["status"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "preference_type": preferenceType,
//         "age_min": ageMin,
//         "age_max": ageMax,
//         "height_min": heightMin == null ? null : heightMin,
//         "height_max": heightMax == null ? null : heightMax,
//         "weight_min": weightMin,
//         "weight_max": weightMax,
//         "body_type": bodyType,
//         "complexion": complexion,
//         "country_code": countryCode == null ? null : countryCode,
//         "country": country,
//         "state": state,
//         "city": city,
//         "location_id": locationId == null ? null : locationId,
//         "marital_status": maritalStatus,
//         "specialcase": specialcase,
//         "religion": religion,
//         "cast": cast,
//         "sub_cast": subCast,
//         "gothram": gothram,
//         "father_occupation_status": fatherOccupationStatus,
//         "mother_occupation_status": motherOccupationStatus,
//         "sibling": sibling,
//         "family_country_code":
//             familyCountryCode == null ? null : familyCountryCode,
//         "family_country": familyCountry,
//         "family_state": familyState,
//         "family_city": familyCity,
//         "family_location_id":
//             familyLocationId == null ? null : familyLocationId,
//         "family_type": familyType,
//         "family_values": familyValues,
//         "occupation": occupation,
//         "profession": profession,
//         "designation": designation,
//         "working_experience": workingExperience,
//         "education": education,
//         "income_range": incomeRange,
//         "save_as": saveAs,
//         "status": status,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };
// }

// class Sibling {
//   Sibling({
//     this.id,
//     this.userId,
//     this.siblingName,
//     this.role,
//     this.profession,
//     this.maritalStatus,
//     this.status,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   int userId;
//   dynamic siblingName;
//   BaseSettings role;
//   BaseSettings profession;
//   BaseSettings maritalStatus;
//   dynamic status;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Sibling.fromMap(Map<String, dynamic> json) => Sibling(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         siblingName: json["sibling_name"],
//         role: json["role"] == null ? null : BaseSettings.fromJson(json["role"]),
//         profession: json["profession"] == null
//             ? null
//             : BaseSettings.fromJson(json["profession"]),
//         maritalStatus: json["marital_status"] == null
//             ? null
//             : BaseSettings.fromJson(json["marital_status"]),
//         status: json["status"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "sibling_name": siblingName,
//         "role": role,
//         "profession": profession,
//         "marital_status": maritalStatus,
//         "status": status,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };

//   @override
//   String toString() {
//     return 'Sibling{id: $id, userId: $userId, siblingName: $siblingName, role: $role, profession: $profession, maritalStatus: $maritalStatus, status: $status, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// class UserCoupling {
//   UserCoupling({
//     this.id,
//     this.userId,
//     this.questionId,
//     this.answer,
//     this.status,
//     this.qType,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   int userId;
//   int questionId;
//   String answer;
//   String qType;
//   dynamic status;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory UserCoupling.fromMap(Map<String, dynamic> json) => UserCoupling(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         questionId: json["question_id"] == null ? null : json["question_id"],
//         answer: json["answer"] == null ? null : json["answer"],
//         status: json["status"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "question_id": questionId == null ? null : questionId,
//         "answer": answer == null ? null : answer,
//         "status": status,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };

//   @override
//   String toString() {
//     return 'UserCoupling{id: $id, userId: $userId, questionId: $questionId, answer: $answer, qType: $qType, status: $status, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// class UsersBasicDetails {
//   UsersBasicDetails({
//     this.id,
//     this.userId,
//     this.profileApprovedBy,
//     this.profileRejectComment,
//     this.profileApprovedAt,
//     this.paymentPlan,
//     this.registeredBy,
//     this.facebookId,
//     this.googleId,
//     this.linkedinId,
//     this.webRegistrationStep,
//     this.appRegistrationStep,
//     this.registrationStatus,
//     this.couplingCompletedTime,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.purchasePlan,
//     this.purchaseTopup,
//     this.purchaseCoupling,
//   });

//   int id;
//   int userId;
//   dynamic profileApprovedBy;
//   dynamic profileRejectComment;
//   dynamic profileApprovedAt;
//   int paymentPlan;
//   dynamic registeredBy;
//   dynamic facebookId;
//   dynamic googleId;
//   dynamic linkedinId;
//   String webRegistrationStep;
//   int appRegistrationStep;
//   int registrationStatus;
//   dynamic couplingCompletedTime;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   List<PurchasePlan> purchasePlan;
//   List<dynamic> purchaseTopup;
//   List<CurrentCsStatistics> purchaseCoupling;

//   factory UsersBasicDetails.fromMap(Map<String, dynamic> json) =>
//       UsersBasicDetails(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         profileApprovedBy: json["profile_approved_by"],
//         profileRejectComment: json["profile_reject_comment"],
//         profileApprovedAt: json["profile_approved_at"],
//         paymentPlan: json["payment_plan"] == null ? null : json["payment_plan"],
//         registeredBy: json["registered_by"],
//         facebookId: json["facebook_id"],
//         googleId: json["google_id"],
//         linkedinId: json["linkedin_id"],
//         webRegistrationStep: json["web_registration_step"] == null
//             ? null
//             : json["web_registration_step"],
//         appRegistrationStep: json["app_registration_step"] == null
//             ? null
//             : json["app_registration_step"],
//         registrationStatus: json["registration_status"] == null
//             ? null
//             : json["registration_status"],
//         couplingCompletedTime: json["coupling_completed_time"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         purchasePlan: json["purchase_plan"] == null
//             ? null
//             : List<PurchasePlan>.from(
//                 json["purchase_plan"].map((x) => PurchasePlan.fromMap(x))),
//         purchaseTopup: json["purchase_topup"] == null
//             ? null
//             : List<dynamic>.from(json["purchase_topup"].map((x) => x)),
//         purchaseCoupling: json["purchase_coupling"] == null
//             ? null
//             : List<CurrentCsStatistics>.from(json["purchase_coupling"]
//                 .map((x) => CurrentCsStatistics.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "profile_approved_by": profileApprovedBy,
//         "profile_reject_comment": profileRejectComment,
//         "profile_approved_at": profileApprovedAt,
//         "payment_plan": paymentPlan == null ? null : paymentPlan,
//         "registered_by": registeredBy,
//         "facebook_id": facebookId,
//         "google_id": googleId,
//         "linkedin_id": linkedinId,
//         "web_registration_step":
//             webRegistrationStep == null ? null : webRegistrationStep,
//         "app_registration_step":
//             appRegistrationStep == null ? null : appRegistrationStep,
//         "registration_status":
//             registrationStatus == null ? null : registrationStatus,
//         "coupling_completed_time": couplingCompletedTime,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//         "purchase_plan": purchasePlan == null
//             ? null
//             : List<dynamic>.from(purchasePlan.map((x) => x.toMap())),
//         "purchase_topup": purchaseTopup == null
//             ? null
//             : List<dynamic>.from(purchaseTopup.map((x) => x)),
//         "purchase_coupling": purchaseCoupling == null
//             ? null
//             : List<dynamic>.from(purchaseCoupling.map((x) => x.toMap())),
//       };
// }

// class PurchasePlan {
//   PurchasePlan({
//     this.id,
//     this.userId,
//     this.planId,
//     this.planName,
//     this.amount,
//     this.profilesCount,
//     this.currentProfilesCount,
//     this.validity,
//     this.tokenOfLove,
//     this.searchProfile,
//     this.viewProfile,
//     this.sendInterests,
//     this.messages,
//     this.contactVisibility,
//     this.whatsappShare,
//     this.linkedinValidity,
//     this.csSummary,
//     this.csStatistics,
//     this.currentCsStatistics,
//     this.csMatch,
//     this.verificationBadge,
//     this.instantChat,
//     this.smsAlerts,
//     this.mailAlerts,
//     this.icon,
//     this.status,
//     this.expiredAt,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   int userId;
//   int planId;
//   String planName;
//   String amount;
//   int profilesCount;
//   int currentProfilesCount;
//   String validity;
//   int tokenOfLove;
//   int searchProfile;
//   int viewProfile;
//   int sendInterests;
//   int messages;
//   int contactVisibility;
//   int whatsappShare;
//   int linkedinValidity;
//   int csSummary;
//   int csStatistics;
//   int currentCsStatistics;
//   int csMatch;
//   int verificationBadge;
//   int instantChat;
//   int smsAlerts;
//   int mailAlerts;
//   String icon;
//   String status;
//   DateTime expiredAt;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory PurchasePlan.fromMap(Map<String, dynamic> json) => PurchasePlan(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         planId: json["plan_id"] == null ? null : json["plan_id"],
//         planName: json["plan_name"] == null ? null : json["plan_name"],
//         amount: json["amount"] == null ? null : json["amount"],
//         profilesCount:
//             json["profiles_count"] == null ? null : json["profiles_count"],
//         currentProfilesCount: json["current_profiles_count"] == null
//             ? null
//             : json["current_profiles_count"],
//         validity: json["validity"] == null ? null : json["validity"],
//         tokenOfLove:
//             json["token_of_love"] == null ? null : json["token_of_love"],
//         searchProfile:
//             json["search_profile"] == null ? null : json["search_profile"],
//         viewProfile: json["view_profile"] == null ? null : json["view_profile"],
//         sendInterests:
//             json["send_interests"] == null ? null : json["send_interests"],
//         messages: json["messages"] == null ? null : json["messages"],
//         contactVisibility: json["contact_visibility"] == null
//             ? null
//             : json["contact_visibility"],
//         whatsappShare:
//             json["whatsapp_share"] == null ? null : json["whatsapp_share"],
//         linkedinValidity: json["linkedin_validity"] == null
//             ? null
//             : json["linkedin_validity"],
//         csSummary: json["cs_summary"] == null ? null : json["cs_summary"],
//         csStatistics:
//             json["cs_statistics"] == null ? null : json["cs_statistics"],
//         currentCsStatistics: json["current_cs_statistics"] == null
//             ? null
//             : json["current_cs_statistics"],
//         csMatch: json["cs_match"] == null ? null : json["cs_match"],
//         verificationBadge: json["verification_badge"] == null
//             ? null
//             : json["verification_badge"],
//         instantChat: json["instant_chat"] == null ? null : json["instant_chat"],
//         smsAlerts: json["sms_alerts"] == null ? null : json["sms_alerts"],
//         mailAlerts: json["mail_alerts"] == null ? null : json["mail_alerts"],
//         icon: json["icon"] == null ? null : json["icon"],
//         status: json["status"] == null ? null : json["status"],
//         expiredAt: json["expired_at"] == null
//             ? null
//             : DateTime.parse(json["expired_at"]),
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "plan_id": planId == null ? null : planId,
//         "plan_name": planName == null ? null : planName,
//         "amount": amount == null ? null : amount,
//         "profiles_count": profilesCount == null ? null : profilesCount,
//         "current_profiles_count":
//             currentProfilesCount == null ? null : currentProfilesCount,
//         "validity": validity == null ? null : validity,
//         "token_of_love": tokenOfLove == null ? null : tokenOfLove,
//         "search_profile": searchProfile == null ? null : searchProfile,
//         "view_profile": viewProfile == null ? null : viewProfile,
//         "send_interests": sendInterests == null ? null : sendInterests,
//         "messages": messages == null ? null : messages,
//         "contact_visibility":
//             contactVisibility == null ? null : contactVisibility,
//         "whatsapp_share": whatsappShare == null ? null : whatsappShare,
//         "linkedin_validity": linkedinValidity == null ? null : linkedinValidity,
//         "cs_summary": csSummary == null ? null : csSummary,
//         "cs_statistics": csStatistics == null ? null : csStatistics,
//         "current_cs_statistics":
//             currentCsStatistics == null ? null : currentCsStatistics,
//         "cs_match": csMatch == null ? null : csMatch,
//         "verification_badge":
//             verificationBadge == null ? null : verificationBadge,
//         "instant_chat": instantChat == null ? null : instantChat,
//         "sms_alerts": smsAlerts == null ? null : smsAlerts,
//         "mail_alerts": mailAlerts == null ? null : mailAlerts,
//         "icon": icon == null ? null : icon,
//         "status": status == null ? null : status,
//         "expired_at": expiredAt == null ? null : expiredAt.toIso8601String(),
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };
// }

// class Mom {
//   Mom({
//     this.id,
//     this.userId,
//     this.partnerId,
//     this.momType,
//     this.momStatus,
//     this.message,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.seenAt,
//     this.remindAt,
//     this.snoozeAt,
//     this.momHistory,
//   });

//   int id;
//   int userId;
//   int partnerId;
//   String momType;
//   String momStatus;
//   dynamic message;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   DateTime seenAt;
//   DateTime remindAt;
//   DateTime snoozeAt;
//   List<MomHistory> momHistory;

//   factory Mom.fromMap(Map<String, dynamic> json) => Mom(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         partnerId: json["partner_id"] == null ? null : json["partner_id"],
//         momType: json["mom_type"] == null ? null : json["mom_type"],
//         momStatus: json["mom_status"] == null ? null : json["mom_status"],
//         message: json["message"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         seenAt:
//             json["seen_at"] == null ? null : DateTime.parse(json["seen_at"]),
//         remindAt: json["remind_at"] == null
//             ? null
//             : DateTime.parse(json["remind_at"]),
//         snoozeAt: json["snooze_at"] == null
//             ? null
//             : DateTime.parse(json["snooze_at"]),
//         momHistory: json["mom_history"] == null
//             ? null
//             : List<MomHistory>.from(
//                 json["mom_history"].map((x) => MomHistory.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "partner_id": partnerId == null ? null : partnerId,
//         "mom_type": momType == null ? null : momType,
//         "mom_status": momStatus == null ? null : momStatus,
//         "message": message,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//         "seen_at": seenAt == null ? null : seenAt.toIso8601String(),
//         "remind_at": remindAt == null ? null : remindAt.toIso8601String(),
//         "snooze_at": snoozeAt == null ? null : snoozeAt.toIso8601String(),
//         "mom_history": momHistory == null
//             ? null
//             : List<dynamic>.from(momHistory.map((x) => x.toMap())),
//       };
// }

// class MomHistory {
//   MomHistory({
//     this.id,
//     this.userId,
//     this.partnerId,
//     this.momId,
//     this.momType,
//     this.momStatus,
//     this.message,
//     this.adminMessage,
//     this.userHide,
//     this.partnerHide,
//     this.seenAt,
//     this.remindAt,
//     this.snoozeAt,
//     this.actionAt,
//     this.actionCount,
//     this.statusPosition,
//     this.viewAt,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.historyText,
//     this.loveGiven,
//     this.loveRecieve,
//   });

//   int id;
//   int userId;
//   int partnerId;
//   int momId;
//   String momType;
//   String momStatus;
//   String message;
//   dynamic adminMessage;
//   int userHide;
//   int partnerHide;
//   DateTime seenAt;
//   DateTime remindAt;
//   DateTime snoozeAt;
//   DateTime actionAt;
//   dynamic actionCount;
//   String statusPosition;
//   dynamic viewAt;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String historyText;
//   int loveGiven;
//   int loveRecieve;

//   factory MomHistory.fromMap(Map<String, dynamic> json) => MomHistory(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         partnerId: json["partner_id"] == null ? null : json["partner_id"],
//         momId: json["mom_id"] == null ? null : json["mom_id"],
//         momType: json["mom_type"] == null ? null : json["mom_type"],
//         momStatus: json["mom_status"] == null ? null : json["mom_status"],
//         message: json["message"] == null ? null : json["message"],
//         adminMessage: json["admin_message"],
//         userHide: json["user_hide"] == null ? null : json["user_hide"],
//         partnerHide: json["partner_hide"] == null ? null : json["partner_hide"],
//         seenAt:
//             json["seen_at"] == null ? null : DateTime.parse(json["seen_at"]),
//         remindAt: json["remind_at"] == null
//             ? null
//             : DateTime.parse(json["remind_at"]),
//         snoozeAt: json["snooze_at"] == null
//             ? null
//             : DateTime.parse(json["snooze_at"]),
//         actionAt: json["action_at"] == null
//             ? null
//             : DateTime.parse(json["action_at"]),
//         actionCount: json["action_count"],
//         statusPosition:
//             json["status_position"] == null ? null : json["status_position"],
//         viewAt: json["view_at"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         historyText: json["history_text"] == null ? null : json["history_text"],
//         loveGiven: json["love_given"] == null ? null : json["love_given"],
//         loveRecieve: json["love_recieve"] == null ? null : json["love_recieve"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "partner_id": partnerId == null ? null : partnerId,
//         "mom_id": momId == null ? null : momId,
//         "mom_type": momType == null ? null : momType,
//         "mom_status": momStatus == null ? null : momStatus,
//         "message": message == null ? null : message,
//         "admin_message": adminMessage,
//         "user_hide": userHide == null ? null : userHide,
//         "partner_hide": partnerHide == null ? null : partnerHide,
//         "seen_at": seenAt == null ? null : seenAt.toIso8601String(),
//         "remind_at": remindAt == null ? null : remindAt.toIso8601String(),
//         "snooze_at": snoozeAt == null ? null : snoozeAt.toIso8601String(),
//         "action_at": actionAt == null ? null : actionAt.toIso8601String(),
//         "action_count": actionCount,
//         "status_position": statusPosition == null ? null : statusPosition,
//         "view_at": viewAt,
//         "deleted_at": deletedAt,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//         "history_text": historyText == null ? null : historyText,
//         "love_given": loveGiven == null ? null : loveGiven,
//         "love_recieve": loveRecieve == null ? null : loveRecieve,
//       };
// }

// class RecomendCause {
//   RecomendCause({
//     this.id,
//     this.value,
//     this.count,
//     this.checked,
//   });

//   int id;
//   String value;
//   int count;
//   bool checked;

//   factory RecomendCause.fromMap(Map<String, dynamic> json) => RecomendCause(
//         id: json["id"] == null ? null : json["id"],
//         value: json["value"] == null ? null : json["value"],
//         count: json["count"] == null ? null : json["count"],
//         checked: json["checked"] == null ? null : json["checked"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "value": value == null ? null : value,
//         "count": count == null ? null : count,
//         "checked": checked == null ? null : checked,
//       };
// }

// /*
// import 'dart:convert';
// import 'dart:io';

// import 'package:coupled/Src/coupledLocalDb/baseSettings/BaseSettingsModel.dart';
// import 'package:coupled/Utils/SMC/SMCWidget.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'Profile.g.dart';

// ProfileModel profileModelFromJson(String str) =>
//     ProfileModel.fromJson(json.decode(str));

// String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

// @JsonSerializable(
//     includeIfNull: true, checked: true, createToJson: true, createFactory: true)
// class ProfileModel {
//   @JsonKey(defaultValue: "")
//   String status;
//   ProfileResponse response;
//   @JsonKey(defaultValue: 0)
//   int code;

//   ProfileModel({
//     this.response,
//     this.code,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) =>
//       _$ProfileModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class ProfileResponse {
//   @JsonKey(defaultValue: true)
//   final bool passwordStatus;
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: "")
//   final String name;
//   @JsonKey(defaultValue: "")
//   final String lastName;
//   @JsonKey(defaultValue: "")
//   String membershipCode;
//   @JsonKey(defaultValue: "male")
//   String gender;
//   @JsonKey(defaultValue: "")
//   String profilePic;
//   @JsonKey(defaultValue: 0)
//   int emailVerification;
//   @JsonKey(defaultValue: 0)
//   int mobileVerification;
//   @JsonKey(defaultValue: 0)
//   int totalCredits;
//   @JsonKey(defaultValue: 0)
//   int pendingCredits;
//   DateTime planExpiry;
//   Membership membership;
//   @JsonKey(defaultValue: 0)
//   int isActive;
//   DateTime lastActive;
//   dynamic hideAt;

// //  Purchaseplan purchaseplan;
// //  Purchasetopup purchasetopup;
// //  Purchasecoupling purchasecoupling;
//   @JsonKey(defaultValue: "")
//   String userEmail;
//   @JsonKey(defaultValue: "")
//   String userPhone;
//   Address address;
//   EducationJobResponse educationJob;
//   FamilyResponse family;
//   Mom mom;
//   Mom blockMe;
//   Mom reportMe;
//   @JsonKey(defaultValue: null)
//   CouplingScoreStatisticsS currentCsStatistics;
//   @JsonKey(defaultValue: null)
//   Mom shortlistByMe;
//   @JsonKey(defaultValue: null)
//   Mom shortlistMe;
//   List<FreeCoupling> freeCoupling;
//   List<RecomendCause> recomendCause;
//   @JsonKey(defaultValue: 0)
//   int recomendCauseCount;
//   @JsonKey(defaultValue: 0)
//   int chatCount;
//   InfoResponse info;
//   OfficialDocuments officialDocuments;
//   List<PhotoResponse> photos;
//   PhotoResponse dp;
//   Preference preference;
//   UsersBasicDetails usersBasicDetails;
//   List<SiblingResponse> siblings;
//   List<UserCoupling> userCoupling;
//   @JsonKey(ignore : true)
//   List<UserCoupling> couplingQProfileResponse;
//   @JsonKey(defaultValue: 0)
//   int recommendGiven;
//   @JsonKey(defaultValue: 0)
//   int recommendReceived;
//   @JsonKey(defaultValue: 0)
//   int score;

//   ///Its only for Register Page
//   @JsonKey(ignore: true)
//   File officeId;
//   @JsonKey(ignore: true)
//   PhotoModel photoModel;
//   @JsonKey(ignore: true)
//   List<PhotoModel> photoData;
//   @JsonKey(ignore: true)
//   Religious religious = Religious.initial();

// //  @JsonKey(ignore: true)
// //  TOLInfo tolInfo = TOLInfo();
//   @JsonKey(ignore: true)
//   QuestionsInput questionsInput;

//   ProfileResponse({
//     this.passwordStatus,
//     this.id,
//     this.name,
//     this.lastName,
//     this.membershipCode,
//     this.gender,
//     this.profilePic,
//     this.emailVerification,
//     this.mobileVerification,
//     this.isActive,
//     this.lastActive,
//     this.hideAt,
//     this.membership,
// */
// /*    this.purchaseplan,
//     this.purchasetopup,
//     this.purchasecoupling,*/ /*

//     this.userEmail,
//     this.currentCsStatistics,
//     this.userPhone,
//     this.address,
//     this.educationJob,
//     this.family,
//     this.mom,
//     this.blockMe,
//     this.reportMe,
//     this.shortlistByMe,
//     this.shortlistMe,
//     this.freeCoupling,
//     this.info,
//     this.officialDocuments,
//     this.photos,
//     this.dp,
//     this.preference,
//     this.usersBasicDetails,
//     this.siblings,
//     this.userCoupling,
//     this.couplingQProfileResponse,
//     this.chatCount,
//     this.recommendGiven,
//     this.recommendReceived,
//   }) : super();

//   factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
//       _$ProfileResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

//   @override
//   String toString() {
//     return 'ProfileResponse{id: $id, name: $name, lastName: $lastName, membershipCode: $membershipCode, '
//         'gender: $gender, profilePic: $profilePic, emailVerification: $emailVerification, '
//         'mobileVerification: $mobileVerification, membership: $membership, isActive: $isActive, '
//         'lastActive: $lastActive, hideAt: $hideAt, userEmail: $userEmail, userPhone: $userPhone, '
//         'address: $address, educationJob: $educationJob, family: $family, mom: $mom, '
//         'freeCoupling: $freeCoupling, recomendCause: $recomendCause, recomendCauseCount: $recomendCauseCount, '
//         'info: $info, officialDocuments: $officialDocuments, photos: $photos, dp: $dp, preference: $preference, '
//         'usersBasicDetails: $usersBasicDetails, siblings: $siblings, userCoupling: $userCoupling, '
//         'couplingQProfileResponse: $couplingQProfileResponse, recommendGiven: $recommendGiven,'
//         ' recommendReceived: $recommendReceived, officeId: $officeId, '
//         'photoModel: $photoModel, photoData: $photoData, religious: $religious, '
//         'couplingQuestions: $questionsInput}';
//   }

// */
// /* tolInfo: $tolInfo,*/ /*

//   Map<String, dynamic> getSectionOne() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['gender'] = this.gender;
//     data['dob'] = this.info.dob?.toString();
//     data['dob_status'] = this.info.dobStatus;
//     data['weight'] = this.info.weight.round();
//     data['height'] = this.info.height.round();
//     data['partner_height_min'] = this.preference.heightMin.round();
//     data['partner_height_max'] = this.preference.heightMax.round();
//     return data;
//   }

//   Map<String, dynamic> getSectionTwo() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['body_type'] = this.info.bodyType.id;
//     data['complexion'] = this.info.complexion.id;
//     data['partner_body_type'] = this.preference.bodyType?.id;
//     data['partner_complexion'] = this.preference.complexion?.id;
//     return data;
//   }

//   Map<String, dynamic> getSectionThree() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['marital_status'] = this.info.maritalStatus.id;
//     data['number_of_children'] = this.info.numberOfChildren;
//     data['child_living_status'] = this.info.childLivingStatus?.id;
//     data['special_case'] = this.info.specialCase;
//     data['special_case_type'] = this.info.specialCaseType?.id;
//     data['special_case_notify'] = this.info.specialCaseNotify;
//     return data;
//   }

//   Map<String, dynamic> getSectionFour() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['country_code'] = info.countryCode;
//     data['location_id'] = info.locationId;
//     return data;
//   }

//   Map<String, dynamic> getSectionFive() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['born_place'] = this.info.bornPlace;
//     data['dob'] = this.info.dob?.toString();
//     data['born_time'] = this.info.bornTime;
//     return data;
//   }

//   Map<String, dynamic> getSectionSix() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['file'] = {
//       'govt_id_front': this.officialDocuments.govtIdFront,
//       'govt_id_back': this.officialDocuments.govtIdBack
//     };
//     data['fields'] = {
//       "govt_id_type": this.officialDocuments.govtIdType.toString()
//     };
//     return data;
//   }

//   Map<String, dynamic> getSectionSeven() {
//     final Map<String, dynamic> data = Map<String, dynamic>();

//     data['about_partner'] = this.info.aboutPartner;
//     print(data);
//     return data;
//   }

//   Map<String, dynamic> getSectionEight() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['about_self'] = this.info.aboutSelf;
//     return data;
//   }

//   Map<String, dynamic> getSectionNine() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['country_code'] = this.address?.countryCode;
//     data['location_id'] = this.address?.locationId;
//     data['address'] = this.address?.address;
//     data['pincode'] = this.address?.pincode;
//     data['tol_status'] = this.address?.tolStatus;
//     return data;
//   }

//   Map<String, dynamic> getSectionTen() {
//     /// photoUpload Section
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     */
// /*  data['file'] = {'photo': profilePhoto.profileImageFile};
//     data['fields'] = profilePhoto.toJson();*/ /*

//     print("Photograph output-------$data");
//     return data;
//   }

//   Map<String, dynamic> getSectionEleven() {
//     */
// /*{
// 	"father_name": "FAU",
// 	"father_occupation_status": 26,
// 	"mother_name": "MAU",
// 	"mother_occupation_status": 26,
// 	"user_siblings": [{
// 			"sibling_name": "SNU",
// 			"profession": 26,
// 			"marital_status": 114
// 		},
// 		{
// 			"sibling_name": "BNU",
// 			"profession": 26,
// 			"marital_status": 114
// 		}
// 	]
// }*/ /*

//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data["father_occupation_status"] = this.family?.fatherOccupationStatus?.id;
//     data["mother_occupation_status"] = this.family?.motherOccupationStatus?.id;
//     List<Map<String, dynamic>> siblingsList = List();
//     siblings.forEach((f) {
//       siblingsList.add({
//         "sibling_role": f?.role?.id,
//         "profession": f?.profession?.id,
//         "marital_status": f?.maritalStatus?.id
//       });
//     });
//     data["user_siblings"] = json.encode(siblingsList);
//     print("FamilyInfo A output-------$data");
//     return data;
//   }

//   Map<String, dynamic> getSectionTwelve() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['family_type'] = this.family?.familyType?.id;
//     data['family_values'] = this.family?.familyValues?.id;
//     data['country_code'] = this.family?.countryCode;
//     data['location_id'] =
//         this.family?.locationId == 0 ? "" : this.family?.locationId;
//     print("Section12 output-------$data");
//     return data;
//   }

//   Map<String, dynamic> getSectionThirteen() {
//     final Map<String, dynamic> data = Map();
//     data['religion'] = this.family.religion?.id.toString() ?? null;
//     data['cast'] = this.family.cast?.id?.toString() ?? null;
//     data['subcast'] = this.family.subcast?.id?.toString() ?? null;
//     data['gothram'] = this.family.gothram?.id?.toString() ?? null;
//     return data;
//   }

//   Map<String, dynamic> getProfEducationA() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     print("officeId");
//     print(this.officeId);

//     data['file'] = officeId != null ? {'office_id': this.officeId} : null;
//     data['fields'] = {
//       "company_name": this.educationJob.companyName.toString(),
//       "industry": this.educationJob.industry?.id.toString(),
//       "profession": this.educationJob.profession?.id.toString(),
//       "job_status": this.educationJob.jobStatus.toString()
//     };
//     print("ProfEducationA------------");
//     print(data);
//     return data;
//   }

//   Map<String, dynamic> getProfEducationB() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['experience'] = this.educationJob.experience?.id.toString() ?? null;
//     data['income_range'] = this.educationJob.incomeRange?.id.toString() ?? null;
//     data['highest_education'] =
//         this.educationJob.highestEducation?.id.toString() ?? null;
//     data['education_branch'] =
//         this.educationJob.educationBranch?.id?.toString() ?? "";
//     print("ProfEducationB data------------ $data");
//     return data;
//   }


//   Map<String, dynamic> getCouplingSection() {
//     Map<String, dynamic> data = Map<String, dynamic>();
//     data["user_coupling"] = toJson()["user_coupling"];
//     print("object ::::: $data");
//     return data;
//   }
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Address {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   dynamic addressType;
//   @JsonKey(defaultValue: "")
//   String countryCode;
//   @JsonKey(defaultValue: "")
//   String country;
//   @JsonKey(defaultValue: "")
//   String state;
//   @JsonKey(defaultValue: "")
//   String city;
//   @JsonKey(defaultValue: 0)
//   int locationId;
//   @JsonKey(defaultValue: "")
//   String address;
//   @JsonKey(defaultValue: 0)
//   int pincode;
//   @JsonKey(defaultValue: 0)
//   int tolStatus;
//   @JsonKey(defaultValue: 0)
//   int presentAddress;

//   DateTime deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Address({
//     this.id,
//     this.userId,
//     this.addressType,
//     this.countryCode,
//     this.country,
//     this.state,
//     this.city,
//     this.locationId,
//     this.address,
//     this.pincode,
//     this.tolStatus,
//     this.presentAddress,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Address.fromJson(Map<String, dynamic> json) =>
//       _$AddressFromJson(json);

//   Map<String, dynamic> toJson() => _$AddressToJson(this);

//   @override
//   String toString() {
//     return 'Address{id: $id, userId: $userId, addressType: $addressType, countryCode: $countryCode, '
//         'country: $country, state: $state, city: $city, locationId: $locationId, address: $address, '
//         'pincode: $pincode, tolStatus: $tolStatus, presentAddress: $presentAddress, deletedAt: $deletedAt, '
//         'createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class PhotoResponse {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   @JsonKey(defaultValue: "")
//   String photoName;
//   @JsonKey(defaultValue: "")
//   String fromType;
//   Data imageType;
//   @JsonKey(defaultValue: 0)
//   int status;
//   dynamic approvedBy;
//   DateTime photoApprovedAt;
//   dynamic comments;
//   @JsonKey(defaultValue: 0)
//   int trash;
//   Data imageTaken;
//   @JsonKey(defaultValue: 0)
//   int dpStatus;
//   @JsonKey(defaultValue: 0)
//   int sortOrder;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   UserDetail userDetail;

//   PhotoResponse({
//     this.id,
//     this.userId,
//     this.photoName,
//     this.fromType,
//     this.imageType,
//     this.approvedBy,
//     this.photoApprovedAt,
//     this.comments,
//     this.trash,
//     this.imageTaken,
//     this.dpStatus,
//     this.sortOrder,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.userDetail,
//   });

//   factory PhotoResponse.fromJson(Map<String, dynamic> json) =>
//       _$PhotoResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$PhotoResponseToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Data {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: "")
//   String type;
//   @JsonKey(defaultValue: "")
//   String value;
//   @JsonKey(defaultValue: 0)
//   int parentId;
//   @JsonKey(defaultValue: "")
//   String others;
//   bool isSelected;

//   Data({
//     this.id,
//     this.type,
//     this.value,
//     this.parentId,
//     this.others,
//     this.isSelected,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

//   Map<String, dynamic> toJson() => _$DataToJson(this);

//   @override
//   String toString() {
//     return 'Data{id: $id, type: $type, value: $value, parentId: $parentId, others: $others, isSelected: $isSelected}';
//   }
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class UserDetail {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: "")
//   String name;
//   @JsonKey(defaultValue: "")
//   String lastName;
//   @JsonKey(defaultValue: "")
//   String membershipCode;
//   @JsonKey(defaultValue: "")
//   String gender;
//   @JsonKey(defaultValue: "")
//   String profilePic;
//   @JsonKey(defaultValue: 0)
//   int emailVerification;
//   @JsonKey(defaultValue: 0)
//   int mobileVerification;
//   @JsonKey(defaultValue: 0)
//   int isActive;
//   DateTime lastActive;
//   DateTime hideAt;

//   UserDetail({
//     this.id,
//     this.name,
//     this.lastName,
//     this.membershipCode,
//     this.gender,
//     this.profilePic,
//     this.emailVerification,
//     this.mobileVerification,
//     this.isActive,
//     this.lastActive,
//     this.hideAt,
//   });

//   factory UserDetail.fromJson(Map<String, dynamic> json) =>
//       _$UserDetailFromJson(json);

//   Map<String, dynamic> toJson() => _$UserDetailToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class EducationJobResponse {
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   dynamic linkedInStatus;
//   @JsonKey(defaultValue: 0)
//   int jobStatus;
//   @JsonKey(defaultValue: "")
//   String companyName;
//   Data industry;
//   Data profession;
//   Data experience;
//   Data highestEducation;
//   Data educationBranch;
//   Data incomeRange;
//   DateTime deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   EducationJobResponse({
//     this.id,
//     this.userId,
//     this.linkedInStatus,
//     this.jobStatus,
//     this.companyName,
//     this.industry,
//     this.profession,
//     this.experience,
//     this.highestEducation,
//     this.educationBranch,
//     this.incomeRange,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory EducationJobResponse.fromJson(Map<String, dynamic> json) =>
//       _$EducationJobResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$EducationJobResponseToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Membership {
//   Membership({
//     @JsonKey(defaultValue: false) this.paidMember,
//     @JsonKey(defaultValue: '') this.planName,
//     @JsonKey(defaultValue: 0) this.chat,
//     @JsonKey(defaultValue: 0) this.statistics,
//     @JsonKey(defaultValue: 0) this.share,
//     @JsonKey(defaultValue: 0) this.verificationBadge,
//     this.expiredAt,
//   });

//   bool paidMember;
//   String planName;
//   int chat;
//   int statistics;
//   int share;
//   int verificationBadge;
//   DateTime expiredAt;

//   factory Membership.fromJson(Map<String, dynamic> json) =>
//       _$MembershipFromJson(json);

//   Map<String, dynamic> toJson() => _$MembershipToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class FamilyResponse {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   String fatherName;
//   Data fatherOccupationStatus;
//   String motherName;
//   Data motherOccupationStatus;
//   Data familyType;
//   Data familyValues;
//   Data religion;
//   Data cast;
//   Data subcast;
//   Data gothram;
//   @JsonKey(defaultValue: "")
//   String countryCode;
//   @JsonKey(defaultValue: "")
//   String country;
//   @JsonKey(defaultValue: "")
//   String state;
//   @JsonKey(defaultValue: "")
//   String city;
//   @JsonKey(defaultValue: 0)
//   int locationId;

//   DateTime deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   FamilyResponse({
//     this.id,
//     this.userId,
//     this.fatherName,
//     this.fatherOccupationStatus,
//     this.motherName,
//     this.motherOccupationStatus,
//     this.familyType,
//     this.familyValues,
//     this.religion,
//     this.cast,
//     this.subcast,
//     this.gothram,
//     this.countryCode,
//     this.country,
//     this.state,
//     this.city,
//     this.locationId,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory FamilyResponse.fromJson(Map<String, dynamic> json) =>
//       _$FamilyResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$FamilyResponseToJson(this);

//   @override
//   String toString() {
//     return 'FamilyResponse{id: $id, userId: $userId, fatherName: $fatherName, fatherOccupationStatus: $fatherOccupationStatus, motherName: $motherName, motherOccupationStatus: $motherOccupationStatus, familyType: $familyType, familyValues: $familyValues, religion: $religion, cast: $cast, subcast: $subcast, gothram: $gothram, countryCode: $countryCode, country: $country, state: $state, city: $city, locationId: $locationId, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class InfoResponse {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   DateTime dob;
//   @JsonKey(defaultValue: 0)
//   int dobStatus;
//   @JsonKey(defaultValue: 0)
//   int height;
//   @JsonKey(defaultValue: 0)
//   int weight;
//   Data bodyType;
//   Data complexion;
//   @JsonKey(defaultValue: 0)
//   int specialCase;
//   Data specialCaseType;
//   @JsonKey(defaultValue: 0)
//   int specialCaseNotify;
//   @JsonKey(defaultValue: 0)
//   int adminApprovalStatus;
//   @JsonKey(defaultValue: "")
//   String countryCode;
//   @JsonKey(defaultValue: "")
//   String country;
//   @JsonKey(defaultValue: "")
//   String state;
//   @JsonKey(defaultValue: "")
//   String city;
//   @JsonKey(defaultValue: 0)
//   int locationId;
//   Data maritalStatus;
//   @JsonKey(defaultValue: 0)
//   int numberOfChildren;
//   Data childLivingStatus;
//   @JsonKey(defaultValue: "")
//   String bornPlace;
//   @JsonKey(defaultValue: "")
//   String bornTime;
//   @JsonKey(defaultValue: "")
//   String aboutSelf;
//   @JsonKey(defaultValue: "")
//   String aboutPartner;
//   dynamic completedStatus;
//   dynamic completedIn;
//   DateTime deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   InfoResponse({
//     this.id,
//     this.userId,
//     this.dobStatus,
//     this.dob,
//     this.height,
//     this.weight,
//     this.bodyType,
//     this.complexion,
//     this.specialCase,
//     this.specialCaseType,
//     this.specialCaseNotify,
//     this.adminApprovalStatus,
//     this.countryCode,
//     this.country,
//     this.state,
//     this.city,
//     this.locationId,
//     this.maritalStatus,
//     this.numberOfChildren,
//     this.childLivingStatus,
//     this.bornPlace,
//     this.bornTime,
//     this.aboutSelf,
//     this.aboutPartner,
//     this.completedStatus,
//     this.completedIn,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   }) : super();

//   factory InfoResponse.fromJson(Map<String, dynamic> json) =>
//       _$InfoResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$InfoResponseToJson(this);

//   @override
//   String toString() {
//     return 'InfoResponse{id: $id, userId: $userId, dob: $dob, dobStatus: $dobStatus, height: $height,'
//         ' weight: $weight, bodyType: $bodyType, complexion: $complexion, specialCase: $specialCase,'
//         ' specialCaseType: $specialCaseType, specialCaseNotify: $specialCaseNotify,'
//         ' adminApprovalStatus: $adminApprovalStatus, countryCode: $countryCode, country: $country,'
//         ' state: $state, city: $city, locationId: $locationId, maritalStatus: $maritalStatus,'
//         ' numberOfChildren: $numberOfChildren, childLivingStatus: $childLivingStatus, bornPlace: $bornPlace,'
//         ' bornTime: $bornTime, aboutSelf: $aboutSelf, aboutPartner: $aboutPartner, completedStatus: $completedStatus,'
//         ' completedIn: $completedIn, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class OfficialDocuments {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   @JsonKey(defaultValue: 0)
//   int govtIdType;

// //  @JsonKey(defaultValue: "")
//   dynamic govtIdFront;

// //  @JsonKey(defaultValue: "")
//   dynamic govtIdBack;
//   @JsonKey(defaultValue: 0)
//   int govtIdStatus;
//   dynamic govtIdApprovedBy;
//   dynamic govtIdRejectComments;
//   dynamic govtIdApprovedAt;
//   dynamic officeId;
//   @JsonKey(defaultValue: 0)
//   int officeIdStatus;
//   dynamic officeIdApprovedBy;
//   dynamic officeIdRejectComments;
//   dynamic officeIdApprovedAt;
//   dynamic linkedinId;
//   @JsonKey(defaultValue: 0)
//   int linkedinIdStatus;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   OfficialDocuments({
//     this.id,
//     this.userId,
//     this.govtIdType,
//     this.govtIdFront,
//     this.govtIdBack,
//     this.govtIdStatus,
//     this.govtIdApprovedBy,
//     this.govtIdRejectComments,
//     this.govtIdApprovedAt,
//     this.officeId,
//     this.officeIdStatus,
//     this.officeIdApprovedBy,
//     this.officeIdRejectComments,
//     this.officeIdApprovedAt,
//     this.linkedinId,
//     this.linkedinIdStatus,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory OfficialDocuments.fromJson(Map<String, dynamic> json) =>
//       _$OfficialDocumentsFromJson(json);

//   Map<String, dynamic> toJson() => _$OfficialDocumentsToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Preference {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   dynamic preferenceType;
//   @JsonKey(defaultValue: 0)
//   int ageMin;
//   @JsonKey(defaultValue: 0)
//   int ageMax;
//   @JsonKey(defaultValue: 0)
//   int heightMin;
//   @JsonKey(defaultValue: 0)
//   int heightMax;
//   @JsonKey(defaultValue: 0)
//   int weightMin;
//   @JsonKey(defaultValue: 0)
//   int weightMax;
//   Data bodyType;
//   Data complexion;
//   @JsonKey(defaultValue: "")
//   String countryCode;
//   dynamic country;
//   dynamic state;
//   dynamic city;
//   @JsonKey(defaultValue: 0)
//   int locationId;
//   Data maritalStatus;
//   Data specialcase;
//   Data religion;
//   Data cast;
//   Data subCast;
//   Data gothram;
//   Data fatherOccupationStatus;
//   Data motherOccupationStatus;
//   dynamic sibling;
//   @JsonKey(defaultValue: "")
//   String familyCountryCode;
//   dynamic familyCountry;
//   dynamic familyState;
//   dynamic familyCity;
//   @JsonKey(defaultValue: 0)
//   int familyLocationId;
//   Data familyType;
//   Data familyValues;
//   Data occupation;
//   Data profession;
//   Data designation;
//   dynamic workingExperience;
//   Data education;
//   dynamic incomeRange;
//   dynamic saveAs;

//   DateTime deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Preference({
//     this.id,
//     this.userId,
//     this.preferenceType,
//     this.ageMin,
//     this.ageMax,
//     this.heightMin,
//     this.heightMax,
//     this.weightMin,
//     this.weightMax,
//     this.bodyType,
//     this.complexion,
//     this.countryCode,
//     this.country,
//     this.state,
//     this.city,
//     this.locationId,
//     this.maritalStatus,
//     this.specialcase,
//     this.religion,
//     this.cast,
//     this.subCast,
//     this.gothram,
//     this.fatherOccupationStatus,
//     this.motherOccupationStatus,
//     this.sibling,
//     this.familyCountryCode,
//     this.familyCountry,
//     this.familyState,
//     this.familyCity,
//     this.familyLocationId,
//     this.familyType,
//     this.familyValues,
//     this.occupation,
//     this.profession,
//     this.designation,
//     this.workingExperience,
//     this.education,
//     this.incomeRange,
//     this.saveAs,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Preference.fromJson(Map<String, dynamic> json) =>
//       _$PreferenceFromJson(json);

//   Map<String, dynamic> toJson() => _$PreferenceToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class FreeCoupling {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: '')
//   String couplingType;
//   @JsonKey(defaultValue: '')
//   String type;
//   @JsonKey(defaultValue: '')
//   String question;
//   @JsonKey(defaultValue: 0)
//   int questionOrder;
//   @JsonKey(defaultValue: 0)
//   int parent;
//   @JsonKey(defaultValue: '')
//   String status;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   @JsonKey(defaultValue: 0.0)
//   double score;
//   @JsonKey(defaultValue: '')
//   String message;

//   FreeCoupling({
//     this.id,
//     this.couplingType,
//     this.type,
//     this.question,
//     this.questionOrder,
//     this.parent,
//     this.status,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.score,
//     this.message,
//   });

//   factory FreeCoupling.fromJson(Map<String, dynamic> json) =>
//       _$FreeCouplingFromJson(json);

//   Map<String, dynamic> toJson() => _$FreeCouplingToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class RecomendCause {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: "")
//   String value;
//   @JsonKey(defaultValue: 0)
//   int count;
//   @JsonKey(defaultValue: false)
//   bool checked;

//   RecomendCause({
//     this.id,
//     this.value,
//     this.count,
//     this.checked,
//   });

//   factory RecomendCause.fromJson(Map<String, dynamic> json) =>
//       _$RecomendCauseFromJson(json);

//   Map<String, dynamic> toJson() => _$RecomendCauseToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class CouplingScoreStatisticsS {
//   int id;

//   // String activationFee;
//   // String validity;
//   String statisticsOption;

//   // String status;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime expiredAt;
//   DateTime updatedAt;

//   CouplingScoreStatisticsS({
//     this.id,
//     // this.activationFee,
//     //  this.validity,
//     this.statisticsOption,
//     // this.status,
//     this.deletedAt,
//     this.createdAt,
//     this.expiredAt,
//     this.updatedAt,
//   });

//   factory CouplingScoreStatisticsS.fromJson(Map<String, dynamic> json) =>
//       _$CouplingScoreStatisticsSFromJson(json);

//   Map<String, dynamic> toJson() => _$CouplingScoreStatisticsSToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Purchasetopup {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: 0)
//   int purchasePlanId;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   @JsonKey(defaultValue: 0)
//   int purchaseTopupId;
//   @JsonKey(defaultValue: "")
//   String topupType;
//   @JsonKey(defaultValue: "")
//   String amount;
//   @JsonKey(defaultValue: 0)
//   int validity;
//   @JsonKey(defaultValue: 0)
//   int profiles;

//   DateTime activeAt;
//   DateTime expiredAt;
//   DateTime deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Purchasetopup({
//     this.id,
//     this.purchasePlanId,
//     this.userId,
//     this.purchaseTopupId,
//     this.topupType,
//     this.amount,
//     this.validity,
//     this.profiles,
//     this.activeAt,
//     this.expiredAt,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Purchasetopup.fromJson(Map<String, dynamic> json) =>
//       _$PurchasetopupFromJson(json);

//   Map<String, dynamic> toJson() => _$PurchasetopupToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class SiblingResponse {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   String siblingName;
//   Data role;
//   Data profession;
//   Data maritalStatus;

//   DateTime deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   SiblingResponse({
//     this.id,
//     this.userId,
//     this.siblingName,
//     this.role,
//     this.profession,
//     this.maritalStatus,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory SiblingResponse.fromJson(Map<String, dynamic> json) =>
//       _$SiblingResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$SiblingResponseToJson(this);

//   @override
//   String toString() {
//     return 'SiblingResponse{id: $id, userId: $userId, siblingName: $siblingName, role: $role, profession: $profession, maritalStatus: $maritalStatus, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class UserCoupling {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   @JsonKey(defaultValue: 0)
//   int questionId;
//   dynamic answer;
//   @JsonKey(ignore: true)
//   String qType;

//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   UserCoupling({
//     this.id,
//     this.userId,
//     this.questionId,
//     this.answer,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.qType,
//   });

//   factory UserCoupling.fromJson(Map<String, dynamic> json) =>
//       _$UserCouplingFromJson(json);

//   Map<String, dynamic> toJson() => _$UserCouplingToJson(this);

//   @override
//   String toString() {
//     return 'UserCoupling{id: $id, userId: $userId, questionId: $questionId, answer: $answer, '
//         'qType: $qType, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class UsersBasicDetails {
//   @JsonKey(defaultValue: 0)
//   int id;
//   @JsonKey(defaultValue: 0)
//   int userId;
//   UserDetail profileApprovedBy;
//   dynamic profileRejectComment;
//   DateTime profileApprovedAt;
//   @JsonKey(defaultValue: 0)
//   int paymentPlan;
//   dynamic registeredBy;
//   dynamic facebookId;
//   dynamic googleId;
//   dynamic linkedinId;
//   @JsonKey(defaultValue: "")
//   String webRegistrationStep;
//   @JsonKey(defaultValue: null)
//   String appRegistrationStep;
//   @JsonKey(defaultValue: 0)
//   int registrationStatus;
//   DateTime couplingCompletedTime;
//   DateTime deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

// */
// /*  List<Purchaseplan> purchasePlan;
//   List<Purchasetopup> purchaseTopup;
//   List<Purchasecoupling> purchaseCoupling;*/ /*


//   UsersBasicDetails({
//     this.id,
//     this.userId,
//     this.profileApprovedBy,
//     this.profileRejectComment,
//     this.profileApprovedAt,
//     this.paymentPlan,
//     this.registeredBy,
//     this.facebookId,
//     this.googleId,
//     this.linkedinId,
//     this.webRegistrationStep,
//     this.appRegistrationStep,
//     this.registrationStatus,
//     this.couplingCompletedTime,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
// */
// /*    this.purchasePlan,
//     this.purchaseTopup,
//     this.purchaseCoupling,*/ /*

//   });

//   @override
//   String toString() {
//     return 'UsersBasicDetails{id: $id, userId: $userId, profileApprovedBy: $profileApprovedBy, profileRejectComment: $profileRejectComment, profileApprovedAt: $profileApprovedAt, paymentPlan: $paymentPlan, registeredBy: $registeredBy, facebookId: $facebookId, googleId: $googleId, linkedinId: $linkedinId, webRegistrationStep: $webRegistrationStep, appRegistrationStep: $appRegistrationStep, registrationStatus: $registrationStatus, couplingCompletedTime: $couplingCompletedTime, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }

//   factory UsersBasicDetails.fromJson(Map<String, dynamic> json) =>
//       _$UsersBasicDetailsFromJson(json);

//   Map<String, dynamic> toJson() => _$UsersBasicDetailsToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Mom {
//   int id;
//   int userId;
//   int partnerId;
//   String momType;
//   String momStatus;
//   String message;
//   DateTime deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   DateTime seenAt;
//   DateTime remindAt;
//   DateTime snoozeAt;
//   DateTime actionAt;
//   List<MomHistory> momHistory;

//   Mom({
//     this.id,
//     this.userId,
//     this.partnerId,
//     this.momType,
//     this.momStatus,
//     this.message,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.seenAt,
//     this.remindAt,
//     this.snoozeAt,
//     this.actionAt,
//     this.momHistory,
//   });

//   factory Mom.fromJson(Map<String, dynamic> json) => _$MomFromJson(json);

//   Map<String, dynamic> toJson() => _$MomToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class MomHistory {
//   int id;
//   int userId;
//   int partnerId;
//   int momId;
//   String momType;
//   String momStatus;
//   String message;
//   String adminMessage;
//   int userHide;
//   int partnerHide;
//   DateTime seenAt;
//   DateTime remindAt;
//   DateTime snoozeAt;
//   DateTime actionAt;
//   dynamic actionCount;
//   String statusPosition;
//   DateTime viewAt;
//   DateTime deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   MomHistory({
//     this.id,
//     this.userId,
//     this.partnerId,
//     this.momId,
//     this.momType,
//     this.momStatus,
//     this.message,
//     this.adminMessage,
//     this.userHide,
//     this.partnerHide,
//     this.seenAt,
//     this.remindAt,
//     this.snoozeAt,
//     this.actionAt,
//     this.actionCount,
//     this.statusPosition,
//     this.viewAt,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory MomHistory.fromJson(Map<String, dynamic> json) =>
//       _$MomHistoryFromJson(json);

//   Map<String, dynamic> toJson() => _$MomHistoryToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class RecomendCount {
//   int id;
//   String value;
//   int count;

//   RecomendCount({
//     this.id,
//     this.value,
//     this.count,
//   });

//   factory RecomendCount.fromJson(Map<String, dynamic> json) =>
//       _$RecomendCountFromJson(json);

//   Map<String, dynamic> toJson() => _$RecomendCountToJson(this);
// }

// */
// /*class Location {
//   Item country = Item(), state = Item(), city = Item();

//   @override
//   String toString() {
//     return 'Location{country: $country, state: $state, city: $city}';
//   }
// }*/ /*


// class Religious {
//   bool isSelected;
//   String religion = '',
//       caste = 'Caste (Optional)',
//       subCaste = 'Sub Caste (Optional)',
//       gothram = 'Gothram (Optional)';
//   String imagePath, name, other;
//   int id;
//   List<BaseSettings> castItem;

//   Religious.initial();

//   Religious({
//     this.isSelected,
//     this.id,
//     this.imagePath,
//     this.name,
//     this.castItem,
//     this.other,
//   });

//   @override
//   String toString() {
//     return 'Religious{isSelected: $isSelected, religion: $religion, Caste: $caste, subCaste: $subCaste, gothram: $gothram, imagePath: $imagePath, name: $name, id: $id, other: $other, castItem: $castItem}';
//   }
// }

// class TOLInfo {
//   Item country = Item(), state = Item(), city = Item();
//   String address, pincode;
//   int isTolActive;

//   TOLInfo(
//       {this.country,
//       this.state,
//       this.city,
//       this.address = "",
//       this.pincode = "",
//       this.isTolActive = 0});

//   @override
//   String toString() {
//     return 'TOL{country: $country, state: $state, city: $city, address: $address, pincode: $pincode, isTolActive: $isTolActive}';
//   }
// }

// class PhotoModel {
//   int id;
//   bool isProPic, isDelete = false;
//   String imgName;
//   File profileImageFile;
//   String networkImgUrl;
//   int photoType, photoTaken;
//   String photoTypeName, photoTakenName;
//   DateTime createdAt;

//   PhotoModel({
//     this.id = -1,
//     this.isProPic = false,
//     this.imgName,
//     this.profileImageFile,
//     this.networkImgUrl = "",
//     this.photoType = 0,
//     this.photoTaken = 0,
//     this.photoTypeName = "",
//     this.photoTakenName = "",
//     this.createdAt,
//   });

//   Map<String, dynamic> toJsonEdit() {
//     final Map<String, dynamic> data = Map();
//     data['type'] = "edit";
//     data['id'] = this.id;
//     data['image_type'] = this.photoType;
//     data['dp_status'] = this.isProPic ? 1 : 0;
//     data['image_taken'] = this.photoTaken;
//     print("image_type------------------------");
//     print(data);
//     return data;
//   }

//   Map<String, dynamic> toJsonAdd({bool isFacebook = false}) {
//     final Map<String, dynamic> data = Map();
//     final Map<String, String> fields = Map();
//     fields['type'] = "add";
//     fields['from_type'] = isFacebook ? "facebook" : "gallery";
//     fields['dp_status'] = this.isProPic ? "1" : "0";
//     fields['image_type'] = this.photoType.toString();
//     fields['image_taken'] = this.photoTaken.toString();
//     data["fields"] = fields;
//     data["file"] = {"photo": this.profileImageFile};
//     print("image_type------------------------");
//     print(data);
//     return data;
//   }

//   String getPhotoT() {
//     if (photoType == 0) {
//       return 'Add Picture';
//     } else {
//       return photoTypeName;
//     }
//   }

//   String getPhotoTn() {
//     return photoTakenName;
//   }

//   @override
//   String toString() {
//     return 'PhotoModel{id: $id, isProPic: $isProPic, photoType: $photoType, photoTaken: $photoTaken, photoTypeName: $photoTypeName, photoTakenName: $photoTakenName}';
//   }

// */
// /*, isProPic: $isProPic, isDelete: $isDelete, imgName: $imgName, imageFile: $profileImageFile, networkImgUrl: $networkImgUrl, photoT: $photoT, photoTn: $photoTn, photoT1: $photoT1, photoTn1: $photoTn1*/ /*


// */
// /* *index: $index,*/ /*

// }

// class QuestionsInput {
//   String questionId, answer;
//   List<int> multiAnswer;

//   QuestionsInput({this.questionId, this.answer, this.multiAnswer});

//   @override
//   String toString() {
//     return 'CouplingQuestions{questionId: $questionId, answer: $answer, multiAnswer: $multiAnswer}';
//   }
// }
// */
