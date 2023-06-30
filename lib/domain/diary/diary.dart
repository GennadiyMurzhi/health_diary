import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary.freezed.dart';

@freezed
class Diary with _$Diary {
  factory Diary({
    required String diaryName,
    required DateTime startIt,
    required bool stopped,
    required List<Attribute> attributeList,
    required List<EnteredData> enteredData,
    required List<DateTime> upcomingDataEntries,
  }) = _Diary;
}

@freezed
class EnteredData with _$EnteredData {
  factory EnteredData({
    required DateTime enteredDateTime,
    required Fraction fraction,
    required String unit,
  }) = _EnteredData;
}

@freezed
class Attribute with _$Attribute {
  factory Attribute({
    required String attributeName,
    required String unit,
  }) = _Attribute;
}

@freezed
class Fraction with _$Fraction {
  factory Fraction({
    required bool isFraction,
    required double numerator,
    double? denominator,
  }) = _Fraction;
}
