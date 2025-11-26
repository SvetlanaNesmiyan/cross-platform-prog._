import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:obo_mne/view_models/github_stats_view_model.dart';
import 'package:obo_mne/repositories/github_repository.dart';
import 'package:obo_mne/models/github_profile.dart';

import 'github_stats_view_model_test.mocks.dart';

@GenerateMocks([GitHubRepository])
void main() {
  group('GitHubStatsViewModel', () {
    late MockGitHubRepository mockGitHubRepository;
    late GitHubStatsViewModel viewModel;

    setUp(() {
      mockGitHubRepository = MockGitHubRepository();
      viewModel = GitHubStatsViewModel(mockGitHubRepository);
    });

    test('initial state is correct', () {
      expect(viewModel.profile, isNull);
      expect(viewModel.stats, isNull);
      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNull);
      expect(viewModel.usingMockData, false);
    });

    test('loadGitHubStats sets error when username is empty', () async {
      // Act
      await viewModel.loadGitHubStats('');

      // Assert
      expect(viewModel.error, equals('Please enter a GitHub username'));
      expect(viewModel.isLoading, false);
      expect(viewModel.profile, isNull);
      expect(viewModel.stats, isNull);
    });

    test('loadGitHubStats updates state correctly on success', () async {
      // Arrange
      final mockProfile = GitHubProfile(
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

      final mockStats = {
        'repositories': 10,
        'followers': 5,
        'following': 3,
        'accountAge': 4,
      };

      when(mockGitHubRepository.getGitHubStats('testuser'))
          .thenAnswer((_) async => {
                'profile': mockProfile,
                'stats': mockStats,
              });

      // Act
      await viewModel.loadGitHubStats('testuser');

      // Assert
      expect(viewModel.profile, equals(mockProfile));
      expect(viewModel.stats, equals(mockStats));
      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNull);
      expect(viewModel.usingMockData, false);
    });

    test('loadGitHubStats handles errors correctly', () async {
      // Arrange
      when(mockGitHubRepository.getGitHubStats('testuser'))
          .thenThrow(Exception('User not found'));

      // Act
      await viewModel.loadGitHubStats('testuser');

      // Assert
      expect(viewModel.profile, isNull);
      expect(viewModel.stats, isNull);
      expect(viewModel.isLoading, false);
      expect(viewModel.error, contains('Failed to load real GitHub data'));
      expect(viewModel.usingMockData, false);
    });

    test('loadGitHubStatsMock updates state correctly', () async {
      // Arrange
      final mockProfile = GitHubProfile(
        login: 'testuser',
        avatarUrl: 'https://example.com/avatar.png',
        htmlUrl: 'https://github.com/testuser',
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

      final mockStats = {
        'repositories': 27,
        'followers': 89,
        'following': 34,
        'accountAge': 4,
      };

      when(mockGitHubRepository.getGitHubStatsMock('testuser'))
          .thenAnswer((_) async => {
                'profile': mockProfile,
                'stats': mockStats,
              });

      // Act
      await viewModel.loadGitHubStatsMock('testuser');

      // Assert
      expect(viewModel.profile, equals(mockProfile));
      expect(viewModel.stats, equals(mockStats));
      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNull);
      expect(viewModel.usingMockData, true);
    });

    test('loadGitHubStatsMock handles errors correctly', () async {
      // Arrange
      when(mockGitHubRepository.getGitHubStatsMock('testuser'))
          .thenThrow(Exception('Mock data error'));

      // Act
      await viewModel.loadGitHubStatsMock('testuser');

      // Assert
      expect(viewModel.profile, isNull);
      expect(viewModel.stats, isNull);
      expect(viewModel.isLoading, false);
      expect(viewModel.error, contains('Error loading demo data'));
      expect(viewModel.usingMockData, true);
    });
  });
}