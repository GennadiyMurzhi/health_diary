import 'package:flutter/material.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:health_diary/ui/diary/widgets/switch_icon_button.dart';
import 'package:health_diary/ui/diary/widgets/timeline_widget.dart';

class VisualizationDiaryBody extends StatelessWidget {
  final Diary diary;

  const VisualizationDiaryBody({
    Key? key,
    required this.diary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwitchIconButton(
                  direction: SwitchDirection.left,
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Text(
                    'data',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
                SwitchIconButton(
                  direction: SwitchDirection.right,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          TimeLineWidget(),
        ],
      ),
    );
  }
}
