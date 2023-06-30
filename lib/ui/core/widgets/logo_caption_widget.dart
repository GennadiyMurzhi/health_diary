import 'package:flutter/material.dart';

class LogoCaptionWidget extends StatelessWidget {
  const LogoCaptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      child: Text(
        'Health diary',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
          shadows: <Shadow>[
            const Shadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
