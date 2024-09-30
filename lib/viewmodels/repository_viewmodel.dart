import 'package:flutter/material.dart';
import '../data/models/repository_model.dart';
import '../data/services/github_api_service.dart';

class RepositoryViewModel extends ChangeNotifier {
  List<Repository> repositories = [];
  final GitHubApiService apiService = GitHubApiService();
  bool isLoading = false;
  bool isLoadingMore = false; // New flag for loading more data
  int currentPage = 1; // Track pagination

  Future<void> fetchRepositories(String dateRange) async {
    isLoading = true;
    currentPage = 1; // Reset page on new fetch
    notifyListeners();
    try {
      final response =
          await apiService.fetchTrendingRepositories(dateRange, currentPage);
      repositories = response.map((json) => Repository.fromJson(json)).toList();
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreRepositories(String dateRange) async {
    if (isLoadingMore) return; // Prevent multiple requests at the same time
    isLoadingMore = true;
    currentPage++; // Increment page for next set of results
    notifyListeners();
    try {
      final response =
          await apiService.fetchTrendingRepositories(dateRange, currentPage);
      repositories
          .addAll(response.map((json) => Repository.fromJson(json)).toList());
    } catch (e) {
      // Handle error
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }
}
