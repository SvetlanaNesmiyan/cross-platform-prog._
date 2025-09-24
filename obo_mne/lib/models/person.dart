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
  
  @override
  // TODO: implement about
  String get about => throw UnimplementedError();
  
  @override
  // TODO: implement age
  int get age => throw UnimplementedError();
  
  @override
  // TODO: implement avatarUrl
  String get avatarUrl => throw UnimplementedError();
  
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
  // TODO: implement id
  int get id => throw UnimplementedError();
  
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

extension PersonExtension on Person {
  String get fullName => '$name $surname';
  
  List<Object?> get equalityProps => [
        id,
        name,
        surname,
        age,
        email,
        phone,
        position,
        skills,
        about,
        education,
        experience,
        avatarUrl,
      ];
}