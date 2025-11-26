import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'package:obo_mne/services/github_service.dart';
import 'package:obo_mne/models/github_profile.dart';

import 'github_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('GitHubService', () {
    late MockClient mockClient;
    late GitHubService githubService;

    setUp(() {
      mockClient = MockClient();
      githubService = GitHubService(mockClient);
    });

    test('returns GitHubProfile when the http call completes successfully', () async {
      // Arrange
      final responseJson = '''
      {
        "login": "testuser",
        "avatar_url": "https://example.com/avatar.png",
        "html_url": "https://github.com/testuser",
        "name": "Test User",
        "company": "Test Company",
        "blog": "https://testblog.com",
        "location": "Test Location",
        "bio": "Test Bio",
        "public_repos": 10,
        "followers": 5,
        "following": 3,
        "created_at": "2020-01-01T00:00:00Z"
      }
      ''';

      when(mockClient.get(
        Uri.parse('https://api.github.com/users/testuser'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(responseJson, 200));

      // Act
      final profile = await githubService.getGitHubProfile('testuser');

      // Assert
      expect(profile, isA<GitHubProfile>());
      expect(profile.login, equals('testuser'));
      expect(profile.name, equals('Test User'));
      expect(profile.publicRepos, equals(10));
      expect(profile.followers, equals(5));
      expect(profile.following, equals(3));
    });

    test('throws an exception when the http call completes with 404', () async {
      // Arrange
      when(mockClient.get(
        Uri.parse('https://api.github.com/users/testuser'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(() async => await githubService.getGitHubProfile('testuser'),
          throwsException);
    });

    test('throws an exception when the http call completes with non-200 status', () async {
      // Arrange
      when(mockClient.get(
        Uri.parse('https://api.github.com/users/testuser'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      // Act & Assert
      expect(() async => await githubService.getGitHubProfile('testuser'),
          throwsException);
    });

    test('throws an exception when there is a network error', () async {
      // Arrange
      when(mockClient.get(
        Uri.parse('https://api.github.com/users/testuser'),
        headers: anyNamed('headers'),
      )).thenThrow(http.ClientException('Network error'));

      // Act & Assert
      expect(() async => await githubService.getGitHubProfile('testuser'),
          throwsException);
    });

    test('throws an exception when there is a timeout', () async {
      // Arrange
      when(mockClient.get(
        Uri.parse('https://api.github.com/users/testuser'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 11));
        return http.Response('{}', 200);
      });

      // Act & Assert
      expect(() async => await githubService.getGitHubProfile('testuser'),
          throwsException);
    });
  });
}