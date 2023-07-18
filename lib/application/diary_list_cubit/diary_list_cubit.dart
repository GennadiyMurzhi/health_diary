// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:health_diary/domain/diary_list/diary_pre_info.dart';
// import 'package:injectable/injectable.dart';
// import 'package:meta/meta.dart';
//
// part 'diary_list_cubit.freezed.dart';
//
// part 'diary_list_state.dart';
//
// @injectable
// class DiaryListCubit extends Cubit<DiaryListState> {
//   DiaryListCubit()
//       : super(
//           DiaryListState(
//             diaryPreInfoList: List.generate(
//               10,
//               (index) => DiaryPreInfo(
//                 diaryName: 'Name Diary $index',
//                 startIt: DateTime.utc(2022, 6, 22),
//                 earlyEntry: DateTime.utc(2022, 7, 21, 12, 30),
//                 stopped: index%3 == 0 ? true : false,
//               ),
//             ),
//           ),
//         );
// }
