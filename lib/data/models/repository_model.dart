class Repository {
  final String name;
  final String owner;
  final String avatarUrl;
  final int stars;
  final int forks;
  final String? language;
  final String createdAt;
  final String htmlUrl;
  final String description;

  Repository({
    required this.name,
    required this.owner,
    required this.avatarUrl,
    required this.stars,
    required this.forks,
    this.language,
    required this.createdAt,
    required this.htmlUrl,
    required this.description,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      owner: json['owner']['login'],
      avatarUrl: json['owner']['avatar_url'],
      stars: json['stargazers_count'],
      forks: json['forks_count'],
      language: json['language'],
      createdAt: json['created_at'],
      htmlUrl: json['html_url'],
      description: json['description'] ?? 'No description available',
    );
  }
}
