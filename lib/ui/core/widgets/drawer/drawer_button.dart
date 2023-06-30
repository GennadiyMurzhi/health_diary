import 'package:flutter/material.dart';

class DrawerButtonWidget extends StatelessWidget {
  final String label;
  final Function onPressed;

  const DrawerButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Row(
        children: [
          const SizedBox(
            width: 22,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
