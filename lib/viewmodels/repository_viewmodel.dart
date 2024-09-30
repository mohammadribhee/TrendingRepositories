import 'package:flutter/material.dart';
import '../data/models/repository_model.dart';
import '../data/services/github_api_service.dart';
import '../utils/date_range_helper.dart'; // Assuming you have this for date range

class RepositoryViewModel extends ChangeNotifier {
  List<Repository> repositories = [];
  final GitHubApiService apiService = GitHubApiService();
  bool isLoading = false;
  bool isLoadingMore = false;
  int currentPage = 1;

  RepositoryViewModel() {
    // Fetch data for the initial time range when ViewModel is created
    setTimeRange(_selectedTimeRange);
  }

  // Add selectedTimeRange with default value
  String _selectedTimeRange = 'Last Day';

  // Getter for selectedTimeRange
  String get selectedTimeRange => _selectedTimeRange;

  // Setter to update the selectedTimeRange and fetch repositories
  void setTimeRange(String newRange) {
    _selectedTimeRange = newRange;
    repositories.clear(); // Clear previous repositories
    fetchRepositories(DateRangeHelper.getDateRange(_selectedTimeRange));
    notifyListeners();
  }

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
