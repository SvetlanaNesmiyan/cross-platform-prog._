import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:obo_mne/repositories/github_repository.dart';
import 'package:obo_mne/services/github_service.dart';
import 'package:obo_mne/models/github_profile.dart';

import 'github_repository_test.mocks.dart';

@GenerateMocks([GitHubService])
void main() {
  group('GitHubRepository', () {
    late MockGitHubService mockGitHubService;
    late GitHubRepository githubRepository;

    setUp(() {
      mockGitHubService = MockGitHubService();
      githubRepository = GitHubRepository(mockGitHubService);
    });

    test('returns GitHub stats when getGitHubStats is called', () async {
      final profile = GitHubProfile(
        login: 'testuser',
        avatarUrl: 'https://example.com/avatar.png',
        htmlUrl: 'https://github.com/testuser',
        name: 'Test User',
        company: 'Test Company',
        blog: 'https://testblog.com',
        location: 'Test Location',
        bio: 'Test Bio',
        publicRepos: 10,
        followers: 5,
        following: 3,
        createdAt: '2020-01-01T00:00:00Z',
      );

      when(mockGitHubService.getGitHubProfile('testuser'))
          .thenAnswer((_) async => profile);

      final result = await githubRepository.getGitHubStats('testuser');

      expect(result['profile'], equals(profile));
      expect(result['stats']['repositories'], equals(10));
      expect(result['stats']['followers'], equals(5));
      expect(result['stats']['following'], equals(3));
      expect(result['stats']['accountAge'], isA<int>());
      expect(result['stats']['accountAge'], greaterThan(0));
    });

    test('throws exception when getGitHubStats encounters an error', () async {
      when(mockGitHubService.getGitHubProfile('testuser'))
          .thenThrow(Exception('User not found'));

      expect(() async => await githubRepository.getGitHubStats('testuser'),
          throwsException);
    });

    test('returns mock GitHub stats when getGitHubStatsMock is called', () async {
      final result = await githubRepository.getGitHubStatsMock('testuser');

      expect(result['profile'], isA<GitHubProfile>());
      expect(result['profile'].login, equals('testuser'));
      expect(result['profile'].name, equals('Svitlana Nesmiian'));
      expect(result['stats']['repositories'], equals(27));
      expect(result['stats']['followers'], equals(89));
      expect(result['stats']['following'], equals(34));
      expect(result['stats']['accountAge'], isA<int>());
    });

    test('calculates account age correctly for mock data', () async {
      final result = await githubRepository.getGitHubStatsMock('testuser');
      final accountAge = result['stats']['accountAge'] as int;

      expect(accountAge, greaterThan(0));
      expect(accountAge, isA<int>());
    });
  });

  group('Account Age Calculation', () {
    late MockGitHubService mockGitHubService;
    late GitHubRepository githubRepository;

    setUp(() {
      mockGitHubService = MockGitHubService();
      githubRepository = GitHubRepository(mockGitHubService);
    });

    test('handles invalid date format gracefully', () async {
      final profile = GitHubProfile(
        login: 'testuser',
        avatarUrl: 'https://example.com/avatar.png',
        htmlUrl: 'https://github.com/testuser',
        name: 'Test User',
        company: 'Test Company',
        blog: 'https://testblog.com',
        location: 'Test Location',
        bio: 'Test Bio',
        publicRepos: 10,
        followers: 5,
        following: 3,
        createdAt: 'invalid-date',
      );

      when(mockGitHubService.getGitHubProfile('testuser'))
          .thenAnswer((_) async => profile);

      final result = await githubRepository.getGitHubStats('testuser');

      expect(result['stats']['accountAge'], equals(0));
    });
  });
}