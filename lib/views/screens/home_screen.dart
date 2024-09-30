import 'package:flutter/material.dart';
import 'package:trending_repositories/views/screens/favorite_repositories_screen.dart';
import '../widgets/repository_list.dart';
import '../widgets/time_range_dropdown.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Repositories'),
        actions: [
          TimeRangeDropdown(), // Moved the dropdown to a separate widget
          IconButton(
            icon: const Icon(Icons.favorite), // Use a heart icon for favorites
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteRepositoriesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: RepositoryList(), // Separated ListView into its own widget
      ),
    );
  }
}
