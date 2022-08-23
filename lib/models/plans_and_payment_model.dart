// To parse this JSON data, do
//
//     final plansAndPaymentModel = plansAndPaymentModelFromJson(jsonString);

import 'dart:convert';

MembershipPlansModel plansAndPaymentModelFromJson(String str) =>
    MembershipPlansModel.fromMap(json.decode(str));

String plansAndPaymentModelToJson(MembershipPlansModel data) =>
    json.encode(data.toMap());

class MembershipPlansModel {
  dynamic status;
  PlansAndPaymentResponse? response;
  dynamic code;

  MembershipPlansModel({
    this.status,
    this.response,
    this.code,
  });

  factory MembershipPlansModel.fromMap(Map<String, dynamic> json) =>
      MembershipPlansModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? null
            : PlansAndPaymentResponse.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response!.toMap(),
        "code": code == null ? null : code,
      };
}

class PlansAndPaymentResponse {
  List<Plan>? plans;
  List<ResponseTopup>? topups;
  CouplingScoreStatistics? statistics;

  PlansAndPaymentResponse({
    this.plans,
    this.topups,
    this.statistics,
  });

  factory PlansAndPaymentResponse.fromMap(Map<String, dynamic> json) =>
      PlansAndPaymentResponse(
        plans: json["plans"] == null
            ? null
            : List<Plan>.from(json["plans"].map((x) => Plan.fromMap(x))),
        topups: json["topups"] == null
            ? null
            : List<ResponseTopup>.from(
                json["topups"].map((x) => ResponseTopup.fromMap(x))),
        statistics: json["statistics"] == null
            ? null
            : CouplingScoreStatistics.fromMap(json["statistics"]),
      );

  Map<String, dynamic> toMap() => {
        "plans": plans == null
            ? null
            : List<dynamic>.from(plans!.map((x) => x.toMap())),
        "topups": topups == null
            ? null
            : List<dynamic>.from(topups!.map((x) => x.toMap())),
        "statistics": statistics == null ? null : statistics!.toMap(),
      };
}

class ResponseTopup {
  dynamic id;
  dynamic title;
  dynamic amount;
  dynamic validity;
  dynamic status;
  dynamic createdBy;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  List<PlanTopup>? topup;

  ResponseTopup({
    this.id,
    this.title,
    this.amount,
    this.validity,
    this.status,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.topup,
  });

  factory ResponseTopup.fromMap(Map<String, dynamic> json) => ResponseTopup(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        amount: json["amount"] == null ? null : json["amount"],
        validity: json["validity"] == null ? null : json["validity"],
        status: json["status"] == null ? null : json["status"],
        createdBy: json["created_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        topup: json["topup"] == null
            ? null
            : List<PlanTopup>.from(
                json["topup"].map((x) => PlanTopup.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "amount": amount == null ? null : amount,
        "validity": validity == null ? null : validity,
        "status": status == null ? null : status,
        "created_by": createdBy,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "topup": topup == null
            ? null
            : List<dynamic>.from(topup!.map((x) => x.toMap())),
      };
}

class PlanTopup {
  dynamic id;
  dynamic planId;
  dynamic topupId;
  dynamic profiles;
  dynamic status;
  dynamic createdBy;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isChecked;
  ResponseTopup? topup;
  Plan? plan;

  PlanTopup({
    this.id,
    this.planId,
    this.topupId,
    this.profiles,
    this.status,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isChecked = false,
    this.topup,
    this.plan,
  });

  factory PlanTopup.fromMap(Map<String, dynamic> json) => PlanTopup(
        id: json["id"] == null ? null : json["id"],
        planId: json["plan_id"] == null ? null : json["plan_id"],
        topupId: json["topup_id"] == null ? null : json["topup_id"],
        profiles: json["profiles"] == null ? null : json["profiles"],
        status: json["status"] == null ? null : json["status"],
        createdBy: json["created_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        topup:
            json["topup"] == null ? null : ResponseTopup.fromMap(json["topup"]),
        plan: json["plan"] == null ? null : Plan.fromMap(json["plan"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "plan_id": planId == null ? null : planId,
        "topup_id": topupId == null ? null : topupId,
        "profiles": profiles == null ? null : profiles,
        "status": status == null ? null : status,
        "created_by": createdBy,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "topup": topup == null ? null : topup!.toMap(),
        "plan": plan == null ? null : plan!.toMap(),
      };
}

class Plan {
  dynamic id;
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
  dynamic recommend;
  dynamic profileHighlight;
  dynamic smsAlerts;
  dynamic mailAlerts;
  dynamic icon;
  dynamic status;
  dynamic createdBy;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic expiredAt;
  dynamic updatedAt;
  List<PlanTopup>? topups;
  Plan? plans;

  Plan({
    this.id,
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
    this.recommend,
    this.profileHighlight,
    this.smsAlerts,
    this.mailAlerts,
    this.icon,
    this.status,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.expiredAt,
    this.updatedAt,
    this.topups,
    this.plans,
  });

  factory Plan.fromMap(Map<String, dynamic> json) => Plan(
        id: json["id"] == null ? null : json["id"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        amount: json["amount"] == null ? null : json["amount"],
        profilesCount:
            json["profiles_count"] == null ? null : json["profiles_count"],
        currentProfilesCount: json["current_profiles_count"] == null
            ? null
            : json["current_profiles_count"],
        validity: json["validity"] == null ? '' : json["validity"],
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
        recommend: json["recommend"] == null ? null : json["recommend"],
        profileHighlight: json["profile_highlight"] == null
            ? null
            : json["profile_highlight"],
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
        createdBy: json["created_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        expiredAt: json["expired_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["expired_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        plans: json["plans"] == null ? null : Plan.fromMap(json["plans"]),
        topups: json["topups"] == null
            ? null
            : List<PlanTopup>.from(
                json["topups"].map((x) => PlanTopup.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "plan_name": planName == null ? null : planName,
        "amount": amount == null ? null : amount,
        "profiles_count": profilesCount == null ? null : profilesCount,
        "validity": validity == null ? '' : validity,
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
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "topups": topups == null
            ? null
            : List<dynamic>.from(topups!.map((x) => x.toMap())),
      };
}

class CouplingScoreStatistics {
  dynamic id;
  dynamic activationFee;
  dynamic validity;
  dynamic statisticsOption;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  CouplingScoreStatistics({
    this.id,
    this.activationFee,
    this.validity,
    this.statisticsOption,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory CouplingScoreStatistics.fromMap(Map<String, dynamic> json) =>
      CouplingScoreStatistics(
        id: json["id"] == null ? null : json["id"],
        activationFee:
            json["activation_fee"] == null ? null : json["activation_fee"],
        validity: json["validity"] == null ? null : json["validity"],
        statisticsOption: json["coupling_score_plan_option"] == null
            ? null
            : json["coupling_score_plan_option"],
        status: json["status"] == null ? null : json["status"],
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
        "activation_fee": activationFee == null ? null : activationFee,
        "validity": validity == null ? null : validity,
        "coupling_score_plan_option":
            statisticsOption == null ? null : statisticsOption,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final myPlansAndPaymentModel = myPlansAndPaymentModelFromJson(jsonString);

MyPlansAndPaymentModel myPlansAndPaymentModelFromJson(String str) =>
    MyPlansAndPaymentModel.fromMap(json.decode(str));

String myPlansAndPaymentModelToJson(MyPlansAndPaymentModel data) =>
    json.encode(data.toMap());

class MyPlansAndPaymentModel {
  dynamic status;
  MyPlansAndPaymentModelResponse response;
  dynamic code;

  MyPlansAndPaymentModel({
    this.status,
    required this.response,
    this.code,
  });

  factory MyPlansAndPaymentModel.fromMap(Map<String, dynamic> json) =>
      MyPlansAndPaymentModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? MyPlansAndPaymentModelResponse.fromMap({})
            : MyPlansAndPaymentModelResponse.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response.toMap(),
        "code": code == null ? null : code,
      };
}

class MyPlansAndPaymentModelResponse {
  Plan activePlan;
  Topup activeTopup;
  Topup upcomingTopup;
  Statistic activeStatistic;
  Statistic upcomingStatistic;
  CouplingScoreStatistics statistics;

  MyPlansAndPaymentModelResponse({
    required this.activePlan,
    required this.activeTopup,
    required this.upcomingTopup,
    required this.activeStatistic,
    required this.upcomingStatistic,
    required this.statistics,
  });

  factory MyPlansAndPaymentModelResponse.fromMap(Map<String, dynamic> json) =>
      MyPlansAndPaymentModelResponse(
        activePlan: json["active_plan"] == null
            ? Plan.fromMap({})
            : Plan.fromMap(json["active_plan"]),
        activeTopup: json["active_topup"] == null
            ? Topup.fromMap({})
            : Topup.fromMap(json["active_topup"]),
        upcomingTopup: json["upcoming_topup"] == null
            ? Topup.fromMap({})
            : Topup.fromMap(json["upcoming_topup"]),
        activeStatistic: json["active_statistic"] == null
            ? Statistic.fromMap({})
            : Statistic.fromMap(json["active_statistic"]),
        upcomingStatistic: json["upcoming_statistic"] == null
            ? Statistic.fromMap({})
            : Statistic.fromMap(json["upcoming_statistic"]),
        statistics: json["statistics"] == null
            ? CouplingScoreStatistics.fromMap({})
            : CouplingScoreStatistics.fromMap(json["statistics"]),
      );

  Map<String, dynamic> toMap() => {
        "active_plan": activePlan == null ? null : activePlan.toMap(),
        "active_topup": activeTopup == null ? null : activeTopup.toMap(),
        "upcoming_topup": upcomingTopup == null ? null : upcomingTopup.toMap(),
        "active_statistic":
            activeStatistic == null ? null : activeStatistic.toMap(),
        "upcoming_statistic":
            upcomingStatistic == null ? null : upcomingStatistic.toMap(),
        "statistics": statistics == null ? null : statistics.toMap(),
      };
}

class Statistic {
  dynamic id;
  dynamic userId;
  dynamic couplingScoreId;
  dynamic activationFee;
  dynamic validity;
  dynamic couplingScorePlanOption;
  dynamic status;
  dynamic activeAt;
  dynamic expiredAt;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  Statistic({
    this.id,
    this.userId,
    this.couplingScoreId,
    this.activationFee,
    this.validity,
    this.couplingScorePlanOption,
    this.status,
    this.activeAt,
    this.expiredAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Statistic.fromMap(Map<String, dynamic> json) => Statistic(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        couplingScoreId: json["coupling_score_id"] == null
            ? null
            : json["coupling_score_id"],
        activationFee:
            json["activation_fee"] == null ? null : json["activation_fee"],
        validity: json["validity"] == null ? null : json["validity"],
        couplingScorePlanOption: json["coupling_score_plan_option"] == null
            ? null
            : json["coupling_score_plan_option"],
        status: json["status"] == null ? null : json["status"],
        activeAt: json["active_at"] == null
            ? null
            : DateTime.parse(json["active_at"]),
        expiredAt: json["expired_at"] == null
            ? DateTime.now()
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
        "coupling_score_id": couplingScoreId == null ? null : couplingScoreId,
        "activation_fee": activationFee == null ? null : activationFee,
        "validity": validity == null ? null : validity,
        "coupling_score_plan_option":
            couplingScorePlanOption == null ? null : couplingScorePlanOption,
        "status": status == null ? null : status,
        "active_at": activeAt,
        "expired_at": expiredAt == null ? null : expiredAt.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Topup {
  dynamic id;
  dynamic purchasePlanId;
  dynamic userId;
  dynamic purchaseTopupId;
  dynamic topupType;
  dynamic amount;
  dynamic validity;
  dynamic profiles;
  dynamic currentProfiles;
  dynamic bonusProfiles;
  dynamic bonusCurrentProfiles;
  dynamic status;
  dynamic activeAt;
  dynamic expiredAt;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  Topup({
    this.id,
    this.purchasePlanId,
    this.userId,
    this.purchaseTopupId,
    this.topupType,
    this.amount,
    this.validity,
    this.profiles,
    this.currentProfiles,
    this.bonusProfiles,
    this.bonusCurrentProfiles,
    this.status,
    this.activeAt,
    this.expiredAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Topup.fromMap(Map<String, dynamic> json) => Topup(
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
        currentProfiles:
            json["current_profiles"] == null ? 0 : json["current_profiles"],
        bonusProfiles:
            json["bonus_profiles"] == null ? 0 : json["bonus_profiles"],
        bonusCurrentProfiles: json["bonus_current_profiles"] == null
            ? 0
            : json["bonus_current_profiles"],
        status: json["status"] == null ? null : json["status"],
        activeAt: json["active_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["active_at"]),
        expiredAt: json["expired_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["expired_at"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
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
        "current_profiles": currentProfiles == null ? null : currentProfiles,
        "status": status == null ? null : status,
        "active_at": activeAt,
        "expired_at": expiredAt == null ? null : expiredAt.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
