import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/core/style/text_style.dart';

class IconText extends StatelessWidget {
  final String icon;
  final String text;
  const IconText({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: typoInterNomal14,
        )
      ],
    );
  }
}
