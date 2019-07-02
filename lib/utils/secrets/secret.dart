class Secret {
  
  Secret({this.apiKey = ''});
  
  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return Secret(apiKey: jsonMap['api_key']);
  }

  final String apiKey;
}