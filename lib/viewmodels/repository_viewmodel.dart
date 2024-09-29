import 'package:flutter/material.dart';
import '../data/models/repository_model.dart';
import '../data/services/github_api_service.dart';

class RepositoryViewModel extends ChangeNotifier {
  List<Repository> repositories = [];
  final GitHubApiService apiService = GitHubApiService();
  bool isLoading = false; // New loading state

  Future<void> fetchRepositories(String dateRange) async {
    isLoading = true; // Set loading to true
    notifyListeners(); // Notify listeners to rebuild UI
    try {
      final response = await apiService.fetchTrendingRepositories(dateRange);
      repositories = response.map((json) => Repository.fromJson(json)).toList();
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false; // Set loading to false
      notifyListeners(); // Notify listeners to rebuild UI
    }
  }
}
