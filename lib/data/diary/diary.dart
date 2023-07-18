import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/data/core/converters.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:health_diary/domain/diary/value_obects.dart';
import 'package:kt_dart/collection.dart';

part 'diary.freezed.dart';

part 'diary.g.dart';

/// Data Transfer Object for Diary Entity
@freezed
class DiaryDto with _$DiaryDto {
  /// Main constructor
  factory DiaryDto({
    String? id,
    required String name,
    required String description,
    @DateTimeConverter() required DateTime createDate,
    required bool stopped,
    @DateTimeConverter() DateTime? stopDate,
    required List<AttributeDto> attributeList,
    required List<DataPointDto> dataPointList,
    required List<InputDataDto> inputDataList,
    required bool strictDataInput,
  }) = _DiaryDto;

  /// Constructor for serialization
  factory DiaryDto.fromJson(Map<String, dynamic> json) => _$DiaryDtoFromJson(json);

  /// constructor to construct from Firestore DocumentSnapshot
  factory DiaryDto.fromFirestore(DocumentSnapshot<Object?> doc) {
    return DiaryDto.fromJson(doc.data()! as Map<String, dynamic>).copyWith(id: doc.id);
  }

  /// constructor to construct from Diary entity
  factory DiaryDto.fromDomain(Diary diary) => DiaryDto(
        id: diary.id.getOrCrash(),
        name: diary.name.getOrCrash(),
        description: diary.description.getOrCrash(),
        createDate: diary.createDate,
        stopDate: diary.stopDate,
        stopped: diary.stopped,
        attributeList: List<AttributeDto>.generate(
          diary.attributeList.size,
          (int index) => AttributeDto.fromDomain(diary.attributeList[index]),
        ),
        dataPointList: List<DataPointDto>.generate(
          diary.dataPointList.size,
          (int index) => DataPointDto.fromDomain(
            diary.dataPointList[index],
          ),
        ),
        inputDataList: List<InputDataDto>.generate(
          diary.inputDataList.size,
          (int index) => InputDataDto.fromDomain(diary.inputDataList[index]),
        ),
        strictDataInput: diary.strictDataInput,
      );

  const DiaryDto._();

  /// method to convert to Diary entity
  Diary toDomain() => Diary(
        id: UniqueId.fromUniqueString(id!),
        name: DiaryName(name),
        description: DiaryDescription(description),
        createDate: createDate,
        stopDate: stopDate,
        stopped: stopped,
        attributeList: List<Attribute>.generate(
          attributeList.length,
          (int index) => attributeList[index].toDomain(),
        ).toImmutableList(),
        dataPointList: List<DataPoint>.generate(
          dataPointList.length,
          (int index) => dataPointList[index].toDomain(),
        ).toImmutableList(),
        inputDataList: List<InputData>.generate(
          inputDataList.length,
          (int index) => inputDataList[index].toDomain(attributeList),
        ).toImmutableList(),
        strictDataInput: strictDataInput,
      );
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
    required List<AttributeDto> attributeList,
  }) = _AttributeDto;

  /// constructor to construct from Attribute entity
  factory AttributeDto.fromDomain(Attribute attribute) => AttributeDto(
        name: attribute.name.getOrCrash(),
        unit: attribute.unit.getOrCrash(),
        attributeList: List<AttributeDto>.generate(
          attribute.attributeList.size,
          (int index) => AttributeDto.fromDomain(
            attribute.attributeList[index],
          ),
        ),
        minInput: attribute.minInput,
        maxInput: attribute.maxInput,
      );

  /// Constructor for serialization
  factory AttributeDto.fromJson(Map<String, dynamic> json) => _$AttributeDtoFromJson(json);

  AttributeDto._();

  /// method to convert to Attribute entity
  Attribute toDomain() => Attribute(
        name: AttributeName(name),
        unit: UnitName(unit),
        attributeList: List<Attribute>.generate(
          attributeList.length,
          (int index) => attributeList[index].toDomain(),
        ).toImmutableList(),
        minInput: minInput,
        maxInput: maxInput,
      );
}

/// Data Transfer Object for DataPoint Entity
@freezed
class DataPointDto with _$DataPointDto {
  /// Main constructor
  factory DataPointDto({
    @DateTimeConverter() required DateTime point,
    required List<String> attributeList,
  }) = _DataPointDto;

  /// constructor to construct from DataPoint entity
  factory DataPointDto.fromDomain(DataPoint dataPoint) => DataPointDto(
        point: dataPoint.point.getOrCrash(),
        attributeList: List<String>.generate(
          dataPoint.attributeList.size,
          (int index) => dataPoint.attributeList[index].getOrCrash(),
        ),
      );

  /// Constructor for serialization
  factory DataPointDto.fromJson(Map<String, dynamic> json) => _$DataPointDtoFromJson(json);

  DataPointDto._();

  /// method to convert to DataPoint entity
  DataPoint toDomain() => DataPoint(
        point: Point(point),
        attributeList: List<AttributeName>.generate(
          attributeList.length,
          (int index) => AttributeName(
            attributeList[index],
          ),
        ).toImmutableList(),
      );
}

/// Data Transfer Object for InputData Entity
@freezed
class InputDataDto with _$InputDataDto {
  /// Main constructor
  factory InputDataDto({
    @DateTimeConverter() required DateTime point,
    required Map<String, double> inputDataList,
  }) = _InputDataDto;

  /// constructor to construct from InputData entity
  factory InputDataDto.fromDomain(InputData inputData) {
    final Map<String, double> inputDataListDto = <String, double>{};

    inputData.inputDataList.forEach((AttributeName key, Input value) {
      inputDataListDto.addAll(<String, double>{
        key.getOrCrash(): value.getOrCrash(),
      });
    });

    return InputDataDto(
      point: inputData.point.getOrCrash(),
      inputDataList: inputDataListDto,
    );
  }

  /// Constructor for serialization
  factory InputDataDto.fromJson(Map<String, dynamic> json) => _$InputDataDtoFromJson(json);

  InputDataDto._();

  /// method to convert to InputData entity
  InputData toDomain(List<AttributeDto> attributeList) {
    final Map<AttributeName, Input> inputDataListDomain = <AttributeName, Input>{};

    inputDataList.forEach(
      (String key, double value) {
        final AttributeDto attribute = attributeList.firstWhere(
          (AttributeDto element) => key.compareTo(element.name) == 0,
        );

        inputDataListDomain.addAll(
          <AttributeName, Input>{
            AttributeName(key): Input(value, attribute.minInput, attribute.maxInput),
          },
        );
      },
    );

    return InputData(
      point: Point(point),
      inputDataList: inputDataListDomain.toImmutableMap(),
    );
  }
}
