import 'package:http/http.dart' as http;
import 'dart:convert';

class GitHubApiService {
  static const String baseUrl = 'https://api.github.com/search/repositories';

  Future<List<dynamic>> fetchTrendingRepositories(String dateRange) async {
    // Correctly encode the query parameters
    final queryParameters = {
      'q': 'created:>$dateRange',
      'sort': 'stars',
      'order': 'desc',
    };

    // Build the full URI
    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

    // Optional: Include your personal access token in headers if you need more than 60 requests/hour
    // final headers = {
    //   'Authorization': 'token YOUR_PERSONAL_ACCESS_TOKEN',
    //   'Accept': 'application/vnd.github.v3+json',
    // };

    // Default headers without token
    final headers = {
      'Accept': 'application/vnd.github.v3+json',
    };

    // Make the GET request
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // Parse the JSON response and return the 'items' list
      return jsonDecode(response.body)['items'];
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
