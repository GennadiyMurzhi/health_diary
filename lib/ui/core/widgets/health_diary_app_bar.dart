import 'package:flutter/material.dart';
import 'package:health_diary/ui/core/widgets/health_diary_icon_button.dart';
import 'package:health_diary/ui/core/widgets/headline_widget.dart';
import 'package:health_diary/ui/core/widgets/title_medium_widget.dart';

class HealthDiaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<HealthDiaryIconButton>? actions;
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
    final paddingTop = MediaQuery.of(context).padding.top;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          SizedBox(
            height: paddingTop,
          ),
          Row(
            children: [
              needPop
                  ? HealthDiaryIconButton(
                      'resources/icons/arrow_back_icon.svg',
                      width: 30,
                      height: 30,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : HealthDiaryIconButton(
                      'resources/icons/drawer_icon.svg',
                      width: 25,
                      height: 25,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
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
                  children: [
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
      ),
    );
  }

  @override
  Size get preferredSize => title == null ? const Size.fromHeight(53) : const Size.fromHeight(75);
}
