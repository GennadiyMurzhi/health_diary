import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_diary/application/auth/auth_form_cubit/auth_form_cubit.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/ui/authorization/widgets/authorization_text_field_widget.dart';

class UserInfoFieldsWidget extends StatelessWidget {
  const UserInfoFieldsWidget({
    super.key,
    required this.nameValidator,
    required this.surnameValidator,
    required this.ageValidator,
    required this.onChangedName,
    required this.onChangedSurname,
    required this.onChangedAge,
  });

  final String? Function() nameValidator;
  final String? Function() surnameValidator;
  final String? Function() ageValidator;
  final void Function(String) onChangedName;
  final void Function(String) onChangedSurname;
  final void Function(String) onChangedAge;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AuthorizationTextFieldWidget(
          hintText: 'Name',
          obscureText: false,
          onChanged: onChangedName,
          validator: nameValidator,
        ),
        AuthorizationTextFieldWidget(
          hintText: 'Surname',
          obscureText: false,
          onChanged: onChangedSurname,
          validator: surnameValidator,
        ),
        AuthorizationTextFieldWidget(
          hintText: 'Age',
          obscureText: false,
          keyboardType: TextInputType.number,
          onChanged: onChangedAge,
          validator: ageValidator,
        ),
      ],
    );
  }
}
