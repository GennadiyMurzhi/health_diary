import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_diary/application/auth/auth_cubit/auth_cubit.dart';
import 'package:health_diary/ui/core/widgets/logo_caption_widget.dart';
import 'package:health_diary/ui/core/widgets/logo_widget.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        state.when(
          initial: () {},
          authenticated: () {
            AutoRouter.of(context).replaceNamed('/main-screen');
          },
          unauthenticated: () {
            AutoRouter.of(context).replaceNamed('/auth-screen');
          },
        );
      },
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
