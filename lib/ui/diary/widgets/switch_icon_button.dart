import 'package:flutter/material.dart';

enum SwitchDirection {left, right}

class SwitchIconButton extends StatelessWidget {
  final SwitchDirection direction;
  final Function onPressed;

  const SwitchIconButton({
    Key? key,
    required this.direction,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: direction == SwitchDirection.left ? const Icon(Icons.arrow_left) : const Icon(Icons.arrow_right),
      color: Theme.of(context).colorScheme.onBackground,
      constraints: const BoxConstraints(
        minWidth: 46,
        minHeight: 46,
      ),
      onPressed: () => onPressed(),
    );
  }
}
