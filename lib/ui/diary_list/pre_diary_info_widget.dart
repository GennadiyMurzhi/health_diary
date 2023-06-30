import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_diary/ui/core/item_container.dart';

class PreDiaryInfoWidget extends StatelessWidget {
  final String diaryName;
  final DateTime startIt;
  final DateTime earlyEntry;
  final bool stopped;

  const PreDiaryInfoWidget({
    Key? key,
    required this.diaryName,
    required this.startIt,
    required this.earlyEntry,
    required this.stopped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: ItemContainer(
        width: 263,
        height: 100,
        color: !stopped
            ? Theme.of(context).colorScheme.primaryContainer.withAlpha(210)
            : Theme.of(context).colorScheme.tertiaryContainer.withAlpha(210),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  diaryName,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: _primaryOrTertiary(context, stopped),
                      ),
                ),
                SvgPicture.asset(
                  !stopped ? 'resources/icons/clock_icon.svg' : 'resources/icons/stopped_diary_icon.svg',
                  color: _primaryOrTertiary(context, stopped),
                  width: 20,
                  height: 20,
                ),
              ],
            ),
            Text(
              'start at ${startIt.day}.${startIt.month}.${startIt.year}',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: _primaryOrTertiary(context, stopped),
                  ),
            ),
            Text(
              'early entry ${earlyEntry.day}.${earlyEntry.month}.${earlyEntry.year} ${earlyEntry.hour}:${earlyEntry.minute}',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: _primaryOrTertiary(context, stopped),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _primaryOrTertiary(BuildContext context, bool stopped) =>
    !stopped ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onTertiaryContainer;
