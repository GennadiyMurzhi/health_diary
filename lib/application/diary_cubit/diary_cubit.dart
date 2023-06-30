import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:injectable/injectable.dart';

part 'diary_cubit.freezed.dart';

part 'diary_state.dart';

@injectable
class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit()
      : super(
          DiaryState(
            diary: Diary(
              diaryName: 'Diary Name',
              startIt: DateTime.utc(2022, 7, 22),
              stopped: false,
              attributeList: [],
              enteredData: List.generate(
                20,
                (index) => EnteredData(
                  enteredDateTime: DateTime(2022, 7, 22, 15, 30),
                  unit: 'unit',
                  fraction: Fraction(
                      isFraction: index % 2 == 0 ? true : false,
                      numerator: (index * Random(10).nextInt(10)).toDouble(),
                      denominator: index % 2 == 0 ? (index * Random(10).nextInt(10)).toDouble() : null),
                ),
              ),
              upcomingDataEntries: List.generate(
                3,
                (index) => DateTime(2022, 7, 22, 15, 30),
              ),
            ),
            isPreview: false,
            isVisualization: true,
          ),
        );
}
