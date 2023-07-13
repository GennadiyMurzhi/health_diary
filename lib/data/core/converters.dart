import 'package:json_annotation/json_annotation.dart';

/// Converter DateTime from string for serialization
class DateTimeConverter implements JsonConverter<DateTime, String> {
  /// Need const constructor to use as annotation
  const DateTimeConverter();

  @override
  DateTime fromJson(String formattedString) {
    return DateTime.parse(formattedString);
  }

  @override
  String toJson(DateTime dateTime) => dateTime.toString();
}
