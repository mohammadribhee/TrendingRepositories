import 'package:flutter/material.dart';
import '../../data/models/repository_model.dart';

class RepositoryCard extends StatelessWidget {
  final Repository repository;

  const RepositoryCard({required this.repository});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(repository.avatarUrl),
        ),
        title: Text(repository.name),
        subtitle: Text(repository.owner),
        trailing: Text('${repository.stars} ⭐'),
      ),
    );
  }
}
