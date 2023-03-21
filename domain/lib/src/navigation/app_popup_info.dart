import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../domain.dart';

part 'app_popup_info.freezed.dart';

/// dialog, bottomsheet
@freezed
class AppPopupInfo with _$AppPopupInfo {
  const factory AppPopupInfo.confirmDialog({
    @Default('') String message,
    Func0<void>? onPressed,
  }) = _ConfirmDialog;

  const factory AppPopupInfo.errorWithRetryDialog({
    @Default('') String message,
    Func0<void>? onRetryPressed,
  }) = _ErrorWithRetryDialog;
  const factory AppPopupInfo.confirm({
    @Default('') String message,
    Func0<void>? confirm,
    Func0<void>? cancle,
  }) = _ConfirmyDialog;
  const factory AppPopupInfo.pickImageBottomSheet({
    BuildContext? message,
    GestureTapCallback? onTap1,
    GestureTapCallback? onTap2,
  }) = _PickImageBottomSheet;
  const factory AppPopupInfo.dialogConfirm({
    Widget? message,
    String? title,
    Function? onPress,
    BuildContext? context,
  }) = _DialogConfirm;
  const factory AppPopupInfo.dialogConfirmComon({
    String? message,
    String? title,
    String? titleButton,
    Function? onPress,
    BuildContext? context,
  }) = _DialogConfirmComon;
  const factory AppPopupInfo.requiredLoginDialog() = _RequiredLoginDialog;
  const factory AppPopupInfo.dialogInfo({
    MemberDataEntry? user,
    Function? onPress,
  }) = _DialogInfo;
  const factory AppPopupInfo.bottomSheet({
    Widget? child,
  }) = _BottomSheet;
}
