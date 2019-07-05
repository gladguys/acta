class SourceResponse {
  SourceResponse(
      {this.id,
      this.name,
      this.description,
      this.url,
      this.category,
      this.language,
      this.country});

  factory SourceResponse.fromJson(Map<String, dynamic> parsedJson) {
    return SourceResponse(
        id: parsedJson['id'],
        name: parsedJson['name'],
        description: parsedJson['description'],
        url: parsedJson['url'],
        category: parsedJson['category'],
        language: parsedJson['language'],
        country: parsedJson['country']);
  }

  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;
}
