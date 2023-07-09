import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_diary/application/user/user_info_form_cubit/user_info_form_cubit.dart';
import 'package:health_diary/injection.dart';
import 'package:health_diary/ui/core/widgets/fill_remaining_scroll_view_widget.dart';
import 'package:health_diary/ui/core/widgets/user_info_fields_widget.dart';
import 'package:health_diary/ui/routes/router.dart';

class UserInfoFormWidget extends StatelessWidget {
  UserInfoFormWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FillRemainingScrollViewWidget(
      padding: EdgeInsets.fromLTRB(15, 11 + MediaQuery.of(context).padding.top, 15, 5.5),
      child: BlocConsumer<UserInfoFormCubit, UserInfoFormState>(
        listener: (BuildContext context, UserInfoFormState state) {
          state.userFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                failure.maybeWhen(
                  serverError: () => FlushbarHelper.createError(message: 'Server error').show(context),
                  orElse: () {},
                );
              },
              (r) => getIt<AppRouter>().replaceNamed('/main-screen'),
            ),
          );
        },
        builder: (BuildContext context, UserInfoFormState state) {
          return Form(
            key: _formKey,
            autovalidateMode: state.showErrorMessage ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Fill in your personal information to complete the registration',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                UserInfoFieldsWidget(
                  nameValidator: () => BlocProvider.of<UserInfoFormCubit>(context).state.userInfo.name.value.fold(
                    (l) => l.maybeWhen(
                      wrongName: (String value) {
                        return 'The surname must start capitalized';
                      },
                      nameContainsOtherThen: (String value) {
                        return 'The surname must can only contain letters';
                      },
                      orElse: () => null,
                    ),
                    (r) {
                      return null;
                    },
                  ),
                  surnameValidator: () => BlocProvider.of<UserInfoFormCubit>(context).state.userInfo.surname.value.fold(
                    (l) => l.maybeWhen(
                      wrongName: (String value) {
                        return 'The surname must start capitalized';
                      },
                      nameContainsOtherThen: (String value) {
                        return 'The surname must can only contain letters';
                      },
                      orElse: () => null,
                    ),
                    (r) {
                      return null;
                    },
                  ),
                  ageValidator: () => BlocProvider.of<UserInfoFormCubit>(context).state.userInfo.age.value.fold(
                    (l) => l.maybeWhen(
                      unacceptableAge: (String value) {
                        return 'The age must be at least eighteen';
                      },
                      orElse: () => null,
                    ),
                    (r) {
                      return null;
                    },
                  ),
                  onChangedName: BlocProvider.of<UserInfoFormCubit>(context).onChangedName,
                  onChangedSurname: BlocProvider.of<UserInfoFormCubit>(context).onChangedSurname,
                  onChangedAge: BlocProvider.of<UserInfoFormCubit>(context).onChangedAge,
                ),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          state.isEqualInitialUserInfo
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                  onPressed: state.isEqualInitialUserInfo
                      ? null
                      : () {
                          BlocProvider.of<UserInfoFormCubit>(context).saveUserInfoOnTheServer();
                        },
                  child: Text(
                    "Save info",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: state.isEqualInitialUserInfo
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
