/// Defines collections wrapping type
enum UniversalCollections {
  /// Map collection
  map,

  /// List collection
  list,

  /// Nullable Map collection
  nullableMap,

  /// Nullable List collection
  nullableList,

  filter;

  /// Creates a [UniversalCollections]
  const UniversalCollections();

  /// Returns String representation of collection
  String get collectionsString => switch (this) {
        UniversalCollections.list ||
        UniversalCollections.nullableList =>
          'List<',
        UniversalCollections.map ||
        UniversalCollections.nullableMap =>
          'Map<String, ',
        UniversalCollections.filter => 'List<(',
      };

  String get closingCharacter => switch (this) {
        UniversalCollections.map ||
        UniversalCollections.list ||
        UniversalCollections.nullableMap ||
        UniversalCollections.nullableList =>
          '>',
        UniversalCollections.filter => ', String)>',
      };

  /// Returns question mark for collection
  String get questionMark => switch (this) {
        UniversalCollections.nullableList ||
        UniversalCollections.nullableMap =>
          '?',
        UniversalCollections.list ||
        UniversalCollections.map ||
        UniversalCollections.filter =>
          ''
      };
}
