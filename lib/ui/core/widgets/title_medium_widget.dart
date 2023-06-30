import 'package:flutter/material.dart';

class TitleMediumWidget extends StatelessWidget {
  final String title;

  const TitleMediumWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
