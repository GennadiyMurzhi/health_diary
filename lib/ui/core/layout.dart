import 'package:flutter/material.dart';
import 'package:health_diary/ui/core/widgets/health_diary_app_bar.dart';
import 'package:health_diary/ui/core/widgets/drawer/heath_diary_drawer.dart';

class HealthDiaryLayout extends StatelessWidget {
  HealthDiaryLayout({
    Key? key,
    required this.appBar,
    required this.needPadding,
    bool? isMain,
    bool? isDiaryList,
    bool? isSettings,
    required this.child,
  }) : super(key: key) {
    this.isMain = isMain ?? false;
    this.isDiaryList = isDiaryList ?? false;
    this.isSettings = isSettings ?? false;
  }

  final HealthDiaryAppBar appBar;
  final bool needPadding;
  late final bool isMain;
  late final bool isDiaryList;
  late final bool isSettings;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: HealthDiaryDrawer(
        isMain: isMain,
        isDiaryList: isDiaryList,
        isSettings: isSettings,
      ),
      body: Padding(
        padding: needPadding ? const EdgeInsets.symmetric(horizontal: 22) : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
