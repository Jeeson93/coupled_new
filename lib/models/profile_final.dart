// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'profile_final.g.dart';

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class ProfileResponseFinal extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final dynamic id;
//   @JsonKey(defaultValue: "")
//   final dynamic name;
//   @JsonKey(defaultValue: "")
//   final dynamic lastName;
//   @JsonKey(defaultValue: "")
//   final dynamic membershipCode;
//   @JsonKey(defaultValue: "male")
//   final dynamic gender;
//   @JsonKey(defaultValue: "")
//   final dynamic profilePic;
//   @JsonKey(defaultValue: 0)
//   final dynamic emailVerification;
//   @JsonKey(defaultValue: 0)
//   final dynamic mobileVerification;
//   final dynamic membership;
//   @JsonKey(defaultValue: 0)
//   final dynamic isActive;
//   final dynamic lastActive;
//   final dynamic hideAt;
//   @JsonKey(defaultValue: "")
//   final dynamic userEmail;
//   @JsonKey(defaultValue: "")
//   final dynamic userPhone;
//   final dynamic address;
//   final dynamic educationJob;
//   final dynamic family;
//   final dynamic mom;
//   @JsonKey(defaultValue: null)
//   final dynamic shortlistByMe;
//   @JsonKey(defaultValue: null)
//   final dynamic shortlistMe;
//   final dynamic freeCoupling;
//   final dynamic recomendCause;
//   @JsonKey(defaultValue: 0)
//   final dynamic recomendCauseCount;
//   final dynamic info;
//   final dynamic officialDocuments;
//   final dynamic photos;
//   final dynamic dp;
//   final dynamic preference;
//   final dynamic usersBasicDetails;
//   final dynamic siblings;
//   final dynamic userCoupling;
//   @JsonKey(defaultValue: 0)
//   final dynamic recommendGiven;
//   @JsonKey(defaultValue: 0)
//   final dynamic recommendReceived;

//   ProfileResponseFinal({
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
//     this.userEmail,
//     this.userPhone,
//     this.address,
//     this.educationJob,
//     this.family,
//     this.mom,
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
//     this.recommendGiven,
//     this.recommendReceived,
//     this.recomendCause,
//     this.recomendCauseCount,
//   }) : super();

//   factory ProfileResponseFinal.fromJson(Map<String, dynamic> json) =>
//       _$ProfileResponseFinalFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         name,
//         lastName,
//         membershipCode,
//         gender,
//         profilePic,
//         emailVerification,
//         mobileVerification,
//         isActive,
//         lastActive,
//         hideAt,
//         membership,
//         userEmail,
//         userPhone,
//         address,
//         educationJob,
//         family,
//         mom,
//         shortlistByMe,
//         shortlistMe,
//         freeCoupling,
//         info,
//         officialDocuments,
//         photos,
//         dp,
//         preference,
//         usersBasicDetails,
//         siblings,
//         userCoupling,
//         recommendGiven,
//         recommendReceived,
//         recomendCause,
//         recomendCauseCount,
//       ];

//   Map<String, dynamic> toJson() => _$ProfileResponseFinalToJson(this);

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
//         'recommendGiven: $recommendGiven, recommendReceived: $recommendReceived,}';
//   }
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Address extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: 0)
//   final int userId;
//   final dynamic addressType;
//   @JsonKey(defaultValue: "")
//   final String countryCode;
//   @JsonKey(defaultValue: "")
//   final String country;
//   @JsonKey(defaultValue: "")
//   final String state;
//   @JsonKey(defaultValue: "")
//   final String city;
//   @JsonKey(defaultValue: 0)
//   final int locationId;
//   @JsonKey(defaultValue: "")
//   final String address;
//   @JsonKey(defaultValue: 0)
//   final int pincode;
//   @JsonKey(defaultValue: 0)
//   final int tolStatus;
//   @JsonKey(defaultValue: 0)
//   final int presentAddress;

//   final DateTime deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;

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
//   }) : super();

//   factory Address.fromJson(Map<String, dynamic> json) =>
//       _$AddressFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         addressType,
//         countryCode,
//         country,
//         state,
//         city,
//         locationId,
//         address,
//         pincode,
//         tolStatus,
//         presentAddress,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

//   Map<String, dynamic> toJson() => _$AddressToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class PhotoResponse extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final dynamic id;
//   @JsonKey(defaultValue: 0)
//   final dynamic userId;
//   @JsonKey(defaultValue: "")
//   final dynamic photoName;
//   @JsonKey(defaultValue: "")
//   final dynamic fromType;
//   final dynamic imageType;
//   @JsonKey(defaultValue: 0)
//   final dynamic status;
//   final dynamic approvedBy;
//   final dynamic photoApprovedAt;
//   final dynamic comments;
//   @JsonKey(defaultValue: 0)
//   final dynamic trash;
//   final dynamic imageTaken;
//   @JsonKey(defaultValue: 0)
//   final dynamic dpStatus;
//   @JsonKey(defaultValue: 0)
//   final dynamic sortOrder;
//   final dynamic deletedAt;
//   final dynamic createdAt;
//   final dynamic updatedAt;
//   final dynamic userDetail;

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
//     this.status,
//   }) : super();

//   factory PhotoResponse.fromJson(Map<String, dynamic> json) =>
//       _$PhotoResponseFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         photoName,
//         fromType,
//         imageType,
//         approvedBy,
//         photoApprovedAt,
//         comments,
//         trash,
//         imageTaken,
//         dpStatus,
//         sortOrder,
//         deletedAt,
//         createdAt,
//         updatedAt,
//         userDetail,
//         status,
//       ];

//   Map<String, dynamic> toJson() => _$PhotoResponseToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Data extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: "")
//   final String type;
//   @JsonKey(defaultValue: "")
//   final String value;
//   @JsonKey(defaultValue: 0)
//   final int parentId;
//   @JsonKey(defaultValue: "")
//   final String others;
//   final bool isSelected;

//   Data({
//     this.id,
//     this.type,
//     this.value,
//     this.parentId,
//     this.others,
//     this.isSelected,
//   }) : super();

//   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         type,
//         value,
//         parentId,
//         others,
//         isSelected,
//       ];

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
// class UserDetail extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final dynamic id;
//   @JsonKey(defaultValue: "")
//   final dynamic name;
//   @JsonKey(defaultValue: "")
//   final dynamic lastName;
//   @JsonKey(defaultValue: "")
//   final dynamic membershipCode;
//   @JsonKey(defaultValue: "")
//   final dynamic gender;
//   @JsonKey(defaultValue: "")
//   final dynamic profilePic;
//   @JsonKey(defaultValue: 0)
//   final dynamic emailVerification;
//   @JsonKey(defaultValue: 0)
//   final dynamic mobileVerification;
//   @JsonKey(defaultValue: 0)
//   final dynamic isActive;
//   final dynamic lastActive;
//   final dynamic hideAt;

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
//   }) : super();

//   factory UserDetail.fromJson(Map<String, dynamic> json) =>
//       _$UserDetailFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         name,
//         lastName,
//         membershipCode,
//         gender,
//         profilePic,
//         emailVerification,
//         mobileVerification,
//         isActive,
//         lastActive,
//         hideAt,
//       ];

//   Map<String, dynamic> toJson() => _$UserDetailToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class EducationJobResponse extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final dynamic id;
//   @JsonKey(defaultValue: 0)
//   final dynamic userId;
//   final dynamic linkedInStatus;
//   @JsonKey(defaultValue: 0)
//   final dynamic jobStatus;
//   @JsonKey(defaultValue: "")
//   final dynamic companyName;
//   final dynamic industry;
//   final dynamic profession;
//   final dynamic experience;
//   final dynamic highestEducation;
//   final dynamic educationBranch;
//   final dynamic incomeRange;
//   final dynamic deletedAt;
//   final dynamic createdAt;
//   final dynamic updatedAt;

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
//   }) : super();

//   factory EducationJobResponse.fromJson(Map<String, dynamic> json) =>
//       _$EducationJobResponseFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         linkedInStatus,
//         jobStatus,
//         companyName,
//         industry,
//         profession,
//         experience,
//         highestEducation,
//         educationBranch,
//         incomeRange,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

//   Map<String, dynamic> toJson() => _$EducationJobResponseToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Membership extends Equatable {
//   Membership({
//     @JsonKey(defaultValue: false) this.paidMember,
//     @JsonKey(defaultValue: '') this.planName,
//     @JsonKey(defaultValue: 0) this.chat,
//     @JsonKey(defaultValue: 0) this.statistics,
//     this.expiredAt,
//   }) : super();

//   final bool paidMember;
//   final String planName;
//   final int chat;
//   final int statistics;
//   final DateTime expiredAt;

//   factory Membership.fromJson(Map<String, dynamic> json) =>
//       _$MembershipFromJson(json);

//   @override
//   List<Object> get props => [
//         paidMember,
//         planName,
//         chat,
//         statistics,
//       ];

//   Map<String, dynamic> toJson() => _$MembershipToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class FamilyResponse extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final dynamic id;
//   @JsonKey(defaultValue: 0)
//   final dynamic userId;
//   final dynamic fatherName;
//   final dynamic fatherOccupationStatus;
//   final dynamic motherName;
//   final dynamic motherOccupationStatus;
//   final dynamic familyType;
//   final dynamic familyValues;
//   final dynamic religion;
//   final dynamic cast;
//   final dynamic subcast;
//   final dynamic gothram;
//   @JsonKey(defaultValue: "")
//   final dynamic countryCode;
//   @JsonKey(defaultValue: "")
//   final dynamic country;
//   @JsonKey(defaultValue: "")
//   final dynamic state;
//   @JsonKey(defaultValue: "")
//   final dynamic city;
//   @JsonKey(defaultValue: 0)
//   final dynamic locationId;

//   final dynamic deletedAt;
//   final dynamic createdAt;
//   final dynamic updatedAt;

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
//   }) : super();

//   factory FamilyResponse.fromJson(Map<String, dynamic> json) =>
//       _$FamilyResponseFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         fatherName,
//         fatherOccupationStatus,
//         motherName,
//         motherOccupationStatus,
//         familyType,
//         familyValues,
//         religion,
//         cast,
//         subcast,
//         gothram,
//         countryCode,
//         country,
//         state,
//         city,
//         locationId,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

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
// class InfoResponse extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final dynamic id;
//   @JsonKey(defaultValue: 0)
//   final dynamic userId;
//   final dynamic dob;
//   @JsonKey(defaultValue: 0)
//   final dynamic dobStatus;
//   @JsonKey(defaultValue: 0)
//   final int height;
//   @JsonKey(defaultValue: 0)
//   final int weight;
//   final Data bodyType;
//   final Data complexion;
//   @JsonKey(defaultValue: 0)
//   final int specialCase;
//   final Data specialCaseType;
//   @JsonKey(defaultValue: 0)
//   final int specialCaseNotify;
//   @JsonKey(defaultValue: 0)
//   final int adminApprovalStatus;
//   @JsonKey(defaultValue: "")
//   final String countryCode;
//   @JsonKey(defaultValue: "")
//   final String country;
//   @JsonKey(defaultValue: "")
//   final String state;
//   @JsonKey(defaultValue: "")
//   final String city;
//   @JsonKey(defaultValue: 0)
//   final int locationId;
//   final Data maritalStatus;
//   @JsonKey(defaultValue: 0)
//   final int numberOfChildren;
//   final Data childLivingStatus;
//   @JsonKey(defaultValue: "")
//   final String bornPlace;
//   @JsonKey(defaultValue: "")
//   final String bornTime;
//   @JsonKey(defaultValue: "")
//   final String aboutSelf;
//   @JsonKey(defaultValue: "")
//   final String aboutPartner;
//   final dynamic completedStatus;
//   final dynamic completedIn;
//   final DateTime deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;

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

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         dobStatus,
//         dob,
//         height,
//         weight,
//         bodyType,
//         complexion,
//         specialCase,
//         specialCaseType,
//         specialCaseNotify,
//         adminApprovalStatus,
//         countryCode,
//         country,
//         state,
//         city,
//         locationId,
//         maritalStatus,
//         numberOfChildren,
//         childLivingStatus,
//         bornPlace,
//         bornTime,
//         aboutSelf,
//         aboutPartner,
//         completedStatus,
//         completedIn,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

//   Map<String, dynamic> toJson() => _$InfoResponseToJson(this);

//   @override
//   String toString() {
//     return 'InfoResponse{id: $id, userId: $userId, dob: $dob, dobStatus: $dobStatus, height: $height, '
//         'weight: $weight, bodyType: $bodyType, complexion: $complexion, specialCase: $specialCase, '
//         'specialCaseType: $specialCaseType, specialCaseNotify: $specialCaseNotify, adminApprovalStatus: $adminApprovalStatus, '
//         'countryCode: $countryCode, country: $country, state: $state, city: $city, locationId: $locationId, '
//         'maritalStatus: $maritalStatus, numberOfChildren: $numberOfChildren, childLivingStatus: $childLivingStatus, '
//         'bornPlace: $bornPlace, bornTime: $bornTime, aboutSelf: $aboutSelf, aboutPartner: $aboutPartner, '
//         'completedStatus: $completedStatus, completedIn: $completedIn, deletedAt: $deletedAt, '
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
// class OfficialDocuments extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final dynamic id;
//   @JsonKey(defaultValue: 0)
//   final dynamic userId;
//   @JsonKey(defaultValue: 0)
//   final dynamic govtIdType;

// //  @JsonKey(defaultValue: "")
//   final dynamic govtIdFront;

// //  @JsonKey(defaultValue: "")
//   final dynamic govtIdBack;
//   @JsonKey(defaultValue: 0)
//   final dynamic govtIdStatus;
//   final dynamic govtIdApprovedBy;
//   final dynamic govtIdRejectComments;
//   final dynamic govtIdApprovedAt;
//   final dynamic officeId;
//   @JsonKey(defaultValue: 0)
//   final dynamic officeIdStatus;
//   final dynamic officeIdApprovedBy;
//   final dynamic officeIdRejectComments;
//   final dynamic officeIdApprovedAt;
//   final dynamic linkedinId;
//   @JsonKey(defaultValue: 0)
//   final dynamic linkedinIdStatus;
//   final dynamic deletedAt;
//   final dynamic createdAt;
//   final dynamic updatedAt;

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
//   }) : super();

//   factory OfficialDocuments.fromJson(Map<String, dynamic> json) =>
//       _$OfficialDocumentsFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         govtIdType,
//         govtIdFront,
//         govtIdBack,
//         govtIdStatus,
//         govtIdApprovedBy,
//         govtIdRejectComments,
//         govtIdApprovedAt,
//         officeId,
//         officeIdStatus,
//         officeIdApprovedBy,
//         officeIdRejectComments,
//         officeIdApprovedAt,
//         linkedinId,
//         linkedinIdStatus,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

//   Map<String, dynamic> toJson() => _$OfficialDocumentsToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Preference extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: 0)
//   final int userId;
//   final dynamic preferenceType;
//   @JsonKey(defaultValue: 0)
//   final int ageMin;
//   @JsonKey(defaultValue: 0)
//   final int ageMax;
//   @JsonKey(defaultValue: 0)
//   final int heightMin;
//   @JsonKey(defaultValue: 0)
//   final int heightMax;
//   @JsonKey(defaultValue: 0)
//   final int weightMin;
//   @JsonKey(defaultValue: 0)
//   final int weightMax;
//   final Data bodyType;
//   final Data complexion;
//   @JsonKey(defaultValue: "")
//   final String countryCode;
//   final dynamic country;
//   final dynamic state;
//   final dynamic city;
//   @JsonKey(defaultValue: 0)
//   final int locationId;
//   final Data maritalStatus;
//   final Data specialcase;
//   final Data religion;
//   final Data cast;
//   final Data subCast;
//   final Data gothram;
//   final Data fatherOccupationStatus;
//   final Data motherOccupationStatus;
//   final dynamic sibling;
//   @JsonKey(defaultValue: "")
//   final String familyCountryCode;
//   final dynamic familyCountry;
//   final dynamic familyState;
//   final dynamic familyCity;
//   @JsonKey(defaultValue: 0)
//   final int familyLocationId;
//   final Data familyType;
//   final Data familyValues;
//   final Data occupation;
//   final Data profession;
//   final Data designation;
//   final dynamic workingExperience;
//   final Data education;
//   final dynamic incomeRange;
//   final dynamic saveAs;

//   final DateTime deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;

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
//   }) : super();

//   factory Preference.fromJson(Map<String, dynamic> json) =>
//       _$PreferenceFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         preferenceType,
//         ageMin,
//         ageMax,
//         heightMin,
//         heightMax,
//         weightMin,
//         weightMax,
//         bodyType,
//         complexion,
//         countryCode,
//         country,
//         state,
//         city,
//         locationId,
//         maritalStatus,
//         specialcase,
//         religion,
//         cast,
//         subCast,
//         gothram,
//         fatherOccupationStatus,
//         motherOccupationStatus,
//         sibling,
//         familyCountryCode,
//         familyCountry,
//         familyState,
//         familyCity,
//         familyLocationId,
//         familyType,
//         familyValues,
//         occupation,
//         profession,
//         designation,
//         workingExperience,
//         education,
//         incomeRange,
//         saveAs,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

//   Map<String, dynamic> toJson() => _$PreferenceToJson(this);

//   @override
//   String toString() {
//     return 'Preference{id: $id, userId: $userId, preferenceType: $preferenceType, ageMin: $ageMin, ageMax: $ageMax, '
//         'heightMin: $heightMin, heightMax: $heightMax, weightMin: $weightMin, weightMax: $weightMax, bodyType: $bodyType, '
//         'complexion: $complexion, countryCode: $countryCode, country: $country, state: $state, city: $city, '
//         'locationId: $locationId, maritalStatus: $maritalStatus, specialcase: $specialcase, religion: $religion, '
//         'cast: $cast, subCast: $subCast, gothram: $gothram, fatherOccupationStatus: $fatherOccupationStatus, '
//         'motherOccupationStatus: $motherOccupationStatus, sibling: $sibling, familyCountryCode: $familyCountryCode, '
//         'familyCountry: $familyCountry, familyState: $familyState, familyCity: $familyCity, familyLocationId: $familyLocationId, '
//         'familyType: $familyType, familyValues: $familyValues, occupation: $occupation, profession: $profession, '
//         'designation: $designation, workingExperience: $workingExperience, education: $education, incomeRange: $incomeRange, '
//         'saveAs: $saveAs, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class FreeCoupling extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: '')
//   final String couplingType;
//   @JsonKey(defaultValue: '')
//   final String type;
//   @JsonKey(defaultValue: '')
//   final String question;
//   @JsonKey(defaultValue: 0)
//   final int questionOrder;
//   @JsonKey(defaultValue: 0)
//   final int parent;
//   @JsonKey(defaultValue: '')
//   final String status;
//   final dynamic deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   @JsonKey(defaultValue: 0.0)
//   final double score;
//   @JsonKey(defaultValue: '')
//   final String message;

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
//   }) : super();

//   factory FreeCoupling.fromJson(Map<String, dynamic> json) =>
//       _$FreeCouplingFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         couplingType,
//         type,
//         question,
//         questionOrder,
//         parent,
//         status,
//         deletedAt,
//         createdAt,
//         updatedAt,
//         score,
//         message,
//       ];

//   Map<String, dynamic> toJson() => _$FreeCouplingToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class RecomendCause extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: "")
//   final String value;
//   @JsonKey(defaultValue: 0)
//   final int count;
//   @JsonKey(defaultValue: false)
//   final bool checked;

//   RecomendCause({
//     this.id,
//     this.value,
//     this.count,
//     this.checked,
//   }) : super();

//   factory RecomendCause.fromJson(Map<String, dynamic> json) =>
//       _$RecomendCauseFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         value,
//         count,
//         checked,
//       ];

//   Map<String, dynamic> toJson() => _$RecomendCauseToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Purchasetopup extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: 0)
//   final int purchasePlanId;
//   @JsonKey(defaultValue: 0)
//   final int userId;
//   @JsonKey(defaultValue: 0)
//   final int purchaseTopupId;
//   @JsonKey(defaultValue: "")
//   final String topupType;
//   @JsonKey(defaultValue: "")
//   final String amount;
//   @JsonKey(defaultValue: 0)
//   final int validity;
//   @JsonKey(defaultValue: 0)
//   final int profiles;

//   final DateTime activeAt;
//   final DateTime expiredAt;
//   final DateTime deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;

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
//   }) : super();

//   factory Purchasetopup.fromJson(Map<String, dynamic> json) =>
//       _$PurchasetopupFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         purchasePlanId,
//         userId,
//         purchaseTopupId,
//         topupType,
//         amount,
//         validity,
//         profiles,
//         activeAt,
//         expiredAt,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

//   Map<String, dynamic> toJson() => _$PurchasetopupToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class SiblingResponse extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: 0)
//   final int userId;
//   final String siblingName;
//   final Data role;
//   final Data profession;
//   final Data maritalStatus;

//   final DateTime deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;

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
//   }) : super();

//   factory SiblingResponse.fromJson(Map<String, dynamic> json) =>
//       _$SiblingResponseFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         siblingName,
//         role,
//         profession,
//         maritalStatus,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

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
// class UserCouplingFinal extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: 0)
//   final int userId;
//   @JsonKey(defaultValue: 0)
//   final int questionId;
//   final dynamic answer;

//   final dynamic deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   UserCouplingFinal({
//     this.id,
//     this.userId,
//     this.questionId,
//     this.answer,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   }) : super();

//   factory UserCouplingFinal.fromJson(Map<String, dynamic> json) =>
//       _$UserCouplingFinalFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         questionId,
//         answer,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

//   Map<String, dynamic> toJson() => _$UserCouplingFinalToJson(this);

//   @override
//   String toString() {
//     return 'UserCouplingFinal{id: $id, userId: $userId, questionId: $questionId, answer: $answer, '
//         'deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class UsersBasicDetails extends Equatable {
//   @JsonKey(defaultValue: 0)
//   final int id;
//   @JsonKey(defaultValue: 0)
//   final int userId;
//   final UserDetail profileApprovedBy;
//   final dynamic profileRejectComment;
//   final DateTime profileApprovedAt;
//   @JsonKey(defaultValue: 0)
//   final int paymentPlan;
//   final dynamic registeredBy;
//   final dynamic facebookId;
//   final dynamic googleId;
//   final dynamic linkedinId;
//   @JsonKey(defaultValue: "")
//   final String webRegistrationStep;
//   @JsonKey(defaultValue: "")
//   final String appRegistrationStep;
//   @JsonKey(defaultValue: 0)
//   final int registrationStatus;
//   final DateTime couplingCompletedTime;
//   final DateTime deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;

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
//   }) : super();

//   factory UsersBasicDetails.fromJson(Map<String, dynamic> json) =>
//       _$UsersBasicDetailsFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         profileApprovedBy,
//         profileRejectComment,
//         profileApprovedAt,
//         paymentPlan,
//         registeredBy,
//         facebookId,
//         googleId,
//         linkedinId,
//         webRegistrationStep,
//         appRegistrationStep,
//         registrationStatus,
//         couplingCompletedTime,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

//   Map<String, dynamic> toJson() => _$UsersBasicDetailsToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class Mom extends Equatable {
//   final int id;
//   final int userId;
//   final int partnerId;
//   final String momType;
//   final String momStatus;
//   final String message;
//   final DateTime deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime seenAt;
//   final DateTime remindAt;
//   final DateTime snoozeAt;
//   final List<MomHistory> momHistory;

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
//   }) : super();

//   factory Mom.fromJson(Map<String, dynamic> json) => _$MomFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         partnerId,
//         momType,
//         momStatus,
//         message,
//         deletedAt,
//         createdAt,
//         updatedAt,
//         seenAt,
//         remindAt,
//         snoozeAt,
//         momHistory,
//       ];

//   Map<String, dynamic> toJson() => _$MomToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class MomHistory extends Equatable {
//   final int id;
//   final int userId;
//   final int partnerId;
//   final int momId;
//   final String momType;
//   final String momStatus;
//   final String message;
//   final String adminMessage;
//   final int userHide;
//   final int partnerHide;
//   final DateTime seenAt;
//   final DateTime remindAt;
//   final DateTime snoozeAt;
//   final DateTime actionAt;
//   final dynamic actionCount;
//   final String statusPosition;
//   final DateTime viewAt;
//   final DateTime deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;

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
//   }) : super();

//   factory MomHistory.fromJson(Map<String, dynamic> json) =>
//       _$MomHistoryFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         userId,
//         partnerId,
//         momId,
//         momType,
//         momStatus,
//         message,
//         adminMessage,
//         userHide,
//         partnerHide,
//         seenAt,
//         remindAt,
//         snoozeAt,
//         actionAt,
//         actionCount,
//         statusPosition,
//         viewAt,
//         deletedAt,
//         createdAt,
//         updatedAt,
//       ];

//   Map<String, dynamic> toJson() => _$MomHistoryToJson(this);
// }

// @JsonSerializable(
//     includeIfNull: true,
//     createToJson: true,
//     createFactory: true,
//     explicitToJson: true,
//     disallowUnrecognizedKeys: false,
//     fieldRename: FieldRename.snake)
// class RecomendCount extends Equatable {
//   final int id;
//   final String value;
//   final int count;

//   RecomendCount({
//     this.id,
//     this.value,
//     this.count,
//   }) : super();

//   factory RecomendCount.fromJson(Map<String, dynamic> json) =>
//       _$RecomendCountFromJson(json);

//   @override
//   List<Object> get props => [
//         id,
//         value,
//         count,
//       ];

//   Map<String, dynamic> toJson() => _$RecomendCountToJson(this);
// }
