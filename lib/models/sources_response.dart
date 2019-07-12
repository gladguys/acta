import 'package:acta/models/source_response.dart';

class SourcesResponse {
  SourcesResponse({this.status, this.sources});

  factory SourcesResponse.fromJson(Map<String, dynamic> parsedJson) {
    final List<Map<String, dynamic>> responseSourcesList =
        List<Map<String, dynamic>>.from(parsedJson['sources']);

    final List<SourceResponse> sources = responseSourcesList
        .map((responseSourceJson) =>
            SourceResponse.fromJson(responseSourceJson))
        .toList();

    return SourcesResponse(
      status: parsedJson['status'],
      sources: sources
    );
  }

  final String status;
  final List<SourceResponse> sources;
}
