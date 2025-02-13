import '../generator/model/programming_language.dart';
import '../parser/swagger_parser_core.dart';

/// Converts [UniversalType] to type from specified language
extension UniversalTypeX on UniversalType {
  /// Converts [UniversalType] to concrete type of certain [ProgrammingLanguage]
  String toSuitableType(
    ProgrammingLanguage lang, {
    bool allowNullForDefaults = false,
  }) {
    if (wrappingCollections.isEmpty) {
      return _questionMark(lang, allowNullForDefaults);
    }
    final sb = StringBuffer();
    for (final collection in wrappingCollections) {
      sb.write(collection.collectionsString);
    }
    sb.write(_questionMark(lang, allowNullForDefaults));
    for (final collection in wrappingCollections.reversed) {
      sb.write('>${collection.questionMark}');
    }

    return sb.toString();
  }

  String _questionMark(ProgrammingLanguage lang, bool allowNullForDefaults) {
    final questionMark = allowNullForDefaults
        // For Freezed/Retrofit, allow null to fallback on default.
        ? (nullable && !isRequired) || defaultValue != null
            ? '?'
            : ''
        : (isRequired || wrappingCollections.isNotEmpty) && !nullable ||
                defaultValue != null
            ? ''
            : '?';
    switch (lang) {
      case ProgrammingLanguage.dart:
        // https://github.com/trevorwang/retrofit.dart/issues/631
        // https://github.com/Carapacik/swagger_parser/issues/110
        return type.toDartType(format) +
            (type.toDartType(format) == 'dynamic' ? '' : questionMark);
      case ProgrammingLanguage.kotlin:
        return type.toKotlinType(format) + questionMark;
    }
  }
}
