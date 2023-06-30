import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_diary/application/main_cubit/main_cubit.dart';
import 'package:health_diary/ui/core/layout.dart';
import 'package:health_diary/ui/core/widgets/health_diary_app_bar.dart';
import 'package:health_diary/ui/main/notification_widget.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HealthDiaryLayout(
      appBar: const HealthDiaryAppBar(
        needPop: false,
      ),
      needPadding: true,
      child: BlocProvider.of<MainCubit>(context).state.countDiaries == 0
          ? const BodyIfThereAreDiaries()
          : const BodyIfThereAreNoDiaries(),
    );
  }
}

class BodyIfThereAreDiaries extends StatelessWidget {
  const BodyIfThereAreDiaries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications = BlocProvider.of<MainCubit>(context).state.notificationList;

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned(
            right: 10,
            bottom: 20,
            child: SvgPicture.asset(
              'resources/images/clock_and_diaries_image.svg',
              width: MediaQuery.of(context).size.height * 0.51093 * 0.75840,
              height: MediaQuery.of(context).size.height * 0.51093,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: constraints.maxWidth < 600 ? 12 : 3,
                  bottom: constraints.maxWidth < 600 ? 9 : 5,
                ),
                child: const NameHeadline(),
              ),
              Text(
                '${BlocProvider.of<MainCubit>(context).state.countDiaries} diaries were created',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: constraints.maxWidth < 600 ? 15 : 5),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'get to all',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              Text(
                'Planned data inputs for today',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                child: ListView(
                  children: List.generate(
                    notifications.length,
                    (index) => Center(
                      child: NotificationWidget(
                        diaryName: notifications[index].diaryName,
                        dateInput: notifications[index].dateInput,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class BodyIfThereAreNoDiaries extends StatelessWidget {
  const BodyIfThereAreNoDiaries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children:  [
              const NameHeadline(),
              const SizedBox(
                height: 8,
              ),
              Text(
                '0 diaries were created',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          SvgPicture.asset(
            'resources/images/empty_cabinet_image.svg',
            width: MediaQuery.of(context).size.height * 0.3125 * 0.80665,
            height: MediaQuery.of(context).size.height * 0.3125,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Create your first diary',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class NameHeadline extends StatelessWidget {
  const NameHeadline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      BlocProvider.of<MainCubit>(context).state.userName,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
