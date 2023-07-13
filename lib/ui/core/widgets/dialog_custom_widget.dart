import 'package:flutter/material.dart';

class DialogCustomWidget extends StatelessWidget {
  const DialogCustomWidget({
    super.key,
    this.title,
    required this.text,
    required this.actions,
  });

  final String? title;
  final String text;
  final List<Widget> actions;

  @override
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      insetPadding: const EdgeInsets.symmetric(horizontal: 27),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (title != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
              ),
            const SizedBox(height: 11),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 30),
            for (Widget action in actions) action,
          ],
        ),
      ),
    );
  }
}
