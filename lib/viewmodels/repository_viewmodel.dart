import 'package:flutter/material.dart';
import '../data/models/repository_model.dart';
import '../data/services/github_api_service.dart';

class RepositoryViewModel extends ChangeNotifier {
  List<Repository> repositories = [];
  final GitHubApiService apiService = GitHubApiService();

  Future<void> fetchRepositories(String dateRange) async {
    try {
      final response = await apiService.fetchTrendingRepositories(dateRange);
      repositories = response.map((json) => Repository.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
