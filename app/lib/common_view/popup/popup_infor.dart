import 'dart:ui';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import '../../shared_view/app_netword_image.dart';

// ignore: must_be_immutable
class DialogInfo extends StatelessWidget {
  DialogInfo({
    required this.user,
    required this.onPress,
    Key? key,
  }) : super(key: key);
  final MemberDataEntry user;
  final Function onPress;
  double? deviceWidth;
  double? deviceHeight;
  double? dialogHeight;
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final viewsSize = MediaQuery.of(context).size;

    deviceWidth = orientation == Orientation.portrait ? viewsSize.width : viewsSize.height;
    deviceHeight = orientation == Orientation.portrait ? viewsSize.height : viewsSize.width;
    dialogHeight = deviceHeight! * (0.5);

    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: MediaQuery(
        data: const MediaQueryData(),
        child: GestureDetector(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 0.5,
              sigmaY: 0.5,
            ),
            child: Center(
              child: SizedBox(
                width: deviceWidth! * 0.9,
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                user.name ?? '',
                                style: typoInterNomal18.copyWith(
                                    color: colorGray800, height: 1.5, fontWeight: FontWeight.w700,),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: Dimens.d8.responsive()),
                                child: GestureDetector(
                                  onTap: () => onPress(),
                                  child: Icon(
                                    Icons.close,
                                    color: colorGray400,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            user.department ?? '',
                            style: typoInterNomal14.copyWith(color: colorTextMedium, fontSize: 12, height: 1.5),
                          ),
                          SizedBox(
                            height: Dimens.d12.responsive(),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: colorBgAvt,
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      ),
                                      child: user.avatar == null ||
                                              user.avatar!.isEmpty ||
                                              !user.avatar!.startsWith('http')
                                          ? Container(
                                              padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                child: AppNetworkImage(
                                                  isAvt: true,
                                                  gender: user.gender ?? '',
                                                  source: user.avatar,
                                                ),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                              child: AppNetworkImage(
                                                isAvt: true,
                                                gender: user.gender ?? '',
                                                source: user.avatar,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimens.d12.responsive(),
                                  ),
                                  Row(
                                    children: [
                                      Assets.svg.userIf.svg(),
                                      SizedBox(
                                        width: Dimens.d8.responsive(),
                                      ),
                                      Text(
                                        user.position ?? '',
                                        style: typoInterNomal14.copyWith(
                                            color: colorTextMedium, fontSize: 14, height: 1.5,),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimens.d4.responsive(),
                                  ),
                                  Row(
                                    children: [
                                      Assets.svg.dobIf.svg(),
                                      SizedBox(
                                        width: Dimens.d8.responsive(),
                                      ),
                                      Text(
                                        user.dob ?? '',
                                        style: typoInterNomal14.copyWith(
                                            color: colorTextMedium, fontSize: 14, height: 1.5,),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimens.d4.responsive(),
                                  ),
                                  Row(
                                    children: [
                                      Assets.svg.mailIf.svg(),
                                      SizedBox(
                                        width: Dimens.d8.responsive(),
                                      ),
                                      Text(
                                        user.email ?? '',
                                        style: typoInterNomal14.copyWith(
                                            color: colorTextMedium, fontSize: 14, height: 1.5,),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimens.d12.responsive(),
                                  ),
                                  Text(
                                    user.about == '' ? S.current.about_invalid : user.about ?? '',
                                    style: typoInterNomal14.copyWith(
                                        color: user.about == '' ? colorTextBland : colorTextMedium,
                                        fontSize: 14,
                                        height: 1.5,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      // child: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisSize: MainAxisSize.min,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             user.name ?? '',
      //             style: typoInterNomal18.copyWith(color: colorGray800, height: 1.5, fontWeight: FontWeight.w700),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(top: Dimens.d8.responsive()),
      //             child: GestureDetector(
      //               onTap: () => onPress(),
      //               child: Icon(
      //                 Icons.close,
      //                 color: colorGray400,
      //                 size: 20,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Text(
      //         user.department ?? '',
      //         style: typoInterNomal14.copyWith(color: colorTextMedium, fontSize: 12, height: 1.5),
      //       ),
      //       SizedBox(
      //         height: Dimens.d12.responsive(),
      //       ),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisSize: MainAxisSize.min,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Center(
      //             child: Container(
      //               width: double.infinity,
      //               decoration: BoxDecoration(
      //                 color: colorBgAvt,
      //                 borderRadius: const BorderRadius.all(Radius.circular(5)),
      //               ),
      //               child: user.avatar == null || user.avatar!.isEmpty || !user.avatar!.startsWith('http')
      //                   ? Container(
      //                       padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      //                       child: ClipRRect(
      //                         borderRadius: const BorderRadius.all(Radius.circular(5)),
      //                         child: AppNetworkImage(
      //                           isAvt: true,
      //                           gender: user.gender ?? '',
      //                           source: user.avatar,
      //                         ),
      //                       ),
      //                     )
      //                   : ClipRRect(
      //                       borderRadius: const BorderRadius.all(Radius.circular(5)),
      //                       child: AppNetworkImage(
      //                         isAvt: true,
      //                         gender: user.gender ?? '',
      //                         source: user.avatar,
      //                       ),
      //                     ),
      //             ),
      //           ),
      //           SizedBox(
      //             height: Dimens.d12.responsive(),
      //           ),
      //           Row(
      //             children: [
      //               Assets.svg.userIf.svg(),
      //               SizedBox(
      //                 width: Dimens.d8.responsive(),
      //               ),
      //               Text(
      //                 user.position ?? '',
      //                 style: typoInterNomal14.copyWith(color: colorTextMedium, fontSize: 14, height: 1.5),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: Dimens.d4.responsive(),
      //           ),
      //           Row(
      //             children: [
      //               Assets.svg.dobIf.svg(),
      //               SizedBox(
      //                 width: Dimens.d8.responsive(),
      //               ),
      //               Text(
      //                 user.dob ?? '',
      //                 style: typoInterNomal14.copyWith(color: colorTextMedium, fontSize: 14, height: 1.5),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: Dimens.d4.responsive(),
      //           ),
      //           Row(
      //             children: [
      //               Assets.svg.mailIf.svg(),
      //               SizedBox(
      //                 width: Dimens.d8.responsive(),
      //               ),
      //               Text(
      //                 user.email ?? '',
      //                 style: typoInterNomal14.copyWith(color: colorTextMedium, fontSize: 14, height: 1.5),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: Dimens.d12.responsive(),
      //           ),
      //           Text(
      //             user.about == '' ? S.current.about_invalid : user.about ?? '',
      //             style: typoInterNomal14.copyWith(
      //                 color: user.about == '' ? colorTextBland : colorTextMedium, fontSize: 14, height: 1.5),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
