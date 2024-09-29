import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/repository_viewmodel.dart';
import '../widgets/repository_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RepositoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Trending Repositories')),
      body: ListView.builder(
        itemCount: viewModel.repositories.length,
        itemBuilder: (context, index) {
          return RepositoryCard(repository: viewModel.repositories[index]);
        },
      ),
    );
  }
}
