import 'package:http/http.dart' as http;
import 'dart:convert';

class GitHubApiService {
  static const String baseUrl = 'https://api.github.com/search/repositories';

  Future<List<dynamic>> fetchTrendingRepositories(String dateRange) async {
    final url = '$baseUrl?q=created:>$dateRange&sort=stars&order=desc';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['items'];
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
