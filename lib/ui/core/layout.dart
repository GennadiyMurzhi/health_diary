import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_diary/application/main_cubit/main_cubit.dart';
import 'package:health_diary/ui/core/widgets/health_diary_app_bar.dart';
import 'package:health_diary/ui/core/widgets/drawer/heath_diary_drawer.dart';

class HealthDiaryLayout extends StatelessWidget {
  final HealthDiaryAppBar appBar;
  final bool needPadding;
  final Widget child;

  const HealthDiaryLayout({
    Key? key,
    required this.appBar,
    required this.needPadding,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: HealthDiaryDrawer(
        userName: BlocProvider.of<MainCubit>(context).state.userName,
      ),
      body: Padding(
        padding: needPadding ? const EdgeInsets.symmetric(horizontal: 22) : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
