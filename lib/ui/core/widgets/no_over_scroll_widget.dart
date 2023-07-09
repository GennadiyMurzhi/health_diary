import 'package:flutter/cupertino.dart';

class NoOverScrollWidget extends StatelessWidget {
  const NoOverScrollWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: _NoOverScrollBehavior(),
      child: child,
    );
  }
}

class _NoOverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
