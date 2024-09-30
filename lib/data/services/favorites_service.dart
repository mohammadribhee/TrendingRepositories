import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_repositories';

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];
    return favoritesJson;
  }

  Future<void> addFavorite(String repositoryJson) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.add(repositoryJson);
    await prefs.setStringList(_favoritesKey, favorites);
  }

  Future<void> removeFavorite(String repositoryJson) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.remove(repositoryJson);
    await prefs.setStringList(_favoritesKey, favorites);
  }
}
