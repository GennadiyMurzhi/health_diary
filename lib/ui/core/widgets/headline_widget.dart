import 'package:flutter/material.dart';

class HeadlineWidget extends StatelessWidget {
  final String headline;

  const HeadlineWidget(
    this.headline, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      headline,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
