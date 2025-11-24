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
  
  @override
  // TODO: implement avatarUrl
  String get avatarUrl => throw UnimplementedError();
  
  @override
  // TODO: implement bio
  String? get bio => throw UnimplementedError();
  
  @override
  // TODO: implement blog
  String? get blog => throw UnimplementedError();
  
  @override
  // TODO: implement company
  String? get company => throw UnimplementedError();
  
  @override
  // TODO: implement createdAt
  String get createdAt => throw UnimplementedError();
  
  @override
  // TODO: implement followers
  int get followers => throw UnimplementedError();
  
  @override
  // TODO: implement following
  int get following => throw UnimplementedError();
  
  @override
  // TODO: implement htmlUrl
  String get htmlUrl => throw UnimplementedError();
  
  @override
  // TODO: implement location
  String? get location => throw UnimplementedError();
  
  @override
  // TODO: implement login
  String get login => throw UnimplementedError();
  
  @override
  // TODO: implement name
  String? get name => throw UnimplementedError();
  
  @override
  // TODO: implement publicRepos
  int get publicRepos => throw UnimplementedError();
  
  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}