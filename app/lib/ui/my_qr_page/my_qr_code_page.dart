import 'package:app/shared_view/app_netword_image.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import '../../utils/toast_message.dart';
@RoutePage()
class MyQrCodePage extends StatefulWidget {
  const MyQrCodePage({required this.qrCode, required this.name, Key? key}) : super(key: key);
  final String qrCode;
  final String name;
  @override
  _MyQrCodePageState createState() => _MyQrCodePageState();
}

class _MyQrCodePageState extends BasePageState<MyQrCodePage, MyQrCodeBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        text: 'QR của bạn',
        centerTitle: true,
        corlorText: Colors.white,
        backgroundColor: colorBrandPrimary,
        elevation: 1,
        leadingIcon: const BackButton(color: Colors.white),
        // height: MediaQuery.of(context).padding.top + Dimens.d60.responsive(),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(Dimens.d16.responsive()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Quét mã QR để gửi tặng Amai tới',
                      style: typoInterNomal14.copyWith(height: 1.5),
                    ),
                    SizedBox(
                      height: Dimens.d4.responsive(),
                    ),
                    Text(
                      widget.name,
                      style: typoInterNomal16.copyWith(
                          color: colorTextDark, fontSize: Dimens.d20.responsive(), height: 1.5),
                    ),
                    SizedBox(
                      height: Dimens.d24.responsive(),
                    ),
                    Container(
                      width: Dimens.d222.responsive(),
                      height: Dimens.d222.responsive(),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        boxShadow: boxShadow,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Dimens.d8.responsive(),
                          ),
                          Image.asset(
                            Assets.png.logoSplash.path,
                            fit: BoxFit.contain,
                            height: Dimens.d18.responsive(),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(Dimens.d21.responsive(), Dimens.d4.responsive(),
                                Dimens.d21.responsive(), Dimens.d12.responsive()),
                            child: AppNetworkImage(
                              source: widget.qrCode,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: Dimens.d40.responsive(),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: colorBrandPrimary),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(colorDisabled),
                          ),
                          onPressed: () async {
                            await GallerySaver.saveImage(widget.qrCode).then((bool? success) {
                              if (success == true) {
                                successToast('Lưu thành công');
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.svg.download2Fill.svg(),
                              SizedBox(
                                width: Dimens.d4.responsive(),
                              ),
                              Text(
                                'Lưu mã',
                                style: typoInterNomal14.copyWith(
                                  color: colorBrandPrimary,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimens.d12.responsive(),
                    ),
                    Expanded(
                      child: Container(
                        height: Dimens.d40.responsive(),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: colorBrandPrimary),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(colorDisabled),
                          ),
                          onPressed: () async {
                            await FlutterShare.share(
                              title: 'Chia sẻ mã',
                              linkUrl: widget.qrCode,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.svg.shareBoxFill.svg(),
                              SizedBox(
                                width: Dimens.d4.responsive(),
                              ),
                              Text(
                                'Chia sẻ mã ',
                                style: typoInterNomal14.copyWith(
                                  color: colorBrandPrimary,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.d24.responsive(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
