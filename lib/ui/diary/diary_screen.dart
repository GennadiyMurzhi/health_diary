import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_diary/application/diary_cubit/diary_cubit.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:health_diary/ui/core/layout.dart';
import 'package:health_diary/ui/core/widgets/headline_widget.dart';
import 'package:health_diary/ui/core/widgets/health_diary_app_bar.dart';
import 'package:health_diary/ui/core/widgets/health_diary_icon_button.dart';
import 'package:health_diary/ui/diary/preview_diary_body.dart';
import 'package:health_diary/ui/diary/visualization_diary_body.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiaryCubit, DiaryState>(
      builder: (BuildContext context, DiaryState state) {
        final Diary diary = state.diary;

        return HealthDiaryLayout(
          appBar: HealthDiaryAppBar(
            title: 'Diary -',
            needPop: true,
            actions: [
              HealthDiaryIconButton(
                'resources/icons/settings_icon.svg',
                width: 22,
                height: 22,
                onPressed: () {},
              ),
            ],
          ),
          needPadding: !state.isVisualization,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (state.isVisualization)
                    const SizedBox(
                      width: 22,
                    ),
                  const HeadlineWidget('Blood pressure'),
                ],
              ),
              if (BlocProvider.of<DiaryCubit>(context).state.isPreview)
                PreviewDiaryBody(
                  diary: diary,
                )
              else
                BlocProvider.of<DiaryCubit>(context).state.isVisualization
                    ? VisualizationDiaryBody(
                        diary: diary,
                      )
                    : Container(),
            ],
          ),
        );
      },
    );
  }
}
