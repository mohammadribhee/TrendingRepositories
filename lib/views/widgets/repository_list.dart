import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trending_repositories/utils/date_range_helper.dart';
import '../../viewmodels/repository_viewmodel.dart';
import 'repository_card.dart';

class RepositoryList extends StatefulWidget {
  const RepositoryList({super.key});

  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreRepositories();
      }
    });
  }

  void _loadMoreRepositories() {
    final viewModel = Provider.of<RepositoryViewModel>(context, listen: false);
    viewModel.loadMoreRepositories(DateRangeHelper.getDateRange(
        viewModel.selectedTimeRange)); // Fetch more data
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RepositoryViewModel>(context);
    return viewModel.isLoading
        ? const Center(child: CircularProgressIndicator())
        : viewModel.repositories.isEmpty
            ? const Center(child: Text('No repositories found.'))
            : ListView.builder(
                controller: _scrollController,
                itemCount: viewModel.repositories.length +
                    (viewModel.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == viewModel.repositories.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return RepositoryCard(
                      repository: viewModel.repositories[index]);
                },
              );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
