import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GitHubApiService {
  static const String baseUrl = 'https://api.github.com/search/repositories';

  Future<List<dynamic>> fetchTrendingRepositories(
      String dateRange, int page) async {
    final queryParameters = {
      'q': 'created:>$dateRange',
      'sort': 'stars',
      'order': 'desc',
      'page': '$page', // Add page parameter for pagination
      'per_page': '100', // You can set how many items to load per page
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

// Default headers without token
    // final headers = {
    //   'Accept': 'application/vnd.github.v3+json',
    // };

    final token = dotenv.env['GITHUB_TOKEN'];
    final headers = {
      'Authorization': 'token $token',
      'Accept': 'application/vnd.github.v3+json',
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['items'];
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
