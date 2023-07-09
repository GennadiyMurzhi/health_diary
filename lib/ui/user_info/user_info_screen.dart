import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_diary/application/user/user_info_form_cubit/user_info_form_cubit.dart';
import 'package:health_diary/injection.dart';
import 'package:health_diary/ui/core/widgets/request_focus_widget.dart';
import 'package:health_diary/ui/user_info/user_info_form_widget.dart';

@RoutePage()
class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RequestFocusWidget(
      child: BlocProvider<UserInfoFormCubit>(
        create: (BuildContext context) => getIt<UserInfoFormCubit>()..init(),
        child: Scaffold(
          body: UserInfoFormWidget(),
        ),
      ),
    );
  }
}
