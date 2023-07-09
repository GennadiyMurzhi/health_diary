import 'package:flutter/cupertino.dart';
import 'package:health_diary/ui/core/widgets/no_over_scroll_widget.dart';

class FillRemainingScrollViewWidget extends StatelessWidget {
  const FillRemainingScrollViewWidget({
    super.key,
    this.padding,
    required this.child,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (padding != null) {
      child = Padding(
        padding: padding!,
        child: this.child,
      );
    } else {
      child = this.child;
    }

    return NoOverScrollWidget(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: child,
          ),
        ],
      ),
    );
  }
}
