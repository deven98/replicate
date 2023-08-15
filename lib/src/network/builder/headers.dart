class HeaderBuilder {
  static String? _internalApiKey;

  static set apiKey(String apiKey) {
    _internalApiKey = apiKey;
  }

  static Map<String, String> build([bool includeContentType = false]) {
    final Map<String, String> map = {};

    map.addEntries({
      MapEntry("Access-Control-Allow-Origin", "*"), // Required for CORS support to work
      MapEntry("Access-Control-Allow-Credentials", "true"), // Required for cookies, authorization headers with HTTPS
      MapEntry("Access-Control-Allow-Headers", "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale"),
      MapEntry("Access-Control-Allow-Methods", "POST, OPTIONS"),
      _buildAuthorizationsHeader(),
      if (includeContentType) _buildContentType(),
    });

    return map;
  }

  static MapEntry<String, String> _buildAuthorizationsHeader() {
    final String authorizationValue = "Token $_internalApiKey";
    return MapEntry("Authorization", authorizationValue);
  }

  static MapEntry<String, String> _buildContentType() {
    return MapEntry("Content-Type", "application/json");
  }

  HeaderBuilder._();
}
