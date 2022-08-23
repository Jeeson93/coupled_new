/*
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('ProfileModel', json, () {
    final val = ProfileModel(
      response: $checkedConvert(
          json,
          'response',
          (v) => v == null
              ? null
              : ProfileResponse.fromJson(v as Map<String, dynamic>)),
      code: $checkedConvert(json, 'code', (v) => v as int) ?? 0,
    );
    $checkedConvert(json, 'status', (v) => val.status = v as String ?? '');
    return val;
  });
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
      'code': instance.code,
    };

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) {
  return ProfileResponse(
    passwordStatus: json['password_status'] as bool ?? true,
    id: json['id'] as int ?? 0,
    name: json['name'] as String ?? '',
    lastName: json['last_name'] as String ?? '',
    membershipCode: json['membership_code'] as String ?? '',
    gender: json['gender'] as String ?? 'male',
    profilePic: json['profile_pic'] as String ?? '',
    emailVerification: json['email_verification'] as int ?? 0,
    mobileVerification: json['mobile_verification'] as int ?? 0,
    isActive: json['is_active'] as int ?? 0,
    lastActive: json['last_active'] == null
        ? null
        : DateTime.parse(json['last_active'] as String),
    hideAt: json['hide_at'],
    membership: json['membership'] == null
        ? null
        : Membership.fromJson(json['membership'] as Map<String, dynamic>),
    userEmail: json['user_email'] as String ?? '',
    currentCsStatistics: json['current_cs_statistics'] == null
        ? null
        : CouplingScoreStatisticsS.fromJson(
            json['current_cs_statistics'] as Map<String, dynamic>),
    userPhone: json['user_phone'] as String ?? '',
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    educationJob: json['education_job'] == null
        ? null
        : EducationJobResponse.fromJson(
            json['education_job'] as Map<String, dynamic>),
    family: json['family'] == null
        ? null
        : FamilyResponse.fromJson(json['family'] as Map<String, dynamic>),
    mom: json['mom'] == null
        ? null
        : Mom.fromJson(json['mom'] as Map<String, dynamic>),
    blockMe: json['block_me'] == null
        ? null
        : Mom.fromJson(json['block_me'] as Map<String, dynamic>),
    reportMe: json['report_me'] == null
        ? null
        : Mom.fromJson(json['report_me'] as Map<String, dynamic>),
    shortlistByMe: json['shortlist_by_me'] == null
        ? null
        : Mom.fromJson(json['shortlist_by_me'] as Map<String, dynamic>),
    shortlistMe: json['shortlist_me'] == null
        ? null
        : Mom.fromJson(json['shortlist_me'] as Map<String, dynamic>),
    freeCoupling: (json['free_coupling'] as List)
        ?.map((e) =>
            e == null ? null : FreeCoupling.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    info: json['info'] == null
        ? null
        : InfoResponse.fromJson(json['info'] as Map<String, dynamic>),
    officialDocuments: json['official_documents'] == null
        ? null
        : OfficialDocuments.fromJson(
            json['official_documents'] as Map<String, dynamic>),
    photos: (json['photos'] as List)
        ?.map((e) => e == null
            ? null
            : PhotoResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dp: json['dp'] == null
        ? null
        : PhotoResponse.fromJson(json['dp'] as Map<String, dynamic>),
    preference: json['preference'] == null
        ? null
        : Preference.fromJson(json['preference'] as Map<String, dynamic>),
    usersBasicDetails: json['users_basic_details'] == null
        ? null
        : UsersBasicDetails.fromJson(
            json['users_basic_details'] as Map<String, dynamic>),
    siblings: (json['siblings'] as List)
        ?.map((e) => e == null
            ? null
            : SiblingResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    userCoupling: (json['user_coupling'] as List)
        ?.map((e) =>
            e == null ? null : UserCoupling.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    chatCount: json['chat_count'] as int ?? 0,
    recommendGiven: json['recommend_given'] as int ?? 0,
    recommendReceived: json['recommend_received'] as int ?? 0,
  )
    ..totalCredits = json['total_credits'] as int ?? 0
    ..pendingCredits = json['pending_credits'] as int ?? 0
    ..planExpiry = json['plan_expiry'] == null
        ? null
        : DateTime.parse(json['plan_expiry'] as String)
    ..recomendCause = (json['recomend_cause'] as List)
        ?.map((e) => e == null
            ? null
            : RecomendCause.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..recomendCauseCount = json['recomend_cause_count'] as int ?? 0
    ..score = json['score'] as int ?? 0;
}

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'password_status': instance.passwordStatus,
      'id': instance.id,
      'name': instance.name,
      'last_name': instance.lastName,
      'membership_code': instance.membershipCode,
      'gender': instance.gender,
      'profile_pic': instance.profilePic,
      'email_verification': instance.emailVerification,
      'mobile_verification': instance.mobileVerification,
      'total_credits': instance.totalCredits,
      'pending_credits': instance.pendingCredits,
      'plan_expiry': instance.planExpiry?.toIso8601String(),
      'membership': instance.membership?.toJson(),
      'is_active': instance.isActive,
      'last_active': instance.lastActive?.toIso8601String(),
      'hide_at': instance.hideAt,
      'user_email': instance.userEmail,
      'user_phone': instance.userPhone,
      'address': instance.address?.toJson(),
      'education_job': instance.educationJob?.toJson(),
      'family': instance.family?.toJson(),
      'mom': instance.mom?.toJson(),
      'block_me': instance.blockMe?.toJson(),
      'report_me': instance.reportMe?.toJson(),
      'current_cs_statistics': instance.currentCsStatistics?.toJson(),
      'shortlist_by_me': instance.shortlistByMe?.toJson(),
      'shortlist_me': instance.shortlistMe?.toJson(),
      'free_coupling': instance.freeCoupling?.map((e) => e?.toJson())?.toList(),
      'recomend_cause':
          instance.recomendCause?.map((e) => e?.toJson())?.toList(),
      'recomend_cause_count': instance.recomendCauseCount,
      'chat_count': instance.chatCount,
      'info': instance.info?.toJson(),
      'official_documents': instance.officialDocuments?.toJson(),
      'photos': instance.photos?.map((e) => e?.toJson())?.toList(),
      'dp': instance.dp?.toJson(),
      'preference': instance.preference?.toJson(),
      'users_basic_details': instance.usersBasicDetails?.toJson(),
      'siblings': instance.siblings?.map((e) => e?.toJson())?.toList(),
      'user_coupling': instance.userCoupling?.map((e) => e?.toJson())?.toList(),
      'recommend_given': instance.recommendGiven,
      'recommend_received': instance.recommendReceived,
      'score': instance.score,
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    id: json['id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    addressType: json['address_type'],
    countryCode: json['country_code'] as String ?? '',
    country: json['country'] as String ?? '',
    state: json['state'] as String ?? '',
    city: json['city'] as String ?? '',
    locationId: json['location_id'] as int ?? 0,
    address: json['address'] as String ?? '',
    pincode: json['pincode'] as int ?? 0,
    tolStatus: json['tol_status'] as int ?? 0,
    presentAddress: json['present_address'] as int ?? 0,
    deletedAt: json['deleted_at'] == null
        ? null
        : DateTime.parse(json['deleted_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'address_type': instance.addressType,
      'country_code': instance.countryCode,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'location_id': instance.locationId,
      'address': instance.address,
      'pincode': instance.pincode,
      'tol_status': instance.tolStatus,
      'present_address': instance.presentAddress,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

PhotoResponse _$PhotoResponseFromJson(Map<String, dynamic> json) {
  return PhotoResponse(
    id: json['id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    photoName: json['photo_names'] as String ?? '',
    fromType: json['from_type'] as String ?? '',
    imageType: json['image_type'] == null
        ? null
        : Data.fromJson(json['image_type'] as Map<String, dynamic>),
    approvedBy: json['approved_by'],
    photoApprovedAt: json['photo_approved_at'] == null
        ? null
        : DateTime.parse(json['photo_approved_at'] as String),
    comments: json['comments'],
    trash: json['trash'] as int ?? 0,
    imageTaken: json['image_taken'] == null
        ? null
        : Data.fromJson(json['image_taken'] as Map<String, dynamic>),
    dpStatus: json['dp_status'] as int ?? 0,
    sortOrder: json['sort_order'] as int ?? 0,
    deletedAt: json['deleted_at'],
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    userDetail: json['user_detail'] == null
        ? null
        : UserDetail.fromJson(json['user_detail'] as Map<String, dynamic>),
  )..status = json['status'] as int ?? 0;
}

Map<String, dynamic> _$PhotoResponseToJson(PhotoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'photo_names': instance.photoName,
      'from_type': instance.fromType,
      'image_type': instance.imageType?.toJson(),
      'status': instance.status,
      'approved_by': instance.approvedBy,
      'photo_approved_at': instance.photoApprovedAt?.toIso8601String(),
      'comments': instance.comments,
      'trash': instance.trash,
      'image_taken': instance.imageTaken?.toJson(),
      'dp_status': instance.dpStatus,
      'sort_order': instance.sortOrder,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user_detail': instance.userDetail?.toJson(),
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['id'] as int ?? 0,
    type: json['type'] as String ?? '',
    value: json['value'] as String ?? '',
    parentId: json['parent_id'] as int ?? 0,
    others: json['others'] as String ?? '',
    isSelected: json['is_selected'] as bool,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'parent_id': instance.parentId,
      'others': instance.others,
      'is_selected': instance.isSelected,
    };

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) {
  return UserDetail(
    id: json['id'] as int ?? 0,
    name: json['name'] as String ?? '',
    lastName: json['last_name'] as String ?? '',
    membershipCode: json['membership_code'] as String ?? '',
    gender: json['gender'] as String ?? '',
    profilePic: json['profile_pic'] as String ?? '',
    emailVerification: json['email_verification'] as int ?? 0,
    mobileVerification: json['mobile_verification'] as int ?? 0,
    isActive: json['is_active'] as int ?? 0,
    lastActive: json['last_active'] == null
        ? null
        : DateTime.parse(json['last_active'] as String),
    hideAt: json['hide_at'] == null
        ? null
        : DateTime.parse(json['hide_at'] as String),
  );
}

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'last_name': instance.lastName,
      'membership_code': instance.membershipCode,
      'gender': instance.gender,
      'profile_pic': instance.profilePic,
      'email_verification': instance.emailVerification,
      'mobile_verification': instance.mobileVerification,
      'is_active': instance.isActive,
      'last_active': instance.lastActive?.toIso8601String(),
      'hide_at': instance.hideAt?.toIso8601String(),
    };

EducationJobResponse _$EducationJobResponseFromJson(Map<String, dynamic> json) {
  return EducationJobResponse(
    id: json['id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    linkedInStatus: json['linked_in_status'],
    jobStatus: json['job_status'] as int ?? 0,
    companyName: json['company_name'] as String ?? '',
    industry: json['industry'] == null
        ? null
        : Data.fromJson(json['industry'] as Map<String, dynamic>),
    profession: json['profession'] == null
        ? null
        : Data.fromJson(json['profession'] as Map<String, dynamic>),
    experience: json['experience'] == null
        ? null
        : Data.fromJson(json['experience'] as Map<String, dynamic>),
    highestEducation: json['highest_education'] == null
        ? null
        : Data.fromJson(json['highest_education'] as Map<String, dynamic>),
    educationBranch: json['education_branch'] == null
        ? null
        : Data.fromJson(json['education_branch'] as Map<String, dynamic>),
    incomeRange: json['income_range'] == null
        ? null
        : Data.fromJson(json['income_range'] as Map<String, dynamic>),
    deletedAt: json['deleted_at'] == null
        ? null
        : DateTime.parse(json['deleted_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$EducationJobResponseToJson(
        EducationJobResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'linked_in_status': instance.linkedInStatus,
      'job_status': instance.jobStatus,
      'company_name': instance.companyName,
      'industry': instance.industry?.toJson(),
      'profession': instance.profession?.toJson(),
      'experience': instance.experience?.toJson(),
      'highest_education': instance.highestEducation?.toJson(),
      'education_branch': instance.educationBranch?.toJson(),
      'income_range': instance.incomeRange?.toJson(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

Membership _$MembershipFromJson(Map<String, dynamic> json) {
  return Membership(
    paidMember: json['paid_member'] as bool,
    planName: json['plan_name'] as String,
    chat: json['chat'] as int,
    statistics: json['statistics'] as int,
    share: json['share'] as int,
    verificationBadge: json['verification_badge'] as int,
    expiredAt: json['expired_at'] == null
        ? null
        : DateTime.parse(json['expired_at'] as String),
  );
}

Map<String, dynamic> _$MembershipToJson(Membership instance) =>
    <String, dynamic>{
      'paid_member': instance.paidMember,
      'plan_name': instance.planName,
      'chat': instance.chat,
      'statistics': instance.statistics,
      'share': instance.share,
      'verification_badge': instance.verificationBadge,
      'expired_at': instance.expiredAt?.toIso8601String(),
    };

FamilyResponse _$FamilyResponseFromJson(Map<String, dynamic> json) {
  return FamilyResponse(
    id: json['id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    fatherName: json['father_name'] as String,
    fatherOccupationStatus: json['father_occupation_status'] == null
        ? null
        : Data.fromJson(
            json['father_occupation_status'] as Map<String, dynamic>),
    motherName: json['mother_name'] as String,
    motherOccupationStatus: json['mother_occupation_status'] == null
        ? null
        : Data.fromJson(
            json['mother_occupation_status'] as Map<String, dynamic>),
    familyType: json['family_type'] == null
        ? null
        : Data.fromJson(json['family_type'] as Map<String, dynamic>),
    familyValues: json['family_values'] == null
        ? null
        : Data.fromJson(json['family_values'] as Map<String, dynamic>),
    religion: json['religion'] == null
        ? null
        : Data.fromJson(json['religion'] as Map<String, dynamic>),
    cast: json['cast'] == null
        ? null
        : Data.fromJson(json['cast'] as Map<String, dynamic>),
    subcast: json['subcast'] == null
        ? null
        : Data.fromJson(json['subcast'] as Map<String, dynamic>),
    gothram: json['gothram'] == null
        ? null
        : Data.fromJson(json['gothram'] as Map<String, dynamic>),
    countryCode: json['country_code'] as String ?? '',
    country: json['country'] as String ?? '',
    state: json['state'] as String ?? '',
    city: json['city'] as String ?? '',
    locationId: json['location_id'] as int ?? 0,
    deletedAt: json['deleted_at'] == null
        ? null
        : DateTime.parse(json['deleted_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$FamilyResponseToJson(FamilyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'father_name': instance.fatherName,
      'father_occupation_status': instance.fatherOccupationStatus?.toJson(),
      'mother_name': instance.motherName,
      'mother_occupation_status': instance.motherOccupationStatus?.toJson(),
      'family_type': instance.familyType?.toJson(),
      'family_values': instance.familyValues?.toJson(),
      'religion': instance.religion?.toJson(),
      'cast': instance.cast?.toJson(),
      'subcast': instance.subcast?.toJson(),
      'gothram': instance.gothram?.toJson(),
      'country_code': instance.countryCode,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'location_id': instance.locationId,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

InfoResponse _$InfoResponseFromJson(Map<String, dynamic> json) {
  return InfoResponse(
    id: json['id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    dobStatus: json['dob_status'] as int ?? 0,
    dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
    height: json['height'] as int ?? 0,
    weight: json['weight'] as int ?? 0,
    bodyType: json['body_type'] == null
        ? null
        : Data.fromJson(json['body_type'] as Map<String, dynamic>),
    complexion: json['complexion'] == null
        ? null
        : Data.fromJson(json['complexion'] as Map<String, dynamic>),
    specialCase: json['special_case'] as int ?? 0,
    specialCaseType: json['special_case_type'] == null
        ? null
        : Data.fromJson(json['special_case_type'] as Map<String, dynamic>),
    specialCaseNotify: json['special_case_notify'] as int ?? 0,
    adminApprovalStatus: json['admin_approval_status'] as int ?? 0,
    countryCode: json['country_code'] as String ?? '',
    country: json['country'] as String ?? '',
    state: json['state'] as String ?? '',
    city: json['city'] as String ?? '',
    locationId: json['location_id'] as int ?? 0,
    maritalStatus: json['marital_status'] == null
        ? null
        : Data.fromJson(json['marital_status'] as Map<String, dynamic>),
    numberOfChildren: json['number_of_children'] as int ?? 0,
    childLivingStatus: json['child_living_status'] == null
        ? null
        : Data.fromJson(json['child_living_status'] as Map<String, dynamic>),
    bornPlace: json['born_place'] as String ?? '',
    bornTime: json['born_time'] as String ?? '',
    aboutSelf: json['about_self'] as String ?? '',
    aboutPartner: json['about_partner'] as String ?? '',
    completedStatus: json['completed_status'],
    completedIn: json['completed_in'],
    deletedAt: json['deleted_at'] == null
        ? null
        : DateTime.parse(json['deleted_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$InfoResponseToJson(InfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'dob': instance.dob?.toIso8601String(),
      'dob_status': instance.dobStatus,
      'height': instance.height,
      'weight': instance.weight,
      'body_type': instance.bodyType?.toJson(),
      'complexion': instance.complexion?.toJson(),
      'special_case': instance.specialCase,
      'special_case_type': instance.specialCaseType?.toJson(),
      'special_case_notify': instance.specialCaseNotify,
      'admin_approval_status': instance.adminApprovalStatus,
      'country_code': instance.countryCode,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'location_id': instance.locationId,
      'marital_status': instance.maritalStatus?.toJson(),
      'number_of_children': instance.numberOfChildren,
      'child_living_status': instance.childLivingStatus?.toJson(),
      'born_place': instance.bornPlace,
      'born_time': instance.bornTime,
      'about_self': instance.aboutSelf,
      'about_partner': instance.aboutPartner,
      'completed_status': instance.completedStatus,
      'completed_in': instance.completedIn,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

OfficialDocuments _$OfficialDocumentsFromJson(Map<String, dynamic> json) {
  return OfficialDocuments(
    id: json['id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    govtIdType: json['govt_id_type'] as int ?? 0,
    govtIdFront: json['govt_id_front'],
    govtIdBack: json['govt_id_back'],
    govtIdStatus: json['govt_id_status'] as int ?? 0,
    govtIdApprovedBy: json['govt_id_approved_by'],
    govtIdRejectComments: json['govt_id_reject_comments'],
    govtIdApprovedAt: json['govt_id_approved_at'],
    officeId: json['office_id'],
    officeIdStatus: json['office_id_status'] as int ?? 0,
    officeIdApprovedBy: json['office_id_approved_by'],
    officeIdRejectComments: json['office_id_reject_comments'],
    officeIdApprovedAt: json['office_id_approved_at'],
    linkedinId: json['linkedin_id'],
    linkedinIdStatus: json['linkedin_id_status'] as int ?? 0,
    deletedAt: json['deleted_at'],
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$OfficialDocumentsToJson(OfficialDocuments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'govt_id_type': instance.govtIdType,
      'govt_id_front': instance.govtIdFront,
      'govt_id_back': instance.govtIdBack,
      'govt_id_status': instance.govtIdStatus,
      'govt_id_approved_by': instance.govtIdApprovedBy,
      'govt_id_reject_comments': instance.govtIdRejectComments,
      'govt_id_approved_at': instance.govtIdApprovedAt,
      'office_id': instance.officeId,
      'office_id_status': instance.officeIdStatus,
      'office_id_approved_by': instance.officeIdApprovedBy,
      'office_id_reject_comments': instance.officeIdRejectComments,
      'office_id_approved_at': instance.officeIdApprovedAt,
      'linkedin_id': instance.linkedinId,
      'linkedin_id_status': instance.linkedinIdStatus,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

Preference _$PreferenceFromJson(Map<String, dynamic> json) {
  return Preference(
    id: json['id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    preferenceType: json['preference_type'],
    ageMin: json['age_min'] as int ?? 0,
    ageMax: json['age_max'] as int ?? 0,
    heightMin: json['height_min'] as int ?? 0,
    heightMax: json['height_max'] as int ?? 0,
    weightMin: json['weight_min'] as int ?? 0,
    weightMax: json['weight_max'] as int ?? 0,
    bodyType: json['body_type'] == null
        ? null
        : Data.fromJson(json['body_type'] as Map<String, dynamic>),
    complexion: json['complexion'] == null
        ? null
        : Data.fromJson(json['complexion'] as Map<String, dynamic>),
    countryCode: json['country_code'] as String ?? '',
    country: json['country'],
    state: json['state'],
    city: json['city'],
    locationId: json['location_id'] as int ?? 0,
    maritalStatus: json['marital_status'] == null
        ? null
        : Data.fromJson(json['marital_status'] as Map<String, dynamic>),
    specialcase: json['specialcase'] == null
        ? null
        : Data.fromJson(json['specialcase'] as Map<String, dynamic>),
    religion: json['religion'] == null
        ? null
        : Data.fromJson(json['religion'] as Map<String, dynamic>),
    cast: json['cast'] == null
        ? null
        : Data.fromJson(json['cast'] as Map<String, dynamic>),
    subCast: json['sub_cast'] == null
        ? null
        : Data.fromJson(json['sub_cast'] as Map<String, dynamic>),
    gothram: json['gothram'] == null
        ? null
        : Data.fromJson(json['gothram'] as Map<String, dynamic>),
    fatherOccupationStatus: json['father_occupation_status'] == null
        ? null
        : Data.fromJson(
            json['father_occupation_status'] as Map<String, dynamic>),
    motherOccupationStatus: json['mother_occupation_status'] == null
        ? null
        : Data.fromJson(
            json['mother_occupation_status'] as Map<String, dynamic>),
    sibling: json['sibling'],
    familyCountryCode: json['family_country_code'] as String ?? '',
    familyCountry: json['family_country'],
    familyState: json['family_state'],
    familyCity: json['family_city'],
    familyLocationId: json['family_location_id'] as int ?? 0,
    familyType: json['family_type'] == null
        ? null
        : Data.fromJson(json['family_type'] as Map<String, dynamic>),
    familyValues: json['family_values'] == null
        ? null
        : Data.fromJson(json['family_values'] as Map<String, dynamic>),
    occupation: json['occupation'] == null
        ? null
        : Data.fromJson(json['occupation'] as Map<String, dynamic>),
    profession: json['profession'] == null
        ? null
        : Data.fromJson(json['profession'] as Map<String, dynamic>),
    designation: json['designation'] == null
        ? null
        : Data.fromJson(json['designation'] as Map<String, dynamic>),
    workingExperience: json['working_experience'],
    education: json['education'] == null
        ? null
        : Data.fromJson(json['education'] as Map<String, dynamic>),
    incomeRange: json['income_range'],
    saveAs: json['save_as'],
    deletedAt: json['deleted_at'] == null
        ? null
        : DateTime.parse(json['deleted_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'preference_type': instance.preferenceType,
      'age_min': instance.ageMin,
      'age_max': instance.ageMax,
      'height_min': instance.heightMin,
      'height_max': instance.heightMax,
      'weight_min': instance.weightMin,
      'weight_max': instance.weightMax,
      'body_type': instance.bodyType?.toJson(),
      'complexion': instance.complexion?.toJson(),
      'country_code': instance.countryCode,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'location_id': instance.locationId,
      'marital_status': instance.maritalStatus?.toJson(),
      'specialcase': instance.specialcase?.toJson(),
      'religion': instance.religion?.toJson(),
      'cast': instance.cast?.toJson(),
      'sub_cast': instance.subCast?.toJson(),
      'gothram': instance.gothram?.toJson(),
      'father_occupation_status': instance.fatherOccupationStatus?.toJson(),
      'mother_occupation_status': instance.motherOccupationStatus?.toJson(),
      'sibling': instance.sibling,
      'family_country_code': instance.familyCountryCode,
      'family_country': instance.familyCountry,
      'family_state': instance.familyState,
      'family_city': instance.familyCity,
      'family_location_id': instance.familyLocationId,
      'family_type': instance.familyType?.toJson(),
      'family_values': instance.familyValues?.toJson(),
      'occupation': instance.occupation?.toJson(),
      'profession': instance.profession?.toJson(),
      'designation': instance.designation?.toJson(),
      'working_experience': instance.workingExperience,
      'education': instance.education?.toJson(),
      'income_range': instance.incomeRange,
      'save_as': instance.saveAs,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

FreeCoupling _$FreeCouplingFromJson(Map<String, dynamic> json) {
  return FreeCoupling(
    id: json['id'] as int ?? 0,
    couplingType: json['coupling_type'] as String ?? '',
    type: json['type'] as String ?? '',
    question: json['question'] as String ?? '',
    questionOrder: json['question_order'] as int ?? 0,
    parent: json['parent'] as int ?? 0,
    status: json['status'] as String ?? '',
    deletedAt: json['deleted_at'],
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    score: (json['score'] as num)?.toDouble() ?? 0.0,
    message: json['message'] as String ?? '',
  );
}

Map<String, dynamic> _$FreeCouplingToJson(FreeCoupling instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coupling_type': instance.couplingType,
      'type': instance.type,
      'question': instance.question,
      'question_order': instance.questionOrder,
      'parent': instance.parent,
      'status': instance.status,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'score': instance.score,
      'message': instance.message,
    };

RecomendCause _$RecomendCauseFromJson(Map<String, dynamic> json) {
  return RecomendCause(
    id: json['id'] as int ?? 0,
    value: json['value'] as String ?? '',
    count: json['count'] as int ?? 0,
    checked: json['checked'] as bool ?? false,
  );
}

Map<String, dynamic> _$RecomendCauseToJson(RecomendCause instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'count': instance.count,
      'checked': instance.checked,
    };

CouplingScoreStatisticsS _$CouplingScoreStatisticsSFromJson(
    Map<String, dynamic> json) {
  return CouplingScoreStatisticsS(
    id: json['id'] as int,
    statisticsOption: json['statistics_option'] as String,
    deletedAt: json['deleted_at'],
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    expiredAt: json['expired_at'] == null
        ? null
        : DateTime.parse(json['expired_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$CouplingScoreStatisticsSToJson(
        CouplingScoreStatisticsS instance) =>
    <String, dynamic>{
      'id': instance.id,
      'statistics_option': instance.statisticsOption,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'expired_at': instance.expiredAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

Purchasetopup _$PurchasetopupFromJson(Map<String, dynamic> json) {
  return Purchasetopup(
    id: json['id'] as int ?? 0,
    purchasePlanId: json['purchase_plan_id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    purchaseTopupId: json['purchase_topup_id'] as int ?? 0,
    topupType: json['topup_type'] as String ?? '',
    amount: json['amount'] as String ?? '',
    validity: json['validity'] as int ?? 0,
    profiles: json['profiles'] as int ?? 0,
    activeAt: json['active_at'] == null
        ? null
        : DateTime.parse(json['active_at'] as String),
    expiredAt: json['expired_at'] == null
        ? null
        : DateTime.parse(json['expired_at'] as String),
    deletedAt: json['deleted_at'] == null
        ? null
        : DateTime.parse(json['deleted_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$PurchasetopupToJson(Purchasetopup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'purchase_plan_id': instance.purchasePlanId,
      'user_id': instance.userId,
      'purchase_topup_id': instance.purchaseTopupId,
      'topup_type': instance.topupType,
      'amount': instance.amount,
      'validity': instance.validity,
      'profiles': instance.profiles,
      'active_at': instance.activeAt?.toIso8601String(),
      'expired_at': instance.expiredAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

SiblingResponse _$SiblingResponseFromJson(Map<String, dynamic> json) {
  return SiblingResponse(
    id: json['id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    siblingName: json['sibling_name'] as String,
    role: json['role'] == null
        ? null
        : Data.fromJson(json['role'] as Map<String, dynamic>),
    profession: json['profession'] == null
        ? null
        : Data.fromJson(json['profession'] as Map<String, dynamic>),
    maritalStatus: json['marital_status'] == null
        ? null
        : Data.fromJson(json['marital_status'] as Map<String, dynamic>),
    deletedAt: json['deleted_at'] == null
        ? null
        : DateTime.parse(json['deleted_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$SiblingResponseToJson(SiblingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'sibling_name': instance.siblingName,
      'role': instance.role?.toJson(),
      'profession': instance.profession?.toJson(),
      'marital_status': instance.maritalStatus?.toJson(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

UserCoupling _$UserCouplingFromJson(Map<String, dynamic> json) {
  return UserCoupling(
    id: json['id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    questionId: json['question_id'] as int ?? 0,
    answer: json['answer'],
    deletedAt: json['deleted_at'],
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$UserCouplingToJson(UserCoupling instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'question_id': instance.questionId,
      'answer': instance.answer,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

UsersBasicDetails _$UsersBasicDetailsFromJson(Map<String, dynamic> json) {
  return UsersBasicDetails(
    id: json['id'] as int ?? 0,
    userId: json['user_id'] as int ?? 0,
    profileApprovedBy: json['profile_approved_by'] == null
        ? null
        : UserDetail.fromJson(
            json['profile_approved_by'] as Map<String, dynamic>),
    profileRejectComment: json['profile_reject_comment'],
    profileApprovedAt: json['profile_approved_at'] == null
        ? null
        : DateTime.parse(json['profile_approved_at'] as String),
    paymentPlan: json['payment_plan'] as int ?? 0,
    registeredBy: json['registered_by'],
    facebookId: json['facebook_id'],
    googleId: json['google_id'],
    linkedinId: json['linkedin_id'],
    webRegistrationStep: json['web_registration_step'] as String ?? '',
    appRegistrationStep: json['app_registration_step'] as String,
    registrationStatus: json['registration_status'] as int ?? 0,
    couplingCompletedTime: json['coupling_completed_time'] == null
        ? null
        : DateTime.parse(json['coupling_completed_time'] as String),
    deletedAt: json['deleted_at'] == null
        ? null
        : DateTime.parse(json['deleted_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$UsersBasicDetailsToJson(UsersBasicDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'profile_approved_by': instance.profileApprovedBy?.toJson(),
      'profile_reject_comment': instance.profileRejectComment,
      'profile_approved_at': instance.profileApprovedAt?.toIso8601String(),
      'payment_plan': instance.paymentPlan,
      'registered_by': instance.registeredBy,
      'facebook_id': instance.facebookId,
      'google_id': instance.googleId,
      'linkedin_id': instance.linkedinId,
      'web_registration_step': instance.webRegistrationStep,
      'app_registration_step': instance.appRegistrationStep,
      'registration_status': instance.registrationStatus,
      'coupling_completed_time':
          instance.couplingCompletedTime?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

Mom _$MomFromJson(Map<String, dynamic> json) {
  return Mom(
    id: json['id'] as int,
    userId: json['user_id'] as int,
    partnerId: json['partner_id'] as int,
    momType: json['mom_type'] as String,
    momStatus: json['mom_status'] as String,
    message: json['message'] as String,
    deletedAt: json['deleted_at'] == null
        ? null
        : DateTime.parse(json['deleted_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    seenAt: json['seen_at'] == null
        ? null
        : DateTime.parse(json['seen_at'] as String),
    remindAt: json['remind_at'] == null
        ? null
        : DateTime.parse(json['remind_at'] as String),
    snoozeAt: json['snooze_at'] == null
        ? null
        : DateTime.parse(json['snooze_at'] as String),
    actionAt: json['action_at'] == null
        ? null
        : DateTime.parse(json['action_at'] as String),
    momHistory: (json['mom_history'] as List)
        ?.map((e) =>
            e == null ? null : MomHistory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MomToJson(Mom instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'partner_id': instance.partnerId,
      'mom_type': instance.momType,
      'mom_status': instance.momStatus,
      'message': instance.message,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'seen_at': instance.seenAt?.toIso8601String(),
      'remind_at': instance.remindAt?.toIso8601String(),
      'snooze_at': instance.snoozeAt?.toIso8601String(),
      'action_at': instance.actionAt?.toIso8601String(),
      'mom_history': instance.momHistory?.map((e) => e?.toJson())?.toList(),
    };

MomHistory _$MomHistoryFromJson(Map<String, dynamic> json) {
  return MomHistory(
    id: json['id'] as int,
    userId: json['user_id'] as int,
    partnerId: json['partner_id'] as int,
    momId: json['mom_id'] as int,
    momType: json['mom_type'] as String,
    momStatus: json['mom_status'] as String,
    message: json['message'] as String,
    adminMessage: json['admin_message'] as String,
    userHide: json['user_hide'] as int,
    partnerHide: json['partner_hide'] as int,
    seenAt: json['seen_at'] == null
        ? null
        : DateTime.parse(json['seen_at'] as String),
    remindAt: json['remind_at'] == null
        ? null
        : DateTime.parse(json['remind_at'] as String),
    snoozeAt: json['snooze_at'] == null
        ? null
        : DateTime.parse(json['snooze_at'] as String),
    actionAt: json['action_at'] == null
        ? null
        : DateTime.parse(json['action_at'] as String),
    actionCount: json['action_count'],
    statusPosition: json['status_position'] as String,
    viewAt: json['view_at'] == null
        ? null
        : DateTime.parse(json['view_at'] as String),
    deletedAt: json['deleted_at'] == null
        ? null
        : DateTime.parse(json['deleted_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$MomHistoryToJson(MomHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'partner_id': instance.partnerId,
      'mom_id': instance.momId,
      'mom_type': instance.momType,
      'mom_status': instance.momStatus,
      'message': instance.message,
      'admin_message': instance.adminMessage,
      'user_hide': instance.userHide,
      'partner_hide': instance.partnerHide,
      'seen_at': instance.seenAt?.toIso8601String(),
      'remind_at': instance.remindAt?.toIso8601String(),
      'snooze_at': instance.snoozeAt?.toIso8601String(),
      'action_at': instance.actionAt?.toIso8601String(),
      'action_count': instance.actionCount,
      'status_position': instance.statusPosition,
      'view_at': instance.viewAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

RecomendCount _$RecomendCountFromJson(Map<String, dynamic> json) {
  return RecomendCount(
    id: json['id'] as int,
    value: json['value'] as String,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$RecomendCountToJson(RecomendCount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'count': instance.count,
    };
*/
