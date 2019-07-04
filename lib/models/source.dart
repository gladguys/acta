class Source {
  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> parsedJson) {
    return Source(id: parsedJson['id'], name: parsedJson['name']);
  }

  final String id;
  final String name;
}
