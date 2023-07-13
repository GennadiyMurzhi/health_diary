import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/data/core/converters.dart';

part 'diary.freezed.dart';

part 'diary.g.dart';

/// Data Transfer Object for Diary Entity
@freezed
class DiaryDto with _$DiaryDto {
  /// Main constructor
  factory DiaryDto({
    String? id,
    required String diaryName,
    required String description,
    @DateTimeConverter() required DateTime startDate,
    required List<AttributeDto> attributeList,
    required List<DataPointDto> dataPointList,
    required List<InputDataDto> inputDataList,
    required bool strictDataInput,
  }) = _DiaryDto;

  const DiaryDto._();

  /// Constructor for serialization
  factory DiaryDto.fromJson(Map<String, dynamic> json) => _$DiaryDtoFromJson(json);
}

/// Data Transfer Object for Attribute Entity
@freezed
class AttributeDto with _$AttributeDto {
  /// Main constructor
  factory AttributeDto({
    required String name,
    required String unit,
    required double maxInput,
    required double minInput,
  }) = _AttributeDto;

  AttributeDto._();

  /// Constructor for serialization
  factory AttributeDto.fromJson(Map<String, dynamic> json) => _$AttributeDtoFromJson(json);
}

/// Data Transfer Object for DataPoint Entity
@freezed
class DataPointDto with _$DataPointDto {
  /// Main constructor
  factory DataPointDto({
    @DateTimeConverter() required DateTime dataPointTime,
    required List<String> attributeList,
  }) = _DataPointDto;

  DataPointDto._();

  /// Constructor for serialization
  factory DataPointDto.fromJson(Map<String, dynamic> json) => _$DataPointDtoFromJson(json);
}

/// Data Transfer Object for InputData Entity
@freezed
class InputDataDto with _$InputDataDto {
  /// Main constructor
  factory InputDataDto({
    required String attributeName,
    required double input,
  }) = _InputDataDto;

  InputDataDto._();

  /// Constructor for serialization
  factory InputDataDto.fromJson(Map<String, dynamic> json) => _$InputDataDtoFromJson(json);
}
