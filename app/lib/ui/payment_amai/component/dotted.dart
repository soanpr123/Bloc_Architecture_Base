import 'package:flutter/material.dart';

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black}) : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 30.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();

        return Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
              ),
            );
          }),
        );
      },
    );
  }
}
