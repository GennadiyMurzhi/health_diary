import 'package:flutter/material.dart';
import 'package:health_diary/ui/core/widgets/health_diary_icon_button_widget.dart';
import 'package:health_diary/ui/core/widgets/headline_widget.dart';
import 'package:health_diary/ui/core/widgets/title_medium_widget.dart';
import 'package:health_diary/ui/health_diary_icons.dart';

class HealthDiaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool needPop;

  const HealthDiaryAppBar({
    Key? key,
    this.title,
    this.actions,
    required this.needPop,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        Row(
          children: [
            needPop
                ? IconButton(
                    iconSize: 30,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(HealthDiaryIcons.arrow_back),
                  )
                : IconButton(
                    iconSize: 25,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(HealthDiaryIcons.drawer),
                  ),
            const SizedBox(
              width: 14,
            ),
            const TitleMediumWidget(
              title: 'Health diary',
            ),
          ],
        ),
        title != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  HeadlineWidget(title!),
                  title != null
                      ? Row(
                          children: List.generate(
                            actions!.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(
                                left: 14,
                              ),
                              child: actions![index],
                            ),
                          ),
                        )
                      : Container(),
                ],
              )
            : Container(),
      ],
    );
  }

  @override
  Size get preferredSize => title == null ? const Size.fromHeight(53) : const Size.fromHeight(75);
}
