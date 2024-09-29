import 'package:flutter/material.dart';
import '../../data/models/repository_model.dart';

class RepositoryCard extends StatelessWidget {
  final Repository repository;

  const RepositoryCard({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01, // 1% of screen height
        horizontal: screenWidth * 0.05, // 5% of screen width
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(repository.avatarUrl),
                  radius: screenWidth * 0.07, // Adjust avatar size
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
                              0.05, // Adjust font size for the repository name
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        repository.owner,
                        style: TextStyle(
                          fontSize: screenWidth *
                              0.04, // Adjust font size for the owner
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${repository.stars} ⭐',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045, // Adjust font size for stars
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
                height: screenHeight *
                    0.01), // Spacing between the row and the description
            Text(
              repository.description,
              style: TextStyle(
                fontSize:
                    screenWidth * 0.04, // Adjust font size for the description
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
