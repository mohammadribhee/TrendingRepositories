import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trending_repositories/data/services/favorites_service.dart';
import 'package:trending_repositories/views/screens/detail_screen.dart';
import '../../data/models/repository_model.dart';

class FavoriteRepositoriesScreen extends StatefulWidget {
  const FavoriteRepositoriesScreen({super.key});

  @override
  _FavoriteRepositoriesScreenState createState() =>
      _FavoriteRepositoriesScreenState();
}

class _FavoriteRepositoriesScreenState
    extends State<FavoriteRepositoriesScreen> {
  late Future<List<String>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoritesFuture = FavoritesService().getFavorites();
  }

  Future<void> _removeFavorite(String repositoryJson) async {
    // Call the existing removeFavorite method from FavoritesService
    await FavoritesService().removeFavorite(repositoryJson);

    // After removing the favorite, reload the favorites list and rebuild the UI
    setState(() {
      _loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Repositories'),
      ),
      body: FutureBuilder<List<String>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading favorites'));
          }

          final favorites = snapshot.data ?? [];
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorite repositories found.'));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final repositoryJson = favorites[index];
              final repository =
                  Repository.fromJson(json.decode(repositoryJson));

              return ListTile(
                title: Text(repository.name),
                subtitle: Text(repository.owner),
                onTap: () {
                  // Navigate to the detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(repository: repository),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // Call the removeFavorite method from FavoritesService
                    await _removeFavorite(repositoryJson);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
