import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_profile.freezed.dart';
part 'github_profile.g.dart';

@freezed
class GitHubProfile with _$GitHubProfile {
  const factory GitHubProfile({
    required String login,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
    @JsonKey(name: 'html_url') required String htmlUrl,
    String? name,
    String? company,
    String? blog,
    String? location,
    String? bio,
    @JsonKey(name: 'public_repos') required int publicRepos,
    required int followers,
    required int following,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _GitHubProfile;

  factory GitHubProfile.fromJson(Map<String, dynamic> json) => _$GitHubProfileFromJson(json);
}