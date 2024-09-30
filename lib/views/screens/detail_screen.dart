import 'package:flutter/material.dart';
import 'package:trending_repositories/views/widgets/repository_detail_screen.dart';
import '../../data/models/repository_model.dart'; // Adjust the import path as necessary

class DetailScreen extends StatelessWidget {
  final Repository repository; // Single repository passed to DetailScreen

  const DetailScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository Detail'),
      ),
      body: RepositoryDetailScreen(
          repository: repository), // Embed the RepositoryDetailScreen widget
    );
  }
}
