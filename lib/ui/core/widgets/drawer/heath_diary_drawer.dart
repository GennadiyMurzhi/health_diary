import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_diary/application/auth/auth_cubit/auth_cubit.dart';
import 'package:health_diary/injection.dart';
import 'package:health_diary/ui/routes/router.dart';

import 'drawer_button.dart';

class HealthDiaryDrawer extends StatelessWidget {
  final String userName;

  const HealthDiaryDrawer({
    Key? key,
    required this.userName,
  }) : super(key: key);

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
              child: Text(
                userName,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      DrawerButtonWidget(
                        label: 'Main',
                        onPressed: () {},
                      ),
                      DrawerButtonWidget(
                        label: 'List of diaries',
                        onPressed: () {},
                      ),
                      DrawerButtonWidget(
                        label: 'Settings',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  DrawerButtonWidget(
                    label: 'logout',
                    onPressed: () async {
                      await BlocProvider.of<AuthCubit>(context).signedOut();
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
