// lib/services/github_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_profile.dart';

class GitHubService {
  final http.Client client;

  GitHubService(this.client);

  Future<GitHubProfile> getGitHubProfile(String username) async {
    try {
      final response = await client.get(
        Uri.parse('https://api.github.com/users/$username'),
        headers: {
          'User-Agent': 'Flutter App',
          'Accept': 'application/vnd.github.v3+json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('GitHub API Response: $jsonData'); // Додайте це для дебагу
        return GitHubProfile.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('GitHub user not found: $username');
      } else {
        throw Exception('Failed to load GitHub profile: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Data format error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}