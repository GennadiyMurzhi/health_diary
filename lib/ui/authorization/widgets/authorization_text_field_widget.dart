import 'package:flutter/material.dart';

class AuthorizationTextFieldWidget extends StatelessWidget {
  const AuthorizationTextFieldWidget({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.onChanged,
    required this.validator,
    this.keyboardType,
  });

  final String hintText;
  final bool obscureText;
  final void Function(String value) onChanged;
  final String? Function() validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: SizedBox(
        width: 260,
        child: TextFormField(
          key: key,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
          autocorrect: false,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: (String? value) => validator(),
          keyboardType: keyboardType,
          maxLines: 1,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 15,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.primaryContainer,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
