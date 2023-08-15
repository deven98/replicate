class HeaderBuilder {
  static String? _internalApiKey;

  static set apiKey(String apiKey) {
    _internalApiKey = apiKey;
  }

  static Map<String, String> build([bool includeContentType = false]) {
    final Map<String, String> map = {};

    map.addEntries({
      _buildAuthorizationsHeader(),
      if (includeContentType) _buildContentType(),
      MapEntry("Access-Control-Allow-Origin", "*"),
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
