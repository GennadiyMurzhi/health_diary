import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_diary/ui/core/item_container.dart';

class NotificationWidget extends StatelessWidget {
  final String diaryName;
  final DateTime dateInput;

  const NotificationWidget({
    Key? key,
    required this.diaryName,
    required this.dateInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(15));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Stack(
        children: [
          ItemContainer(
            width: 263,
            height: 87,
            color: Theme.of(context).colorScheme.primaryContainer.withAlpha(210),
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
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                    ),
                    SvgPicture.asset(
                      'resources/icons/timer_icon.svg',
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
                Text(
                  'should be entered at ${dateInput.hour}:${dateInput.minute}',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                )
              ],
            ),
          ),
          Material(
            color: const Color(0x00000000),
            child: InkWell(
              borderRadius: borderRadius,
              onTap: () {},
              child: const SizedBox(
                width: 263,
                height: 87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
