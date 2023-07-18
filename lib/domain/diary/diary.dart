import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/core/failures.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/diary/value_obects.dart';
import 'package:kt_dart/kt.dart';

part 'diary.freezed.dart';

/// Diary entity contains all diary data including attributes, data points, all subordinate data, etc.
@freezed
class Diary with _$Diary {
  /// Main constructor
  factory Diary({
    required UniqueId id,
    required DiaryName name,
    required DiaryDescription description,
    required DateTime createDate,
    required DateTime? stopDate,
    required bool stopped,
    required KtMutableList<Attribute> attributeList,
    required KtMutableList<DataPoint> dataPointList,
    required KtMutableList<InputData> inputDataList,
    required bool strictDataInput,
  }) = _Diary;

  /// constructor to construct empty Diary
  factory Diary.empty() => Diary(
        id: UniqueId.fromUniqueString(''),
        name: DiaryName(''),
        description: DiaryDescription(''),
        createDate: DateTime.utc(0),
        stopDate: null,
        stopped: false,
        attributeList: KtMutableList<Attribute>.empty(),
        dataPointList: KtMutableList<DataPoint>.empty(),
        inputDataList: KtMutableList<InputData>.empty(),
        strictDataInput: false,
      );

  Diary._();

  /// entity data validation
  Option<ValueFailure<dynamic>> get failureOptionFull {
    return name.failureOrUnit
        .andThen(description.failureOrUnit)
        .andThen(
          attributeList
              .map((Attribute attribute) => attribute.failureOption)
              .filter((Option<ValueFailure<dynamic>> o) => o.isSome())
              .getOrElse(0, (_) => none())
              .fold(() => right(unit), (ValueFailure<dynamic> f) => left(f)),
        )
        .andThen(
          dataPointList
              .map((DataPoint dataPoint) => dataPoint.failureOption)
              .filter((Option<ValueFailure<dynamic>> o) => o.isSome())
              .getOrElse(0, (_) => none())
              .fold(() => right(unit), (ValueFailure<dynamic> f) => left(f)),
        )
        .andThen(
          inputDataList
              .map((InputData inputData) => inputData.failureOption)
              .filter((Option<ValueFailure<dynamic>> o) => o.isSome())
              .getOrElse(0, (_) => none())
              .fold(() => right(unit), (ValueFailure<dynamic> f) => left(f)),
        )
        .fold((ValueFailure<dynamic> f) => some(f), (_) => none());
  }

  /// entity data validation without InputData list
  Option<ValueFailure<dynamic>> get failureOptionWithoutInputList {
    return name.failureOrUnit
        .andThen(description.failureOrUnit)
        .andThen(
          attributeList
              .map((Attribute attribute) => attribute.failureOption)
              .filter((Option<ValueFailure<dynamic>> o) => o.isSome())
              .getOrElse(0, (_) => none())
              .fold(() => right(unit), (ValueFailure<dynamic> f) => left(f)),
        )
        .andThen(
          dataPointList
              .map((DataPoint dataPoint) => dataPoint.failureOption)
              .filter((Option<ValueFailure<dynamic>> o) => o.isSome())
              .getOrElse(0, (_) => none())
              .fold(() => right(unit), (ValueFailure<dynamic> f) => left(f)),
        )
        .fold((ValueFailure<dynamic> f) => some(f), (_) => none());
  }

  /// entity data validation without DataPoint list and InputData list
  Option<ValueFailure<dynamic>> get failureOptionWithoutDataPointAndInputList {
    return name.failureOrUnit
        .andThen(description.failureOrUnit)
        .andThen(
          attributeList
              .map((Attribute attribute) => attribute.failureOption)
              .filter((Option<ValueFailure<dynamic>> o) => o.isSome())
              .getOrElse(0, (_) => none())
              .fold(() => right(unit), (ValueFailure<dynamic> f) => left(f)),
        )
        .fold((ValueFailure<dynamic> f) => some(f), (_) => none());
  }
}

/// Diary attribute. diary attribute. The attribute by which you enter diary data, such as blood pressure or heart rate.
/// The attribute consists of a name and a unit of measurement. An attribute can consist of other attributes. This is
/// done to represent complex attributes that may consist of several attributes, e.g. blood pressure is an attribute
/// consisting of a diastolic and a systolic attribute.
@freezed
class Attribute with _$Attribute {
  /// Main constructor
  factory Attribute({
    required AttributeName name,
    required UnitName unit,
    required KtMutableList<Attribute> attributeList,
    required double minInput,
    required double maxInput,
  }) = _Attribute;

  /// Constructor to create empty Attribute
  factory Attribute.empty() => Attribute(
        name: AttributeName(''),
        unit: UnitName(''),
        attributeList: KtMutableList<Attribute>.empty(),
        minInput: 0,
        maxInput: 0,
      );

  Attribute._();

  /// entity data validation
  Option<ValueFailure<dynamic>> get failureOption {
    return name.failureOrUnit
        .andThen(this.unit.failureOrUnit)
        .andThen(
          attributeList
              .map((Attribute attribute) => attribute.failureOption)
              .filter((Option<ValueFailure<dynamic>> o) => o.isSome())
              .getOrElse(0, (_) => none())
              .fold(() => right(unit), (ValueFailure<dynamic> f) => left(f)),
        )
        .fold((ValueFailure<dynamic> f) => some(f), (_) => none());
  }
}

/// DataPoint is at what time the attribute data should be entered.
@freezed
class DataPoint with _$DataPoint {
  /// Main constructor
  factory DataPoint({
    required Point point,
    required KtMutableList<AttributeName> attributeList,
  }) = _DataPoint;

  /// Constructor to create empty DataPoint
  factory DataPoint.empty() => DataPoint(
        point: Point(DateTime.utc(0)),
        attributeList: KtMutableList<AttributeName>.empty(),
      );

  DataPoint._();

  /// entity data validation
  Option<ValueFailure<dynamic>> get failureOption {
    return point.value.fold((ValueFailure<dynamic> f) => some(f), (_) => none());
  }
}

/// Contains attribute inputs at a specific point
@freezed
class InputData with _$InputData {
  /// Main constructor
  factory InputData({
    required Point point,
    required KtMap<AttributeName, Input> inputDataList,
  }) = _InputData;

  InputData._();

  /// entity data validation
  Option<ValueFailure<dynamic>> get failureOption {
    return inputDataList
        .map((KtMapEntry<AttributeName, Input> entry) => entry.value.failureOrUnit)
        .filter((Either<ValueFailure<dynamic>, Unit> element) => element.isRight())
        .getOrElse(
          0,
          (_) => left(const ValueFailure<String>.unacceptableAge(failedValue: '')),
        )
        .fold((ValueFailure<dynamic> f) => some(f), (_) => none());
  }
}
