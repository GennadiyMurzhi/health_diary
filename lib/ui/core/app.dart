import 'package:flutter/material.dart';
import 'package:health_diary/application/auth/auth_cubit/auth_cubit.dart';
import 'package:health_diary/application/diary_cubit/diary_cubit.dart';
import 'package:health_diary/application/diary_list_cubit/diary_list_cubit.dart';
import 'package:health_diary/application/main_cubit/main_cubit.dart';
import 'package:health_diary/injection.dart';
import 'package:health_diary/ui/routes/router.dart';
import 'package:health_diary/ui/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HealthDiaryApp extends StatelessWidget {
  const HealthDiaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => getIt<AuthCubit>()..authCheckRequested(),
        ),
        BlocProvider<MainCubit>(
          create: (BuildContext context) => getIt<MainCubit>(),
        ),
        BlocProvider<DiaryListCubit>(
          create: (BuildContext context) => getIt<DiaryListCubit>(),
        ),
        BlocProvider<DiaryCubit>(
          create: (BuildContext context) => getIt<DiaryCubit>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: getIt<AppRouter>().config(),
        title: 'Health Diary',
        theme: lightTheme,
      ),
    );
  }
}
