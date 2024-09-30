import 'dart:convert';

class Repository {
  final String name;
  final String owner;
  final String avatarUrl;
  final int stars;
  final String description;
  final int forks;
  final String? language;
  final String createdAt;
  final String htmlUrl;

  Repository({
    required this.name,
    required this.owner,
    required this.avatarUrl,
    required this.stars,
    required this.description,
    required this.forks,
    required this.language,
    required this.createdAt,
    required this.htmlUrl,
  });

  // Factory constructor to handle JSON safely
  factory Repository.fromJson(Map<String, dynamic> json) {
    // Handle the 'owner' field safely
    String ownerLogin = json['owner'] is Map<String, dynamic>
        ? json['owner']['login'] ?? ''
        : '';
    String avatarUrl = json['owner'] is Map<String, dynamic>
        ? json['owner']['avatar_url'] ?? ''
        : '';

    return Repository(
      name:
          json['name'] ?? 'Unknown repository', // Default if 'name' is missing
      owner: ownerLogin,
      avatarUrl: avatarUrl, // Handle case where 'avatar_url' might be missing
      stars: json['stargazers_count'] ?? 0,
      description: json['description'] ??
          'No description available', // Handle null or missing description
      forks: json['forks_count'] ?? 0,
      language: json['language'], // This can be nullable
      createdAt: json['created_at'] ?? 'Unknown date', // Handle missing date
      htmlUrl: json['html_url'] ?? '', // Provide fallback for missing html_url
    );
  }

  // Convert to JSON for storing favorites locally
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'owner': owner,
      'avatarUrl': avatarUrl,
      'stars': stars,
      'description': description,
      'forks': forks,
      'language': language,
      'createdAt': createdAt,
      'htmlUrl': htmlUrl,
    };
  }

  // Encode to JSON string for local storage
  String encodeToJsonString() => json.encode(toJson());

  // Decode JSON string to Repository object
  static Repository fromJsonString(String jsonString) {
    Map<String, dynamic> jsonData = json.decode(jsonString);
    return Repository.fromJson(jsonData);
  }
}
