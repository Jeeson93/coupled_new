// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromMap(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromMap(String str) =>
    TransactionModel.fromMap(json.decode(str));

String transactionModelToMap(TransactionModel data) =>
    json.encode(data.toMap());

class TransactionModel {
  TransactionModel({
    this.status,
    required this.response,
    this.code,
  });

  dynamic status;
  List<TransactionResponse> response;
  dynamic code;

  factory TransactionModel.fromMap(Map<String, dynamic> json) =>
      TransactionModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? []
            : List<TransactionResponse>.from(
                json["response"].map((x) => TransactionResponse.fromMap(x))),
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

class TransactionResponse {
  TransactionResponse({
    this.id,
    this.transactionId,
    this.userId,
    this.entity,
    this.amount,
    this.currency,
    this.status,
    this.type,
    this.orderId,
    this.invoiceId,
    this.international,
    this.method,
    this.amountRefunded,
    this.refundStatus,
    this.captured,
    this.description,
    this.cardId,
    this.bank,
    this.wallet,
    this.vpa,
    this.email,
    this.contact,
    this.notes,
    this.fee,
    this.tax,
    this.errorCode,
    this.errorDescription,
    this.transactionCreatedAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.transactionDetails,
  });

  dynamic id;
  dynamic transactionId;
  dynamic userId;
  dynamic entity;
  dynamic amount;
  dynamic currency;
  dynamic status;
  dynamic type;
  dynamic orderId;
  dynamic invoiceId;
  dynamic international;
  dynamic method;
  dynamic amountRefunded;
  dynamic refundStatus;
  dynamic captured;
  dynamic description;
  dynamic cardId;
  dynamic bank;
  dynamic wallet;
  dynamic vpa;
  dynamic email;
  dynamic contact;
  dynamic notes;
  dynamic fee;
  dynamic tax;
  dynamic errorCode;
  dynamic errorDescription;
  dynamic transactionCreatedAt;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic transactionDetails;

  factory TransactionResponse.fromMap(Map<String, dynamic> json) =>
      TransactionResponse(
        id: json["id"] == null ? null : json["id"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        entity: json["entity"] == null ? null : json["entity"],
        amount: json["amount"] == null ? null : json["amount"],
        currency: json["currency"] == null ? null : json["currency"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        orderId: json["order_id"],
        invoiceId: json["invoice_id"],
        international:
            json["international"] == null ? null : json["international"],
        method: json["method"] == null ? null : json["method"],
        amountRefunded:
            json["amount_refunded"] == null ? null : json["amount_refunded"],
        refundStatus: json["refund_status"],
        captured: json["captured"] == null ? null : json["captured"],
        description: json["description"] == null ? null : json["description"],
        cardId: json["card_id"] == null ? null : json["card_id"],
        bank: json["bank"] == null ? null : json["bank"],
        wallet: json["wallet"],
        vpa: json["vpa"],
        email: json["email"] == null ? null : json["email"],
        contact: json["contact"] == null ? null : json["contact"],
        notes: json["notes"] == null ? null : json["notes"],
        fee: json["fee"],
        tax: json["tax"],
        errorCode: json["error_code"],
        errorDescription: json["error_description"],
        transactionCreatedAt: json["transaction_created_at"] == null
            ? null
            : DateTime.parse(json["transaction_created_at"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        transactionDetails: json["transaction_details"] == null
            ? null
            : List<TransactionDetail>.from(json["transaction_details"]
                .map((x) => TransactionDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "transaction_id": transactionId == null ? null : transactionId,
        "user_id": userId == null ? null : userId,
        "entity": entity == null ? null : entity,
        "amount": amount == null ? null : amount,
        "currency": currency == null ? null : currency,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "order_id": orderId,
        "invoice_id": invoiceId,
        "international": international == null ? null : international,
        "method": method == null ? null : method,
        "amount_refunded": amountRefunded == null ? null : amountRefunded,
        "refund_status": refundStatus,
        "captured": captured == null ? null : captured,
        "description": description == null ? null : description,
        "card_id": cardId == null ? null : cardId,
        "bank": bank == null ? null : bank,
        "wallet": wallet,
        "vpa": vpa,
        "email": email == null ? null : email,
        "contact": contact == null ? null : contact,
        "notes": notes == null ? null : notes,
        "fee": fee,
        "tax": tax,
        "error_code": errorCode,
        "error_description": errorDescription,
        "transaction_created_at": transactionCreatedAt == null
            ? null
            : transactionCreatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "transaction_details": transactionDetails == null
            ? null
            : List<dynamic>.from(transactionDetails.map((x) => x.toMap())),
      };
}

class TransactionDetail {
  TransactionDetail({
    this.id,
    this.userId,
    this.transactionId,
    this.purchasableId,
    this.purchasableType,
    this.type,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.purchasable,
  });

  dynamic id;
  dynamic userId;
  dynamic transactionId;
  dynamic purchasableId;
  dynamic purchasableType;
  dynamic type;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic purchasable;

  factory TransactionDetail.fromMap(Map<String, dynamic> json) =>
      TransactionDetail(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        purchasableId:
            json["purchasable_id"] == null ? null : json["purchasable_id"],
        purchasableType:
            json["purchasable_type"] == null ? null : json["purchasable_type"],
        type: json["type"] == null ? null : json["type"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        purchasable: json["purchasable"] == null
            ? null
            : Purchasable.fromMap(json["purchasable"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "transaction_id": transactionId == null ? null : transactionId,
        "purchasable_id": purchasableId == null ? null : purchasableId,
        "purchasable_type": purchasableType == null ? null : purchasableType,
        "type": type == null ? null : type,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "purchasable": purchasable == null ? null : purchasable.toMap(),
      };
}

class Purchasable {
  Purchasable({
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
    this.couplingScoreId,
    this.activationFee,
    this.couplingScorePlanOption,
    this.activeAt,
    this.purchasePlanId,
    this.purchaseTopupId,
    this.profiles,
    this.currentProfiles,
    this.bonusProfiles,
    this.bonusCurrentProfiles,
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
  dynamic couplingScoreId;
  dynamic activationFee;
  dynamic couplingScorePlanOption;
  dynamic activeAt;
  dynamic purchasePlanId;
  dynamic purchaseTopupId;
  dynamic profiles;
  dynamic currentProfiles;
  dynamic bonusProfiles;
  dynamic bonusCurrentProfiles;

  factory Purchasable.fromMap(Map<String, dynamic> json) => Purchasable(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        planId: json["plan_id"] == null ? null : json["plan_id"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        amount: json["amount"] == null ? null : int.parse(json["amount"]),
        profilesCount:
            json["profiles_count"] == null ? null : json["profiles_count"],
        currentProfilesCount: json["current_profiles_count"] == null
            ? null
            : json["current_profiles_count"],
        validity: json["validity"],
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
        couplingScoreId: json["coupling_score_id"] == null
            ? null
            : json["coupling_score_id"],
        activationFee:
            json["activation_fee"] == null ? null : json["activation_fee"],
        couplingScorePlanOption: json["coupling_score_plan_option"] == null
            ? null
            : json["coupling_score_plan_option"],
        activeAt: json["active_at"] == null
            ? null
            : DateTime.parse(json["active_at"]),
        purchasePlanId:
            json["purchase_plan_id"] == null ? null : json["purchase_plan_id"],
        purchaseTopupId: json["purchase_topup_id"] == null
            ? null
            : json["purchase_topup_id"],
        profiles: json["profiles"] == null ? null : json["profiles"],
        currentProfiles:
            json["current_profiles"] == null ? null : json["current_profiles"],
        bonusProfiles:
            json["bonus_profiles"] == null ? null : json["bonus_profiles"],
        bonusCurrentProfiles: json["bonus_current_profiles"] == null
            ? null
            : json["bonus_current_profiles"],
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
        "validity": validity,
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
        "coupling_score_id": couplingScoreId == null ? null : couplingScoreId,
        "activation_fee": activationFee == null ? null : activationFee,
        "coupling_score_plan_option":
            couplingScorePlanOption == null ? null : couplingScorePlanOption,
        "active_at": activeAt == null ? null : activeAt.toIso8601String(),
        "purchase_plan_id": purchasePlanId == null ? null : purchasePlanId,
        "purchase_topup_id": purchaseTopupId == null ? null : purchaseTopupId,
        "profiles": profiles == null ? null : profiles,
        "current_profiles": currentProfiles == null ? null : currentProfiles,
        "bonus_profiles": bonusProfiles == null ? null : bonusProfiles,
        "bonus_current_profiles":
            bonusCurrentProfiles == null ? null : bonusCurrentProfiles,
      };
}
