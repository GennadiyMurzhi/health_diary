import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_diary/application/auth/auth_form_cubit/auth_form_cubit.dart';
import 'package:health_diary/injection.dart';
import 'package:health_diary/ui/authorization/widgets/authorization_text_field_widget.dart';
import 'package:health_diary/ui/core/widgets/fill_remaining_scroll_view_widget.dart';
import 'package:health_diary/ui/core/widgets/user_info_fields_widget.dart';
import 'package:health_diary/ui/routes/router.dart';
import 'package:health_diary/ui/core/widgets/logo_caption_widget.dart';
import 'package:health_diary/ui/core/widgets/logo_widget.dart';

class AuthFormWidget extends StatelessWidget {
  AuthFormWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthFormCubit, AuthFormState>(
      listener: (BuildContext context, AuthFormState state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              failure.maybeMap(
                cancelledByUser: (_) => FlushbarHelper.createError(message: 'Canceled').show(context),
                serverError: (_) => FlushbarHelper.createError(message: 'Server error').show(context),
                auth: (_) => _.failure.map(
                  emailAlreadyInUsed: (_) => FlushbarHelper.createError(message: 'Email already in use').show(context),
                  invalidEmailAndPasswordCombination: (_) =>
                      FlushbarHelper.createError(message: 'Invalid email and password combination').show(context),
                ),
                user: (_) {
                  _.failure.when(
                    userHasNotData: () => getIt<AppRouter>().replaceNamed('/user-info-screen'),
                    serverError: () => FlushbarHelper.createError(message: 'Server error').show(context),
                  );
                },
                orElse: () {},
              );
            },
            (r) => getIt<AppRouter>().replaceNamed('/main-screen'),
          ),
        );
      },
      builder: (BuildContext context, AuthFormState state) {
        final double percentHeight = MediaQuery.of(context).size.height / 100;

        print(state.toString());

        return Form(
          key: _formKey,
          autovalidateMode: state.showErrorMessage ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: FillRemainingScrollViewWidget(
            padding: EdgeInsets.fromLTRB(0, percentHeight * 11, 0, percentHeight * 5.5),
            child: Column(
              children: <Widget>[
                const LogoWidget(),
                const LogoCaptionWidget(),
                const Spacer(),
                if (state.isSignUp)
                  UserInfoFieldsWidget(
                    nameValidator: () => BlocProvider.of<AuthFormCubit>(context).state.name!.value.fold(
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
                    surnameValidator: () => BlocProvider.of<AuthFormCubit>(context).state.surname!.value.fold(
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
                    ageValidator: () => BlocProvider.of<AuthFormCubit>(context).state.age!.value.fold(
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
                    onChangedName: BlocProvider.of<AuthFormCubit>(context).onChangedName,
                    onChangedSurname: BlocProvider.of<AuthFormCubit>(context).onChangedSurname,
                    onChangedAge: BlocProvider.of<AuthFormCubit>(context).onChangedAge,
                  ),
                AuthorizationTextFieldWidget(
                  hintText: 'E-mail',
                  obscureText: false,
                  onChanged: BlocProvider.of<AuthFormCubit>(context).onChangedEmail,
                  validator: () => BlocProvider.of<AuthFormCubit>(context).state.emailAddress.value.fold(
                    (l) => l.maybeWhen(
                      invalidEmail: (String value) {
                        return 'Invalid Email';
                      },
                      orElse: () => null,
                    ),
                    (r) {
                      return null;
                    },
                  ),
                ),
                AuthorizationTextFieldWidget(
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: BlocProvider.of<AuthFormCubit>(context).onChangedPassword,
                  validator: () => BlocProvider.of<AuthFormCubit>(context).state.password.value.fold(
                    (l) => l.maybeWhen(
                      shortPassword: (String value) {
                        return 'Short Password';
                      },
                      orElse: () => null,
                    ),
                    (r) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                      ),
                  onPressed: () {
                    state.isSignUp
                        ? BlocProvider.of<AuthFormCubit>(context).signUpPressed()
                        : BlocProvider.of<AuthFormCubit>(context).signInPressed();
                  },
                  child: Text(
                    state.isSignUp ? 'Sign Up' : "Sign In",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Text(
                    'or',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                      ),
                  onPressed: () {
                    BlocProvider.of<AuthFormCubit>(context).signInWithGooglePressed();
                  },
                  child: UnconstrainedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'resources/icons/google_icon.svg',
                          width: 17,
                          height: 17,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(width: 13),
                        Text(
                          'Sign In with Google',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    state.isSignUp
                        ? BlocProvider.of<AuthFormCubit>(context).alreadyHaveAnAccountPressed()
                        : BlocProvider.of<AuthFormCubit>(context).doNotHaveAnAccountYetPressed();
                  },
                  child: Text(
                    state.isSignUp ? 'already have an account ?' : "don't have an account yet?",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
