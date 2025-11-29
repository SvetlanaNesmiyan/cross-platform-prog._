import '../models/github_profile.dart';
import '../services/github_service.dart';

class GitHubRepository {
  final GitHubService _gitHubService;

  GitHubRepository(this._gitHubService);

  Future<GitHubProfile> getGitHubProfile(String username) async {
    return await _gitHubService.getGitHubProfile(username);
  }

  Future<Map<String, dynamic>> getGitHubStats(String username) async {
    try {
      final profile = await _gitHubService.getGitHubProfile(username);
      
      return {
        'profile': profile,
        'stats': {
          'repositories': profile.publicRepos,
          'followers': profile.followers,
          'following': profile.following,
          'accountAge': _calculateAccountAge(profile.createdAt),
        },
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGitHubStatsMock(String username) async {
    await Future.delayed(const Duration(seconds: 2));
    
    final mockProfile = GitHubProfile(
      login: username,
      avatarUrl: 'https://avatars.githubusercontent.com/u/163138406?s=400&u=91b95cad8663afdbbb86c6f9933ea14ca9948c47&v=4',
      htmlUrl: 'https://github.com/$username',
      name: 'Svitlana Nesmiian',
      company: 'Student at KhPI',
      blog: 'https://github.com',
      location: 'Kharkiv, Ukraine',
      bio: 'Flutter developer and computer science student',
      publicRepos: 27,
      followers: 89,
      following: 34,
      createdAt: '2020-01-15T10:30:00Z',
    );
    
    return {
      'profile': mockProfile,
      'stats': {
        'repositories': mockProfile.publicRepos,
        'followers': mockProfile.followers,
        'following': mockProfile.following,
        'accountAge': _calculateAccountAge(mockProfile.createdAt),
      },
    };
  }

  int _calculateAccountAge(String createdAt) {
    try {
      final created = DateTime.parse(createdAt);
      final now = DateTime.now();
      return now.difference(created).inDays ~/ 365;
    } catch (e) {
      return 0;
    }
  }
}