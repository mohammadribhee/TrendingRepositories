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
  final ScrollController _scrollController = ScrollController();
  String _selectedTimeRange = 'Last Day'; // Default to 'Last Day'

  @override
  void initState() {
    super.initState();
    _fetchDataForSelectedTimeRange();

    // Add scroll listener to detect when user reaches the bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreRepositories();
      }
    });
  }

  void _fetchDataForSelectedTimeRange() {
    String dateRange = DateRangeHelper.getDateRange(_selectedTimeRange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RepositoryViewModel>(context, listen: false)
          .fetchRepositories(dateRange);
    });
  }

  void _loadMoreRepositories() {
    String dateRange = DateRangeHelper.getDateRange(_selectedTimeRange);
    Provider.of<RepositoryViewModel>(context, listen: false)
        .loadMoreRepositories(dateRange); // Load more data when at the end
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
            : viewModel.repositories.isEmpty
                ? const Center(
                    child: Text(
                        'No repositories found for the selected timeframe.'))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: viewModel.repositories.length +
                        (viewModel.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == viewModel.repositories.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                              child:
                                  CircularProgressIndicator()), // Loader at the bottom
                        );
                      }
                      return RepositoryCard(
                          repository: viewModel.repositories[index]);
                    },
                  ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
