// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('ChatModel', json, () {
    final val = ChatModel(
      status: $checkedConvert(json, 'status', (v) => v as String) ?? '',
      response: $checkedConvert(
          json,
          'response',
          (v) => (v as List)
              .map((e) => e == null
                  ? null
                  : ChatResponse.fromJson(e as Map<String, dynamic>))
              .toList()),
      code: $checkedConvert(json, 'code', (v) => v as int) ?? 0,
    );
    return val;
  });
}

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
      'code': instance.code,
    };

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) {
  return ChatResponse(
    id: json['id'] != null ? json['id'] as int : 0,
    userId: json['user_id'] != null ? json['user_id'] as int : 0,
    partnerId: json['partner_id'] != null ? json['partner_id'] as int : 0,
    message: json['message'] != null ? json['message'] as String : '',
    read: json['read'] != null ? json['read'] as int : 0,
    love: json['love'] != null ? json['love'] as int : 0,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    partner: json['partner'] == null
        ? null
        : PartnerDetails.fromJson(json['partner'] as Map<String, dynamic>),
    readCount: json['read_count'] != null ? json['read_count'] as int : 0,
    mom: json['mom'] == null
        ? null
        : MomM.fromJson(json['mom'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'read_count': instance.readCount,
      'user_id': instance.userId,
      'partner_id': instance.partnerId,
      'message': instance.message,
      'read': instance.read,
      'love': instance.love,
      'mom': instance.mom!.toJson(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'partner': instance.partner!.toJson(),
    };
