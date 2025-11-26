import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
class Person with _$Person {
  const factory Person({
    required int id,
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
    required String avatarUrl,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}

extension PersonExtension on Person {
  String get fullName => '$name $surname';
}