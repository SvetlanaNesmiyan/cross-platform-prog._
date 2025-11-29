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
          'User-Agent': 'Flutter Resume Builder App',
          'Accept': 'application/vnd.github.v3+json',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return GitHubProfile.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('GitHub користувача не знайдено: $username');
      } else if (response.statusCode == 403) {
        throw Exception('Перевищено ліміт запитів до GitHub API. Спробуйте пізніше.');
      } else {
        throw Exception('Помилка завантаження профілю GitHub: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Мережева помилка: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Помилка формату даних: ${e.message}');
    } catch (e) {
      throw Exception('Неочікувана помилка: $e');
    }
  }
}