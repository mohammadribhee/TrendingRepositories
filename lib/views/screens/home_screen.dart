import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/repository_viewmodel.dart';
import '../widgets/repository_card.dart';
import '../../utils/date_range_helper.dart'; // Import the helper class

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

  // Fetch data based on the selected time range using the helper
  void _fetchDataForSelectedTimeRange() {
    String dateRange = DateRangeHelper.getDateRange(_selectedTimeRange);
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
