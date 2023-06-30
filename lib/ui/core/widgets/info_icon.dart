import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoIcon extends StatelessWidget {
  final double width;
  final double height;
  final String asset;
  final String label;

  const InfoIcon({
    Key? key,
    required this.width,
    required this.height,
    required this.asset,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          asset,
          width: width,
          height: height,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
