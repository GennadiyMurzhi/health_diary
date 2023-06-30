import 'package:flutter/material.dart';

class TimeLineWidget extends StatelessWidget {

  const TimeLineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const widgetHeight = 200.0;

    return Container(
      height: widgetHeight,
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Stack(
        children: [
          Positioned(
            top: 22,
            left: 22,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          CustomPaint(
            size: const Size.fromHeight(widgetHeight),
            painter: TimeLinePainter(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class TimeLinePainter extends CustomPainter {
  final Color color;

  const TimeLinePainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path startEndPath = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(10, size.height / 2)
      ..moveTo(size.width - 10, size.height / 2)
      ..lineTo(size.width, size.height / 2);

    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;

    canvas.drawPath(startEndPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
