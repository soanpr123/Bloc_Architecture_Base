import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAlert extends StatelessWidget {
  CustomAlert({required this.child, Key? key}) : super(key: key);
  final Widget child;
  double? deviceWidth;
  double? deviceHeight;
  double? dialogHeight;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final viewsSize = MediaQuery.of(context).size;

    deviceWidth = orientation == Orientation.portrait ? viewsSize.width : viewsSize.height;
    deviceHeight = orientation == Orientation.portrait ? viewsSize.height : viewsSize.width;
    dialogHeight = deviceHeight! * (0.50);

    return MediaQuery(
      data: const MediaQueryData(),
      child: GestureDetector(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 0.5,
            sigmaY: 0.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: deviceWidth! * 0.9,
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
