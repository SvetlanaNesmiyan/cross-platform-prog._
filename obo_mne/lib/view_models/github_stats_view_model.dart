import 'package:flutter/foundation.dart';
import '../models/github_profile.dart';
import '../repositories/github_repository.dart';

class GitHubStatsViewModel with ChangeNotifier {
  final GitHubRepository _gitHubRepository;

  GitHubStatsViewModel(this._gitHubRepository);

  GitHubProfile? _profile;
  Map<String, dynamic>? _stats;
  bool _isLoading = false;
  String? _error;
  bool _usingMockData = false;

  GitHubProfile? get profile => _profile;
  Map<String, dynamic>? get stats => _stats;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get usingMockData => _usingMockData;

  Future<void> loadGitHubStats(String username) async {
    if (username.isEmpty) {
      _error = 'Please enter a GitHub username';
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    _usingMockData = false;
    notifyListeners();

    try {
      final result = await _gitHubRepository.getGitHubStats(username);
      _profile = result['profile'] as GitHubProfile;
      _stats = result['stats'] as Map<String, dynamic>;
      _usingMockData = false;
    } catch (e) {
      _error = 'Failed to load real GitHub data: $e\n\nYou can use demo data instead.';
      _profile = null;
      _stats = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadGitHubStatsMock(String username) async {
    _isLoading = true;
    _error = null;
    _usingMockData = true;
    notifyListeners();

    try {
      final result = await _gitHubRepository.getGitHubStatsMock(username);
      _profile = result['profile'] as GitHubProfile;
      _stats = result['stats'] as Map<String, dynamic>;
    } catch (e) {
      _error = 'Error loading demo data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}