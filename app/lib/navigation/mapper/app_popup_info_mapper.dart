import 'package:domain/domain.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../common_view/popup/popup_infor.dart';

@LazySingleton(as: BasePopupInfoMapper)
class AppPopupInfoMapper extends BasePopupInfoMapper {
  @override
  Widget map(AppPopupInfo appPopupInfo, AppNavigator navigator) {
    return appPopupInfo.when(
      confirmDialog: (message, onPressed) {
        return CommonDialog(
          actions: [
            PopupButton(
              text: S.current.ok,
              onPressed: onPressed ?? Func0(() => navigator.pop()),
            ),
          ],
          message: message,
        );
      },
      errorWithRetryDialog: (message, onRetryPressed) {
        return CommonDialog(
          actions: [
            PopupButton(
              text: S.current.cancel,
              onPressed: Func0(() => navigator.pop()),
            ),
            PopupButton(
              text: S.current.retry,
              onPressed: onRetryPressed ?? Func0(() => navigator.pop()),
              isDefault: true,
            ),
          ],
          message: message,
        );
      },
      requiredLoginDialog: () => CommonDialog.adaptive(
        title: S.current.login,
        message: S.current.login,
        actions: [
          PopupButton(
            text: S.current.cancel,
            onPressed: Func0(() => navigator.pop()),
          ),
          PopupButton(
            text: S.current.login,
            onPressed: Func0(() async {
              await navigator.pop();
              await navigator.push(const AppRouteInfo.login());
            }),
          ),
        ],
      ),
      confirm: (message, confirm, cancle) => CommonDialog(
        message: message,
        actions: [
          PopupButton(
            text: S.current.confirm,
            onPressed: confirm ?? Func0(() => navigator.pop()),
          ),
          PopupButton(
            text: S.current.cancel,
            onPressed: cancle ?? Func0(() => navigator.pop()),
          ),
        ],
      ),
      pickImageBottomSheet: (message, onTap1, onTap2) => ListView(
        shrinkWrap: true,
        children: ListTile.divideTiles(context: message, tiles: [
          ListTile(
            title: Text(S.current.camera),
            onTap: onTap1,
          ),
          ListTile(
            title: Text(S.current.gallery),
            onTap: onTap2,
          ),
        ]).toList(),
      ),
      dialogConfirm: (message, title, onPress, context) =>
          DialogConfirm(title: title ?? '', message: message ?? Container(), onPressed: onPress),
      dialogConfirmComon: (message, title, titleButton, onPress, context) => DialogConfirmCommon(
        message: message,
        title: title ?? '',
        tileButton: titleButton,
        onPressed: onPress,
      ),
      dialogInfo: (user,onPress) => DialogInfo(user: user ?? const MemberDataEntry(),onPress: onPress!,),
    );
  }
}
