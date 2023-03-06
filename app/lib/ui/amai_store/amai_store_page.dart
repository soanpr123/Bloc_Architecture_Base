import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../shared_view/app_netword_image.dart';

class AmaiStorePage extends StatefulWidget {
  const AmaiStorePage({Key? key}) : super(key: key);

  @override
  _AmaiStorePageState createState() => _AmaiStorePageState();
}

class _AmaiStorePageState extends BasePageState<AmaiStorePage, AmaiStoreBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const AmaiStoreInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        centerTitle: true,
        backgroundColor: colorSupportWarning,
        elevation: 1,
        text: S.current.store,
        corlorText: Colors.white,
        // height: MediaQuery.of(context).padding.top + Dimens.d60.responsive(),
        leadingIcon: const BackButton(color: Colors.white),
      ),
      body: BlocBuilder<AmaiStoreBloc, AmaiStoreState>(
        buildWhen: (previous, current) =>
            previous.canteen != current.canteen ||
            previous.other != current.other ||
            previous.isShimmerLoading != current.isShimmerLoading ||
            previous.amaiOrder != current.amaiOrder ||
            previous.buttonStateDelete != current.buttonStateDelete ||
            previous.apirequestNoti != current.apirequestNoti,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive()),
            child: Column(
              children: [
                SizedBox(
                  height: Dimens.d24.responsive(),
                ),
                Text(
                  S.current.amaistore_content,
                  style: typoInterNomal14.copyWith(
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: Dimens.d8.responsive(),
                ),
                Text(
                  S.current.time_amai,
                  style: typoInterNomal14.copyWith(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: state.amaiOrder.id != -1 && state.amaiOrder.id != null
                      ? Dimens.d24.responsive()
                      : Dimens.d12.responsive(),
                ),
                state.amaiOrder.id != -1 && state.amaiOrder.id != null
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimens.d12.responsive(),
                          vertical: Dimens.d12.responsive(),
                        ),
                        decoration: BoxDecoration(
                          color: colorAmber100,
                          boxShadow: boxShadow,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Bạn đã đặt',
                                style: typoInterNomal14.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: colorTextDark,
                                  fontSize: Dimens.d16.responsive(),
                                  height: 1.5,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: state.amaiOrder.type == 0
                                        ? ' Thực đơn ${state.canteen[state.canteen.indexWhere((element) => element.id == state.amaiOrder.lunchMenusId)].orderNo}'
                                        : ' ${state.amaiOrder.menuName}',
                                    style: typoInterNomal14.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimens.d16.responsive(),
                                      color: colorBrandPrimary,
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' cho bữa trưa hôm nay.!',
                                    style: typoInterNomal14.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: colorTextDark,
                                      fontSize: Dimens.d16.responsive(),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimens.d4.responsive(),
                            ),
                            Text(
                              S.current.amai_note_order,
                              style: typoInterNomal14.copyWith(
                                color: colorSupportDanger,
                                fontWeight: FontWeight.w400,
                                fontSize: Dimens.d14.responsive(),
                                height: 1.5,
                              ),
                            ),
                            SizedBox(
                              height: Dimens.d4.responsive(),
                            ),
                            Text(
                              S.current.amai_congaru,
                              style: typoInterNomal14.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: Dimens.d16.responsive(),
                                color: colorTextDark,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(
                              height: Dimens.d24.responsive(),
                            ),
                            DateTimeUtils.checkTime()
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Dimens.d40.responsive(),
                                        ),
                                        child: AppElevatedButton(
                                          state: state.buttonStateDelete,
                                          buttonTitle: S.current.amai_cance,
                                          onPressed: () {
                                            bloc.add(const AmaiStoreDeleteOrderPress());
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: state.amaiOrder.id != -1 && state.amaiOrder.id != null
                      ? Dimens.d24.responsive()
                      : Dimens.d12.responsive(),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    bloc.add(const AmaiStoreInitiated());
                  },
                  child: BodyBuilder(
                    isStore: true,
                    apiRequestStatus: state.apirequestNoti,
                    image: Assets.png.icNodataStore.image(width: 150, height: 150),
                    reload: () {
                      bloc.add(const AmaiStoreInitiated());
                    },
                    child: Column(
                      children: [
                        state.canteen.isNotEmpty
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Cơm canteen',
                                        style: typoInterNomal18.copyWith(
                                          color: colorTextDark,
                                          fontSize: Dimens.d20.responsive(),
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(
                                      bottom: state.other.isEmpty ? MediaQuery.of(context).padding.bottom : 0,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: state.canteen.length,
                                    itemBuilder: (ctx, i) {
                                      final item = state.canteen[i];

                                      return ShimmerLoading(
                                        isLoading: state.isShimmerLoading,
                                        loadingWidget: const _LoadingItem(),
                                        child: GestureDetector(
                                          onTap: (state.amaiOrder.id == -1 || state.amaiOrder.id == null)
                                              ? DateTimeUtils.checkTime()
                                                  ? null
                                                  : () {
                                                      navigator.showDialog(AppPopupInfo.dialogConfirm(
                                                        message: Column(
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                text: 'Bạn đặt',
                                                                style: typoInterNomal14.copyWith(
                                                                  fontWeight: FontWeight.w400,
                                                                  color: colorTextMedium,
                                                                  height: 1.5,
                                                                ),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text: ' Thực đơn ${item.orderNo}',
                                                                    style: typoInterNomal14.copyWith(
                                                                      fontWeight: FontWeight.w600,
                                                                      color: colorTextDark,
                                                                      height: 1.5,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: ' cho bữa trưa hôm nay.!',
                                                                    style: typoInterNomal14.copyWith(
                                                                      fontWeight: FontWeight.w400,
                                                                      color: colorTextMedium,
                                                                      height: 1.5,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        onPress: () {
                                                          if (state.amaiOrder.id == -1 || state.amaiOrder.id == null) {
                                                            bloc.add(AmaiStoreOrderPress(id: item.id ?? 0));
                                                          }
                                                        },
                                                      ));
                                                    }
                                              : null,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              bottom: Dimens.d12.responsive(),
                                              top: i == 0 ? Dimens.d12.responsive() : 0,
                                            ),
                                            height: Dimens.d143.responsive(),
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: boxShadow,
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: Dimens.d143.responsive(),
                                                  child: const ClipRRect(
                                                    child: AppNetworkImage(
                                                      source:
                                                          'https://internal.amaisoft.com/assets/canteen1.300efa8c.webp',
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(Dimens.d8.responsive()),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Thực đơn ${item.orderNo}',
                                                                  style: typoInterNomal16.copyWith(
                                                                    height: 1.5,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: Dimens.d4.responsive(),
                                                            ),
                                                            Text(
                                                              item.name ?? '',
                                                              style: typoInterNomal14.copyWith(
                                                                height: 1.5,
                                                                letterSpacing: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              SymbolConstants.amountStore,
                                                              style: typoInterNomal14.copyWith(
                                                                color: colorSupportDanger,
                                                                height: 1.5,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: Dimens.d12.responsive(),
                        ),
                        state.canteen.isNotEmpty
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Cơm Ngoài',
                                        style: typoInterNomal18.copyWith(color: colorTextDark, fontSize: 24),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    // padding: const EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemCount: state.other.length,
                                    itemBuilder: (ctx, i) {
                                      final item = state.other[i];

                                      return ShimmerLoading(
                                        isLoading: state.isShimmerLoading,
                                        loadingWidget: const _LoadingItem(),
                                        child: GestureDetector(
                                          onTap: (state.amaiOrder.id == -1 || state.amaiOrder.id == null)
                                              ? DateTimeUtils.checkTime()
                                                  ? null
                                                  : () {
                                                      navigator.showDialog(AppPopupInfo.dialogConfirm(
                                                        message: Column(
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                text: 'Bạn đặt',
                                                                style: typoInterNomal14.copyWith(
                                                                  height: 1.5,
                                                                ),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text: ' ${item.name}',
                                                                    style: typoInterNomal14.copyWith(
                                                                      fontWeight: FontWeight.w600,
                                                                      height: 1.5,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: ' cho bữa trưa hôm nay.!',
                                                                    style: typoInterNomal14.copyWith(
                                                                      height: 1.5,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        onPress: () {
                                                          if (state.amaiOrder.id == -1 || state.amaiOrder.id == null) {
                                                            bloc.add(AmaiStoreOrderPress(id: item.id ?? 0));
                                                          }
                                                        },
                                                      ));
                                                    }
                                              : null,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              bottom: Dimens.d12.responsive(),
                                              top: i == 0 ? Dimens.d12.responsive() : 0,
                                            ),
                                            height: Dimens.d120.responsive(),
                                            width: DeviceConstants.designDeviceWidth,
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: boxShadow,
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: Dimens.d143.responsive(),
                                                  child: const ClipRRect(
                                                    child: AppNetworkImage(
                                                      source:
                                                          'https://internal.amaisoft.com/assets/canteen1.300efa8c.webp',
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(Dimens.d8.responsive()),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              item.name ?? '',
                                                              style: typoInterNomal14.copyWith(
                                                                height: 1.5,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              SymbolConstants.amountStore,
                                                              style: typoInterNomal14.copyWith(
                                                                color: colorSupportDanger,
                                                                height: 1.5,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  const _LoadingItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RounedRectangleShimmer(
      width: double.infinity,
      height: Dimens.d143.responsive(),
    );
  }
}

class _ListViewLoader extends StatelessWidget {
  const _ListViewLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: UiConstants.shimmerItemCount,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.d8.responsive(),
          vertical: Dimens.d8.responsive(),
        ),
        child: const ShimmerLoading(
          loadingWidget: _LoadingItem(),
          isLoading: true,
          child: _LoadingItem(),
        ),
      ),
    );
  }
}
