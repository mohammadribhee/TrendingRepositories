import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/repository_viewmodel.dart';
import '../widgets/repository_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedTimeRange = 'Last Day'; // Default to 'Last Day'

  @override
  void initState() {
    super.initState();
    _fetchDataForSelectedTimeRange();
  }

  // Helper function to fetch data based on the selected time range
  void _fetchDataForSelectedTimeRange() {
    String dateRange;
    DateTime now = DateTime.now();

    if (_selectedTimeRange == 'Last Day') {
      dateRange =
          now.subtract(Duration(days: 1)).toIso8601String().split('T')[0];
    } else if (_selectedTimeRange == 'Last Week') {
      dateRange =
          now.subtract(Duration(days: 7)).toIso8601String().split('T')[0];
    } else {
      dateRange =
          now.subtract(Duration(days: 30)).toIso8601String().split('T')[0];
    }

    Provider.of<RepositoryViewModel>(context, listen: false)
        .fetchRepositories(dateRange);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RepositoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Repositories'),
        actions: [
          DropdownButton<String>(
            value: _selectedTimeRange,
            items: [
              DropdownMenuItem(value: 'Last Day', child: Text('Last Day')),
              DropdownMenuItem(value: 'Last Week', child: Text('Last Week')),
              DropdownMenuItem(value: 'Last Month', child: Text('Last Month')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedTimeRange = value!;
                _fetchDataForSelectedTimeRange(); // Fetch data when time range changes
              });
            },
          ),
        ],
      ),
      body: viewModel.repositories.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
              itemCount: viewModel.repositories.length,
              itemBuilder: (context, index) {
                return RepositoryCard(
                    repository: viewModel.repositories[index]);
              },
            ),
    );
  }
}
