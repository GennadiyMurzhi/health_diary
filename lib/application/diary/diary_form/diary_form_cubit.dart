import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:health_diary/domain/diary/diary_failure.dart';
import 'package:health_diary/domain/diary/i_diary_repository.dart';
import 'package:health_diary/domain/diary/value_obects.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';

part 'diary_form_state.dart';

part 'diary_form_cubit.freezed.dart';

/// Cubit for form screen to crete Diary
@injectable
class DiaryFormCubit extends Cubit<DiaryFormState> {
  /// Main constructor
  DiaryFormCubit(this._diaryRepository) : super(DiaryFormState.initial());

  final IDiaryRepository _diaryRepository;

  /// Method to init Diary Form. Need if need to edit Diary
  void initial(Diary diary) {
    emit(
      state.copyWith(
        diary: diary,
        isEditing: true,
      ),
    );
  }

  /// Method to change Diary name
  void onChangeName(String name) {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          name: DiaryName(name),
        ),
      ),
    );
  }

  /// Method to change Diary description
  void onChangeDescription(String description) {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          description: DiaryDescription(description),
        ),
      ),
    );
  }

  /// Method to change Diary description
  void onStartAddingAttribute(String description) {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          description: DiaryDescription(description),
        ),
      ),
    );
  }

  /// Method to add Attribute
  void addAttribute() {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          attributeList: KtMutableList<Attribute>.from(
            (state.diary.attributeList..add(Attribute.empty())).asList(),
          ),
        ),
      ),
    );
  }

  /// Method to add sub Attribute
  void addSubAttribute(int index) {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          attributeList: KtMutableList<Attribute>.from(
            (state.diary.attributeList
                  ..[index] = state.diary.attributeList[index].copyWith(
                    attributeList: state.diary.attributeList[index].attributeList
                      ..add(
                        Attribute.empty(),
                      ),
                  ))
                .asList(),
          ),
        ),
      ),
    );
  }

  /// Method to change specific Attribute. Pass the Attribute index in the list and the parameters to change
  void onChangeAttribute(
    int index, {
    String? name,
    String? unit,
    double? minInput,
    double? maxInput,
  }) {
    final Attribute attribute = _changeAttribute(
      state.diary.attributeList[index],
      name: name,
      unit: unit,
      minInput: minInput,
      maxInput: maxInput,
    );

    final KtMutableList<Attribute> changedList =
        KtMutableList<Attribute>.from((state.diary.attributeList..[index] = attribute).asList());

    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          attributeList: changedList,
        ),
      ),
    );
  }

  /// Method to change sub Attribute of specific Attribute. Pass the Attribute index in the list and the parameters to
  /// change
  void onChangeSubAttribute(
    int index,
    int subIndex, {
    String? name,
    String? unit,
    double? minInput,
    double? maxInput,
  }) {
    final Attribute attribute = _changeAttribute(
      state.diary.attributeList[index].attributeList[subIndex],
      name: name,
      unit: unit,
      minInput: minInput,
      maxInput: maxInput,
    );

    final KtMutableList<Attribute> changedList = state.diary.attributeList
      ..[index] = state.diary.attributeList[index].copyWith(
        attributeList: state.diary.attributeList[index].attributeList..[subIndex] = attribute,
      );

    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          attributeList: changedList,
        ),
      ),
    );
  }

  Attribute _changeAttribute(
    Attribute attribute, {
    String? name,
    String? unit,
    double? minInput,
    double? maxInput,
  }) {
    Attribute changedAttribute = attribute;
    if (name != null) {
      changedAttribute = changedAttribute.copyWith(
        name: AttributeName(name),
      );
    }
    if (unit != null) {
      changedAttribute = changedAttribute.copyWith(
        unit: UnitName(unit),
      );
    }
    if (minInput != null) {
      changedAttribute = changedAttribute.copyWith(
        minInput: minInput,
      );
    }
    if (maxInput != null) {
      changedAttribute = changedAttribute.copyWith(
        maxInput: maxInput,
      );
    }

    return attribute;
  }

  /// Method to delete Attribute
  void deleteAttribute(int index) {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          attributeList: KtMutableList<Attribute>.from(
            state.diary.attributeList.asList()..removeAt(index),
          ),
        ),
      ),
    );
  }

  /// Method to delete sub Attribute from Attribute
  void deleteSubAttribute(
    int index,
    int subIndex,
  ) {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          attributeList: KtMutableList<Attribute>.from(
            (state.diary.attributeList
                  ..[index] = state.diary.attributeList[index].copyWith(
                    attributeList: state.diary.attributeList[index].attributeList..removeAt(subIndex),
                  ))
                .asList(),
          ),
        ),
      ),
    );
  }

  /// Method to add DataPoint
  void addDataPoint() {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          dataPointList: KtMutableList<DataPoint>.from((state.diary.dataPointList..add(DataPoint.empty())).asList()),
        ),
      ),
    );
  }

  /// Method to change DataPoint
  void onChangeDataPoint(
    int index, {
    required DateTime point,
  }) {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          dataPointList: state.diary.dataPointList
            ..[index] = state.diary.dataPointList[index].copyWith(point: Point(point)),
        ),
      ),
    );
  }

  /// Method to add Attribute to DataPoint
  void addAttributeToDataPoint(
    int index, {
    required String attributeName,
  }) {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          dataPointList: KtMutableList<DataPoint>.from(
            (state.diary.dataPointList
                  ..[index] = state.diary.dataPointList[index].copyWith(
                    attributeList: KtMutableList<AttributeName>.from(
                      (state.diary.dataPointList[index].attributeList
                            ..add(
                              AttributeName(attributeName),
                            ))
                          .asList(),
                    ),
                  ))
                .asList(),
          ),
        ),
      ),
    );
  }

  /// Method to delete Attribute to DataPoint
  void addDeleteToDataPoint(
    int index,
    int attributeIndex,
  ) {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(
          dataPointList: KtMutableList<DataPoint>.from(
            (state.diary.dataPointList
                  ..[index] = state.diary.dataPointList[index].copyWith(
                    attributeList: KtMutableList<AttributeName>.from(
                      (state.diary.dataPointList[index].attributeList..removeAt(attributeIndex)).asList(),
                    ),
                  ))
                .asList(),
          ),
        ),
      ),
    );
  }

  /// Method to change whether InputData into the diary is strictly DataPoint based
  void onChangeStrict(bool strictDataInput) {
    emit(
      state.copyWith(
        diary: state.diary.copyWith(strictDataInput: strictDataInput),
      ),
    );
  }

  /// Method to create Diary on the server
  Future<void> create() async {
    Either<DiaryFailure, Unit>? failureOrSuccess;

    emit(
      state.copyWith(
        isSaving: true,
        saveFailureOrSuccessOption: none(),
      ),
    );

    if (state.diary.strictDataInput && state.diary.failureOptionWithoutInputList.isNone() ||
        !state.diary.strictDataInput && state.diary.failureOptionWithoutDataPointAndInputList.isNone()) {
      failureOrSuccess = state.isEditing
          ? await _diaryRepository.update(state.diary)
          : await _diaryRepository.create(
              state.diary.copyWith(
                createDate: DateTime.now(),
              ),
            );
    }

    emit(
      state.copyWith(
        isSaving: false,
        showErrorMessages: true,
        saveFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }
}
