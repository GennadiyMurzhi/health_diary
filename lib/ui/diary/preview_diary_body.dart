import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:health_diary/ui/core/widgets/headline_widget.dart';
import 'package:health_diary/ui/core/widgets/info_icon.dart';
import 'package:health_diary/ui/core/widgets/title_medium_widget.dart';
import 'package:health_diary/ui/diary/widgets/data_row_widget.dart';

class PreviewDiaryBody extends StatelessWidget {
  final Diary diary;

  const PreviewDiaryBody({
    Key? key,
    required this.diary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
                  child: SizedBox(
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoIcon(
                          width: 31.57,
                          height: 30,
                          asset: 'resources/icons/attribute_icon.svg',
                          label: 'attribute\n${diary.attributeList.length}',
                        ),
                        InfoIcon(
                          width: 27.3,
                          height: 30,
                          asset: 'resources/icons/entered_data_icon.svg',
                          label: 'entered data\n${diary.enteredData.length}',
                        ),
                        InfoIcon(
                          width: 37,
                          height: 37,
                          asset: 'resources/icons/start_at_icon.svg',
                          label: 'start at\n${diary.startIt.day}.${diary.startIt.month}.${diary.startIt.year}',
                        ),
                        InfoIcon(
                          width: 30,
                          height: 30,
                          asset: diary.stopped ? 'resources/icons/timer_icon.svg' : 'resources/icons/stopped_diary_icon.svg',
                          label: diary.stopped ? 'in progress\n' : 'stopped\n',
                        ),
                      ],
                    ),
                  ),
                ),
                const TitleMediumWidget(title: 'Data'),
                const SizedBox(
                  height: 2.5,
                ),
                ...List.generate(
                  diary.enteredData.length <= 8 ? diary.enteredData.length : 8,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 7.5,
                    ),
                    child: DataRowWidget(
                      enteredDateTime: diary.enteredData[index].enteredDateTime,
                      fraction: diary.enteredData[index].fraction,
                      unit: diary.enteredData[index].unit,
                    ),
                  ),
                ),
                const Center(
                  child: DataRowText(
                    '. . .',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 36,
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 36,
                          ),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'see visualize',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleMediumWidget(title: 'Upcoming data entries'),
                        ...List.generate(
                          diary.enteredData.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7.5,
                            ),
                            child: Text(
                              diary.enteredData[index].enteredDateTime.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SvgPicture.asset(
                        'resources/icons/timer_icon.svg',
                        width: 28.15,
                        height: 27,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
