// repository_card.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trending_repositories/data/services/favorites_service.dart';
import 'package:trending_repositories/views/screens/detail_screen.dart';
import '../../data/models/repository_model.dart';

class RepositoryCard extends StatefulWidget {
  final Repository repository;

  const RepositoryCard({super.key, required this.repository});

  @override
  _RepositoryCardState createState() => _RepositoryCardState();
}

class _RepositoryCardState extends State<RepositoryCard> {
  final FavoritesService _favoritesService = FavoritesService();
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();
  }

  Future<void> _checkIfFavorited() async {
    final favorites = await _favoritesService.getFavorites();
    setState(() {
      isFavorited = favorites.contains(widget.repository.toJson());
    });
  }

  Future<void> _toggleFavorite() async {
    if (isFavorited) {
      await _favoritesService
          .removeFavorite(json.encode(widget.repository.toJson()));
    } else {
      await _favoritesService
          .addFavorite(json.encode(widget.repository.toJson()));
    }
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        // Navigate to the detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailScreen(repository: widget.repository)),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.01, // 1% of screen height
          horizontal: screenWidth * 0.05, // 5% of screen width
        ),
        child: Padding(
          padding: EdgeInsets.all(
              screenWidth * 0.03), // Adjust padding inside the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.repository.avatarUrl),
                    radius: screenWidth *
                        0.06, // Adjust avatar size (slightly smaller)
                  ),
                  SizedBox(
                      width:
                          screenWidth * 0.03), // Spacing between image and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.repository.name,
                          style: TextStyle(
                            fontSize: screenWidth *
                                0.045, // Font size for repository name
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Adds ellipsis if text overflows
                        ),
                        Text(
                          widget.repository.owner,
                          style: TextStyle(
                            fontSize:
                                screenWidth * 0.035, // Font size for owner
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Adds ellipsis if text overflows
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${widget.repository.stars} ⭐',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Font size for stars
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: screenHeight *
                      0.01), // Spacing between row and description
              Text(
                widget.repository.description,
                style: TextStyle(
                  fontSize: screenWidth * 0.035, // Font size for description
                  color: Colors.grey[600],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: isFavorited ? Colors.red : null,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
