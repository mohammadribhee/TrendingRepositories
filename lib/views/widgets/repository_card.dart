// repository_card.dart
import 'package:flutter/material.dart';
import 'package:trending_repositories/views/screens/detail_screen.dart';
import 'package:trending_repositories/views/widgets/repository_detail_screen.dart';
import '../../data/models/repository_model.dart';

class RepositoryCard extends StatelessWidget {
  final Repository repository;

  const RepositoryCard({super.key, required this.repository});

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
              builder: (context) => DetailScreen(repository: repository)),
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
                    backgroundImage: NetworkImage(repository.avatarUrl),
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
                          repository.name,
                          style: TextStyle(
                            fontSize: screenWidth *
                                0.045, // Font size for repository name
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Adds ellipsis if text overflows
                        ),
                        Text(
                          repository.owner,
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
                      '${repository.stars} ⭐',
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
                repository.description,
                style: TextStyle(
                  fontSize: screenWidth * 0.035, // Font size for description
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
