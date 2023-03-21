import 'package:flutter/material.dart';

import '../app.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox(
      {required this.value, required this.onChanged, this.avatar = "", this.label, this.isOnLeft = true, Key? key})
      : super(key: key);
  final bool value;
  final String? avatar;
  final String? label;
  final bool isOnLeft;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          if (isOnLeft) ...[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: value ? colorBrandPrimary : colorUiBg02, width: 1),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? colorBrandPrimary : Colors.white,
                ),
                width: 12,
                height: 12,
                margin: const EdgeInsets.all(4),
              ),
            ),
          ],
          Visibility(visible: avatar!.isNotEmpty, child: Image.asset(avatar ?? '')),
          const SizedBox(
            width: 8,
          ),
          Text(
            label ?? '',
            style: typoInterNomal14.copyWith(color: colorTextDark, height: 1.5),
          ),
          if (!isOnLeft) ...[
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: value ? colorBrandPrimary : colorUiBg02, width: 1),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? colorBrandPrimary : Colors.white,
                ),
                width: 16,
                height: 16,
                margin: const EdgeInsets.all(2),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
