import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_diary/application/auth/auth_form_cubit/auth_form_cubit.dart';
import 'package:health_diary/injection.dart';
import 'package:health_diary/ui/authorization/widgets/authorization_text_field_widget.dart';
import 'package:health_diary/ui/core/no_scroll_behavior.dart';
import 'package:health_diary/ui/core/router.dart';
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
              FlushbarHelper.createError(
                message: failure.map(
                  cancelledByUser: (_) => 'Canceled',
                  serverError: (_) => 'Server error',
                  emailAlreadyInUsed: (_) => 'Email already in use',
                  invalidEmailAndPasswordCombination: (_) => 'Invalid email and password combination',
                ),
              ).show(context);
            },
            (r) => getIt<AppRouter>().replaceNamed('/main-screen'),
          ),
        );
      },
      builder: (BuildContext context, AuthFormState state) {
        final double percentHeight = MediaQuery.of(context).size.height / 100;

        return Form(
          key: _formKey,
          autovalidateMode: state.showErrorMessage ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: ScrollConfiguration(
            behavior: NoScrollBehavior(),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, percentHeight * 11, 0, percentHeight * 5.5),
                    child: Column(
                      children: <Widget>[
                        const LogoWidget(),
                        const LogoCaptionWidget(),
                        const Spacer(),
                        if (state.isSignUp) ...[
                          AuthorizationTextFieldWidget(
                            hintText: 'Name',
                            obscureText: false,
                            onChanged: BlocProvider.of<AuthFormCubit>(context).onChangedName,
                            validator: (String? value) =>
                                BlocProvider.of<AuthFormCubit>(context).state.name!.value.fold(
                              (l) => l.maybeWhen(
                                wrongName: (String value) {
                                  if (!state.errorName!) {
                                    BlocProvider.of<AuthFormCubit>(context).noValidName();
                                  }
                                  return 'The name must start capitalized';
                                },
                                nameContainsOtherThen: (String value) {
                                  if (!state.errorName!) {
                                    BlocProvider.of<AuthFormCubit>(context).noValidName();
                                  }
                                  return 'The name must can only contain letters';
                                },

                                orElse: () => '',
                              ),
                              (r) {
                                if (state.errorName!) {
                                  BlocProvider.of<AuthFormCubit>(context).validName();
                                }
                                return null;
                              },
                            ),
                          ),
                          AuthorizationTextFieldWidget(
                            hintText: 'Surname',
                            obscureText: false,
                            onChanged: BlocProvider.of<AuthFormCubit>(context).onChangedSurname,
                            validator: (String? value) =>
                                BlocProvider.of<AuthFormCubit>(context).state.surname!.value.fold(
                              (l) => l.maybeWhen(
                                wrongName: (String value) {
                                  if (!state.errorSurname!) {
                                    BlocProvider.of<AuthFormCubit>(context).noValidSurname();
                                  }
                                  return 'The surname must start capitalized';
                                },
                                nameContainsOtherThen: (String value) {
                                  if (!state.errorSurname!) {
                                    BlocProvider.of<AuthFormCubit>(context).noValidSurname();
                                  }
                                  return 'The surname must can only contain letters';
                                },
                                orElse: () => '',
                              ),
                              (r) {
                                if (state.errorSurname!) {
                                  BlocProvider.of<AuthFormCubit>(context).validSurname();
                                }
                                return null;
                              },
                            ),
                          ),
                          AuthorizationTextFieldWidget(
                            hintText: 'Age',
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            onChanged: BlocProvider.of<AuthFormCubit>(context).onChangedAge,
                            validator: (String? value) => BlocProvider.of<AuthFormCubit>(context).state.age!.value.fold(
                              (l) => l.maybeWhen(
                                unacceptableAge: (String value) {
                                  if (!state.errorAge!) {
                                    BlocProvider.of<AuthFormCubit>(context).noValidAge();
                                  }
                                  return 'The age must be at least eighteen';
                                },
                                orElse: () => '',
                              ),
                              (r) {
                                if (state.errorAge!) {
                                  BlocProvider.of<AuthFormCubit>(context).validAge();
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                        AuthorizationTextFieldWidget(
                          hintText: 'E-mail',
                          obscureText: false,
                          onChanged: BlocProvider.of<AuthFormCubit>(context).onChangedEmail,
                          validator: (String? value) =>
                              BlocProvider.of<AuthFormCubit>(context).state.emailAddress.value.fold(
                            (l) => l.maybeWhen(
                              invalidEmail: (String value) {
                                if (!state.errorEmailAddress) {
                                  BlocProvider.of<AuthFormCubit>(context).noValidEmail();
                                }
                                return 'Invalid Email';
                              },
                              orElse: () => '',
                            ),
                            (r) {
                              if (state.errorEmailAddress) {
                                BlocProvider.of<AuthFormCubit>(context).validEmail();
                              }
                              return null;
                            },
                          ),
                        ),
                        AuthorizationTextFieldWidget(
                          hintText: 'Password',
                          obscureText: true,
                          onChanged: BlocProvider.of<AuthFormCubit>(context).onChangedPassword,
                          validator: (String? value) =>
                              BlocProvider.of<AuthFormCubit>(context).state.password.value.fold(
                            (l) => l.maybeWhen(
                              shortPassword: (String value) {
                                if (!state.errorPassword) {
                                  BlocProvider.of<AuthFormCubit>(context).noValidPassword();
                                }
                                return 'Short Password';
                              },
                              orElse: () => '',
                            ),
                            (r) {
                              if (state.errorPassword) {
                                BlocProvider.of<AuthFormCubit>(context).validPassword();
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        Center(
                          child: ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
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
                        Center(
                          child: ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                                ),
                            onPressed: () {
                              BlocProvider.of<AuthFormCubit>(context).signInWithGooglePressed();
                            },
                            child: UnconstrainedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
