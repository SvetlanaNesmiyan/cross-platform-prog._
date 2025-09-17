// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => _UserInfo(
  name: json['name'] as String,
  surname: json['surname'] as String,
  age: (json['age'] as num).toInt(),
  email: json['email'] as String,
  phone: json['phone'] as String,
  position: json['position'] as String,
  skills: (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
  about: json['about'] as String,
  education: json['education'] as String,
  experience: json['experience'] as String,
);

Map<String, dynamic> _$UserInfoToJson(_UserInfo instance) => <String, dynamic>{
  'name': instance.name,
  'surname': instance.surname,
  'age': instance.age,
  'email': instance.email,
  'phone': instance.phone,
  'position': instance.position,
  'skills': instance.skills,
  'about': instance.about,
  'education': instance.education,
  'experience': instance.experience,
};
