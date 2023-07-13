import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/diary/value_obects.dart';

part 'diary.freezed.dart';

/// Diary entity contains all diary data including attributes, data points, all subordinate data, etc.
@freezed
class Diary with _$Diary {
  /// Main constructor
  factory Diary({
    required String id,
    required DiaryName diaryName,
    required DiaryDescription description,
    required DateTime startDate,
    required bool stopped,
    required List<Attribute> attributeList,
    required List<DataPoint> dataPointList,
    required List<InputData> inputDataList,
    required bool strictDataInput,
  }) = _Diary;
}

/// Diary attribute. diary attribute. The attribute by which you enter diary data, such as blood pressure or heart rate.
/// The attribute consists of a name and a unit of measurement. An attribute can consist of other attributes. This is
/// done to represent complex attributes that may consist of several attributes, e.g. blood pressure is an attribute
/// consisting of a diastolic and a systolic attribute.
@freezed
class Attribute with _$Attribute {
  /// Main constructor
  factory Attribute({
    required AttributeName attributeName,
    required UnitName unit,
    required List<Attribute> attributeList,
    required double minInput,
    required double maxInput,
  }) = _Attribute;
}

/// DataPoint is at what time the attribute data should be entered.
@freezed
class DataPoint with _$DataPoint {
  /// Main constructor
  factory DataPoint({
    required Point point,
    required List<AttributeName> attributeList,
  }) = _DataPoint;
}

/// Contains attribute inputs at a specific point
@freezed
class InputData with _$InputData {
  /// Main constructor
  factory InputData({
    required Point point,
    required Map<AttributeName, Input> inputDataList,
}) = _InputData;
}
