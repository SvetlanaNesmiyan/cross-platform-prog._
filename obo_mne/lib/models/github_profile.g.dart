// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GitHubProfile _$GitHubProfileFromJson(Map<String, dynamic> json) =>
    _GitHubProfile(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      htmlUrl: json['html_url'] as String,
      name: json['name'] as String?,
      company: json['company'] as String?,
      blog: json['blog'] as String?,
      location: json['location'] as String?,
      bio: json['bio'] as String?,
      publicRepos: (json['public_repos'] as num).toInt(),
      followers: (json['followers'] as num).toInt(),
      following: (json['following'] as num).toInt(),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$GitHubProfileToJson(_GitHubProfile instance) =>
    <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'html_url': instance.htmlUrl,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'bio': instance.bio,
      'public_repos': instance.publicRepos,
      'followers': instance.followers,
      'following': instance.following,
      'created_at': instance.createdAt,
    };
