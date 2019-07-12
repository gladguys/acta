class NewsSource {
  NewsSource({this.id, this.name});

  factory NewsSource.fromJson(Map<String, dynamic> parsedJson) {
    return NewsSource(id: parsedJson['id'], name: parsedJson['name']);
  }

  final String id;
  final String name;
}
