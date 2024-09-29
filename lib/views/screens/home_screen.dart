import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/repository_viewmodel.dart';
import '../widgets/repository_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch trending repositories for a specific date range (e.g., last month)
    Provider.of<RepositoryViewModel>(context, listen: false)
        .fetchRepositories('2024-08-29');
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RepositoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Trending Repositories')),
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
