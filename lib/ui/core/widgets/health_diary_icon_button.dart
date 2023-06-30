import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HealthDiaryIconButton extends StatelessWidget {
  final String assetName;
  final double width;
  final double height;
  final Function onPressed;

  const HealthDiaryIconButton(
    this.assetName, {
    Key? key,
    required this.width,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: () => onPressed(),
      icon: SvgPicture.asset(
        assetName,
        width: width,
        height: height,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
