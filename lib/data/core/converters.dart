import 'package:json_annotation/json_annotation.dart';
import 'package:kt_dart/collection.dart';

/// Converter DateTime from string for serialization
class DateTimeConverter implements JsonConverter<DateTime, String> {
  /// Need const constructor to use as annotation
  const DateTimeConverter();

  @override
  DateTime fromJson(String string) {
    return DateTime.parse(string);
  }

  @override
  String toJson(DateTime dateTime) => dateTime.toString();
}

/// Converter KtList from List for serialization
class KtListConverter implements JsonConverter<KtList<dynamic>, List<dynamic>> {
  /// Need const constructor to use as annotation
  const KtListConverter();

  @override
  KtList<dynamic> fromJson(List<dynamic> list) {
    return list.toImmutableList();
  }

  @override
  List<dynamic> toJson(KtList<dynamic> list) => list.asList();
}

/// Converter KtMap from Map for serialization
class KtMapConverter implements JsonConverter<KtMap<String, dynamic>, Map<String, dynamic>> {
  /// Need const constructor to use as annotation
  const KtMapConverter();

  @override
  KtMap<String, dynamic> fromJson(Map<String, dynamic> map) {
    return map.toImmutableMap();
  }

  @override
  Map<String, dynamic> toJson(KtMap<String, dynamic> map) => map.asMap();
}
