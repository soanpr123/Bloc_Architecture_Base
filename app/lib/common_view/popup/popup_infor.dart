import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import '../../shared_view/app_netword_image.dart';

class DialogInfo extends StatelessWidget {
  const DialogInfo({
    required this.user,
    required this.onPress,
    Key? key,
  }) : super(key: key);
  final MemberDataEntry user;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user.name ?? '',
                style: typoInterNomal18.copyWith(color: colorGray800, height: 1.5, fontWeight: FontWeight.w700),
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
          Center(
            child: Container(
              width: Dimens.d256.responsive(),
              height: Dimens.d249.responsive(),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: ClipRRect(
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
                style: typoInterNomal14.copyWith(color: colorTextMedium, fontSize: 14, height: 1.5),
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
                style: typoInterNomal14.copyWith(color: colorTextMedium, fontSize: 14, height: 1.5),
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
                style: typoInterNomal14.copyWith(color: colorTextMedium, fontSize: 14, height: 1.5),
              ),
            ],
          ),
          SizedBox(
            height: Dimens.d12.responsive(),
          ),
          Text(
            user.about == '' ? S.current.about_invalid : user.about ?? '',
            style: typoInterNomal14.copyWith(
                color: user.about == '' ? colorTextBland : colorTextMedium, fontSize: 14, height: 1.5),
          ),
        ]),
      ),
    );
  }
}
