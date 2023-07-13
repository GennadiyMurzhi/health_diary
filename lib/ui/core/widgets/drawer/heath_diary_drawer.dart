import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_diary/application/auth/auth_cubit/auth_cubit.dart';
import 'package:health_diary/application/user/user_info_cubit/user_info_cubit.dart';
import 'package:health_diary/injection.dart';
import 'package:health_diary/ui/routes/router.dart';

import 'drawer_button.dart';

class HealthDiaryDrawer extends StatelessWidget {
  const HealthDiaryDrawer({
    Key? key,
    required this.isMain,
    required this.isDiaryList,
    required this.isSettings,
  }) : super(key: key);

  final bool isMain;
  final bool isDiaryList;
  final bool isSettings;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(25),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 140,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(
                left: 22,
                bottom: 11,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                ),
              ),
              child: BlocBuilder<UserInfoCubit, UserInfoState>(
                builder: (BuildContext context, UserInfoState state) {
                  return Text(
                    '${state.userInfo.name.getOrCrash()} ${state.userInfo.surname.getOrCrash()}',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                    textAlign: TextAlign.left,
                  );
                },
              ),
            ),
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      DrawerButtonWidget(
                        label: 'Main',
                        onPressed: isMain
                            ? () {
                                getIt<AppRouter>().pop();
                              }
                            : () {
                                getIt<AppRouter>().replaceNamed('/main-screen');
                              },
                      ),
                      DrawerButtonWidget(
                        label: 'List of diaries',
                        onPressed: isDiaryList
                            ? () {
                                getIt<AppRouter>().pop();
                              }
                            : () {
                                getIt<AppRouter>().replaceNamed('/main-screen');
                              },
                      ),
                      DrawerButtonWidget(
                        label: 'Settings',
                        onPressed: isSettings
                            ? () {
                                getIt<AppRouter>().pop();
                              }
                            : () {
                                getIt<AppRouter>().replaceNamed('/main-screen');
                              },
                      ),
                    ],
                  ),
                  DrawerButtonWidget(
                    label: 'logout',
                    onPressed: () async {
                      await BlocProvider.of<AuthCubit>(context).signedOut();
                      getIt<AppRouter>().popUntilRoot();
                      getIt<AppRouter>().replaceNamed('/auth-screen');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 22,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ver 1.0',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'app based on Google Flutter framework',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
