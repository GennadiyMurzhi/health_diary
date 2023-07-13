import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_diary/application/diary_list_cubit/diary_list_cubit.dart';
import 'package:health_diary/ui/core/layout.dart';
import 'package:health_diary/ui/core/widgets/health_diary_app_bar.dart';
import 'package:health_diary/ui/core/widgets/health_diary_icon_button_widget.dart';
import 'package:health_diary/ui/diary_list/pre_diary_info_widget.dart';
import 'package:health_diary/ui/health_diary_icons.dart';

class DiaryListScreen extends StatelessWidget {
  const DiaryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preDiaryInfoList = BlocProvider.of<DiaryListCubit>(context).state.diaryPreInfoList;

    final double screenHeight = MediaQuery.of(context).size.height;

    return HealthDiaryLayout(
      isDiaryList: true,
      appBar: HealthDiaryAppBar(
        needPop: true,
        title: 'List of diaries',
        actions: <Widget>[
          IconButton(
            iconSize: 22,
            onPressed: () {},
            icon: const Icon(HealthDiaryIcons.add),
          ),
        ],
      ),
      needPadding: true,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              right: 24,
              bottom: constraints.minWidth > 600 ? 101 : 20,
              child: SvgPicture.asset(
                'resources/images/bookshelf_image.svg',
                width: screenHeight * 0.2484375 * 0.196226,
                height: screenHeight * 0.2484375,
              ),
            ),
            ListView(
              padding: EdgeInsets.only(top: constraints.minWidth > 600 ? 14.5 : 0),
              children: List.generate(
                preDiaryInfoList.length,
                (index) => Center(
                  child: PreDiaryInfoWidget(
                    diaryName: preDiaryInfoList[index].diaryName,
                    startIt: preDiaryInfoList[index].startIt,
                    earlyEntry: preDiaryInfoList[index].earlyEntry,
                    stopped: preDiaryInfoList[index].stopped,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
