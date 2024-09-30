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
      appBar: AppBar(
        title: Text(repository.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Owner: ${repository.owner}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Stars: ${repository.stars}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Forks: ${repository.forks}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Language: ${repository.language ?? 'N/A'}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Created at: ${repository.createdAt}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
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
