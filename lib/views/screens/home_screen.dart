import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/repository_viewmodel.dart';
import '../widgets/repository_card.dart';
import '../../utils/date_range_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  void _fetchDataForSelectedTimeRange() {
    String dateRange = DateRangeHelper.getDateRange(_selectedTimeRange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RepositoryViewModel>(context, listen: false)
          .fetchRepositories(dateRange);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RepositoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Repositories'),
        actions: [
          DropdownButton<String>(
            value: _selectedTimeRange,
            items: const [
              DropdownMenuItem(value: 'Last Day', child: Text('Last Day')),
              DropdownMenuItem(value: 'Last Week', child: Text('Last Week')),
              DropdownMenuItem(value: 'Last Month', child: Text('Last Month')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedTimeRange = value!;
                _fetchDataForSelectedTimeRange();
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: viewModel.repositories.length,
                itemBuilder: (context, index) {
                  return RepositoryCard(
                      repository: viewModel.repositories[index]);
                },
              ),
      ),
    );
  }
}
