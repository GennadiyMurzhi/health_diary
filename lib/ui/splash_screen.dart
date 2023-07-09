import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_diary/application/auth/auth_cubit/auth_cubit.dart';
import 'package:health_diary/application/user/user_cubit/user_cubit.dart';
import 'package:health_diary/domain/user/user_failure.dart';
import 'package:health_diary/injection.dart';
import 'package:health_diary/ui/core/widgets/logo_caption_widget.dart';
import 'package:health_diary/ui/core/widgets/logo_widget.dart';
import 'package:health_diary/ui/routes/router.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener>[
        BlocListener<AuthCubit, AuthState>(
          listener: (BuildContext context, AuthState state) {
            state.when(
              initial: () {},
              authenticated: () {
                BlocProvider.of<UserCubit>(context).checkUserInfo();
              },
              unauthenticated: () {
                getIt<AppRouter>().replaceNamed('/auth-screen');
              },
            );
          },
        ),
        BlocListener<UserCubit, UserState>(
          listener: (BuildContext context, UserState state) {
            state.when(
              initial: () {},
              notUserInfo: () {
                getIt<AppRouter>().replaceNamed('/user-info-screen');
              },
              userInfoExists: () {
                getIt<AppRouter>().replaceNamed('/main-screen');
              },
              loadFailure: (UserFailure failure) {
                FlushbarHelper.createError(
                    message: failure.maybeWhen(
                  serverError: () => 'Server error',
                  orElse: () => ' ',
                )).show(context);
              },
            );
          },
        ),
      ],
      child: const Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Spacer(),
              LogoWidget(),
              LogoCaptionWidget(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
