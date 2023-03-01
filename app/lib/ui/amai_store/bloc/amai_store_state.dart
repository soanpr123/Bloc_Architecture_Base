import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/app_elevated_button.dart';
import '../../../shared_view/body_builder.dart';
part 'amai_store_state.freezed.dart';

@freezed
class AmaiStoreState extends BaseBlocState with _$AmaiStoreState {
  const factory AmaiStoreState({
    @Default(<CanteenEntry>[]) List<CanteenEntry> canteen,
    @Default(<OtherStoreEntry>[]) List<OtherStoreEntry> other,
    @Default(false) bool isShimmerLoading,
     @Default(APIRequestStatus.loading) APIRequestStatus apirequestNoti,
    @Default(AppElevatedButtonState.active) AppElevatedButtonState buttonStateOrder,
    @Default(AppElevatedButtonState.active) AppElevatedButtonState buttonStateDelete,
    @Default(AmaiOrder()) AmaiOrder amaiOrder,
  }) = _AmaiStoreState;
}
