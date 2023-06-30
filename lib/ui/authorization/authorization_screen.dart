import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_diary/application/auth/auth_form_cubit/auth_form_cubit.dart';
import 'package:health_diary/injection.dart';
import 'package:health_diary/ui/authorization/widgets/auth_form_widget.dart';

@RoutePage()
class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (BuildContext context) => getIt<AuthFormCubit>(),
          child: AuthFormWidget(),
        ),
      ),
    );
  }
}
