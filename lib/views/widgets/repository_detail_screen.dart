// repository_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening the GitHub URL
import '../../data/models/repository_model.dart';

class RepositoryDetailScreen extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Repository: ${repository.name}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Owner: ${repository.owner}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Stars: ${repository.stars}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Forks: ${repository.forks}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Language: ${repository.language ?? 'N/A'}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Created at: ${repository.createdAt}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final Uri url =
                    Uri.parse(repository.htmlUrl); // Convert the string to Uri
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text('Open GitHub Page'),
            ),
          ],
        ),
      ),
    );
  }
}
