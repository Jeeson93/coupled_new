// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_maker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchMakerModel _$MatchMakerModelFromJson(Map<String, dynamic> json) {
  return MatchMakerModel(
    id: json['id'] != null ? json['id'] as int : 0,
    userId: json['user_id'] != null ? json['user_id'] as int : 0,
    matchType: json['match_type'] != null ? json['match_type'] as String : '',
    ageMin: json['age_min'] != null ? json['age_min'] as int : 0,
    ageMax: json['age_max'] != null ? json['age_max'] as int : 0,
    heightMin: json['height_min'] != null ? json['height_min'] as int : 0,
    heightMax: json['height_max'] != null ? json['height_max'] as int : 0,
    weightMin: json['weight_min'] != null ? json['weight_min'] as int : 0,
    weightMax: json['weight_max'] != null ? json['weight_max'] as int : 0,
    bodyType: json['body_type'] != null
        ? (json['body_type'] as List).map((e) => e as String).toList()
        : [],
    complexion: json['complexion'] != null
        ? (json['complexion'] as List).map((e) => e as String).toList()
        : [],
    country: json['country'] != null
        ? (json['country'] as List).map((e) => e as String).toList()
        : [],
    state: json['state'] != null
        ? (json['state'] as List).map((e) => e as String).toList()
        : [],
    city: json['city'] != null
        ? (json['city'] as List).map((e) => e as String).toList()
        : [],
    maritalStatus: json['marital_status'] != null
        ? (json['marital_status'] as List).map((e) => e as String).toList()
        : [],
    religion: json['religion'] != null
        ? (json['religion'] as List).map((e) => e as String).toList()
        : [],
    cast: json['cast'] != null
        ? (json['cast'] as List).map((e) => e as String).toList()
        : [],
    occupation: json['occupation'] != null
        ? (json['occupation'] as List).map((e) => e as String).toList()
        : [],
    experience: json['experience'] != null ? json['experience'] as int : 0,
    education: json['education'] != null
        ? (json['education'] as List).map((e) => e as String).toList()
        : [],
    income: json['income'] != null
        ? (json['income'] as List).map((e) => e as String).toList()
        : [],
    active: json['active'] != null ? json['active'] as int : 0,
    familyType: json['family_type'] != null
        ? (json['family_type'] as List).map((e) => e as String).toList()
        : [],
    familyValues: json['family_values'] != null
        ? (json['family_values'] as List).map((e) => e as String).toList()
        : [],
    minScore: json['min_score'] != null ? json['min_score'] as int : 0,
    maxScore: json['max_score'] != null ? json['max_score'] as int : 0,
    question_1: json['question_1'] != null ? json['question_1'] as int : 0,
    answer_1: json['answer_1'] != null ? json['answer_1'] as int : 0,
    question_2: json['question_2'] != null ? json['question_2'] as int : 0,
    answer_2: json['answer_2'] != null ? json['answer_2'] as int : 0,
    deletedAt: json['deleted_at'] != null ? json['deleted_at'] as int : 0,
    createdAt: json['created_at'] == null
        ? ''
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? ''
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$MatchMakerModelToJson(MatchMakerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'match_type': instance.matchType,
      'age_min': instance.ageMin,
      'age_max': instance.ageMax,
      'height_min': instance.heightMin,
      'height_max': instance.heightMax,
      'weight_min': instance.weightMin,
      'weight_max': instance.weightMax,
      'body_type': instance.bodyType,
      'complexion': instance.complexion,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'marital_status': instance.maritalStatus,
      'religion': instance.religion,
      'cast': instance.cast,
      'occupation': instance.occupation,
      'experience': instance.experience,
      'active': instance.active,
      'education': instance.education,
      'income': instance.income,
      'family_type': instance.familyType,
      'family_values': instance.familyValues,
      'min_score': instance.minScore,
      'max_score': instance.maxScore,
      'question_1': instance.question_1,
      'answer_1': instance.answer_1,
      'question_2': instance.question_2,
      'answer_2': instance.answer_2,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
