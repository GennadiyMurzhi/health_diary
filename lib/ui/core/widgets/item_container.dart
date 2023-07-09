import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Function onTap;
  final Widget child;

  const ItemContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(15));

    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.fromLTRB(17, 15, 17, 15),
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            boxShadow: const [
              BoxShadow(
                offset: Offset(3, 3),
                blurRadius: 3,
                color: Color(0x3F000000),
              ),
            ],
          ),
          child: child,
        ),
        Material(
          color: const Color(0x00000000),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () => onTap(),
            child: SizedBox(
              width: width,
              height: height,
            ),
          ),
        ),
      ],
    );
  }
}
