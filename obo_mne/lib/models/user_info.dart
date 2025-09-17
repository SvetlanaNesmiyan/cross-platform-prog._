import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info.freezed.dart';
part 'user_info.g.dart';

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required String name,
    required String surname,
    required int age,
    required String email,
    required String phone,
    required String position,
    required List<String> skills,
    required String about,
    required String education,
    required String experience,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  
  @override
  // TODO: implement about
  String get about => throw UnimplementedError();
  
  @override
  // TODO: implement age
  int get age => throw UnimplementedError();
  
  @override
  // TODO: implement education
  String get education => throw UnimplementedError();
  
  @override
  // TODO: implement email
  String get email => throw UnimplementedError();
  
  @override
  // TODO: implement experience
  String get experience => throw UnimplementedError();
  
  @override
  // TODO: implement name
  String get name => throw UnimplementedError();
  
  @override
  // TODO: implement phone
  String get phone => throw UnimplementedError();
  
  @override
  // TODO: implement position
  String get position => throw UnimplementedError();
  
  @override
  // TODO: implement skills
  List<String> get skills => throw UnimplementedError();
  
  @override
  // TODO: implement surname
  String get surname => throw UnimplementedError();
  
  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}