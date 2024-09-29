class Repository {
  final String name;
  final String owner;
  final String avatarUrl;
  final int stars;
  final String description;

  Repository({
    required this.name,
    required this.owner,
    required this.avatarUrl,
    required this.stars,
    required this.description,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      owner: json['owner']['login'],
      avatarUrl: json['owner']['avatar_url'],
      stars: json['stargazers_count'],
      description: json['description'] ?? 'No description available',
    );
  }
}
