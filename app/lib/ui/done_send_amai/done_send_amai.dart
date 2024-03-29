import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
@RoutePage()
class DoneSendAmaiPage extends StatefulWidget {
  const DoneSendAmaiPage({required this.userId, Key? key}) : super(key: key);
  final int userId;
  @override
  _DoneSendAmaiState createState() => _DoneSendAmaiState();
}

class _DoneSendAmaiState extends BasePageState<DoneSendAmaiPage, DoneSendAmaiBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(Dimens.d16.responsive()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dimens.d24.responsive(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.send_amai,
                      style: typoInterNomal16.copyWith(
                        fontSize: Dimens.d24.responsive(),
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        color: colorTextDark,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.d80.responsive(),
                ),
                Assets.png.icNotifiSend.image(width: 342, height: 200, fit: BoxFit.contain),
                SizedBox(
                  height: Dimens.d24.responsive(),
                ),
                // Text(
                //   S.current.send_amai_noti,
                //   textAlign: TextAlign.center,
                //   softWrap: true,
                //   // softWrap: true,
                //   style: typoInterNomal14.copyWith(
                //     fontSize: Dimens.d14.responsive(),
                //     fontWeight: FontWeight.w400,
                //     height: 1.5,
                //     color: colorTextDark,
                //   ),
                //   strutStyle: const StrutStyle(
                //     forceStrutHeight: true, // Đảm bảo tất cả các dòng có chiều cao giống nhau
                //     height: 1.5, // Khoảng cách giữa các dòng
                //   ),

                //   textDirection: TextDirection.ltr, // Hướng văn bản từ trái sang phải
                //   overflow: TextOverflow.visible, // Hiển thị văn bản đầy đủ, không bị cắt
                // ),
                RichText(
                  text: TextSpan(
                    style: typoInterNomal14.copyWith(
                      fontSize: Dimens.d14.responsive(),
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: colorTextDark,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: 'Bạn đã tặng Amai thành công, đối phương chắc\n'),
                      const TextSpan(text: '  đang rất bất ngờ vì được bạn tặng Amai rồi.\n'),
                      const TextSpan(text: 'Bạn có thể tiếp tục tặng hoặc quay về trang chủ.\n'),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppElevatedButton(
                        buttonTitle: 'Tiếp tục tặng',
                        onPressed: () {
                          navigator.popUntilRoot(useRootNavigator: true);
                          navigator.push(AppRouteInfo.sendAmai(widget.userId));
                        },
                        mainColor: colorBrandSecondary,
                      ),
                    ),
                    SizedBox(
                      width: Dimens.d8.responsive(),
                    ),
                    Expanded(
                      child: AppElevatedButton(
                        buttonTitle: 'Về trang chủ',
                        onPressed: () {
                          navigator.popUntilRoot(useRootNavigator: true);
                        },
                        mainColor: colorBrandPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.d16.responsive(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
