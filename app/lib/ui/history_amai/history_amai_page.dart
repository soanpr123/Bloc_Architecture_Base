import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import '../../shared_view/loadingview.dart';

class HistoryAmaiPage extends StatefulWidget {
  const HistoryAmaiPage({Key? key}) : super(key: key);

  @override
  _HistoryAmaiState createState() => _HistoryAmaiState();
}

class _HistoryAmaiState extends BasePageState<HistoryAmaiPage, HistoryAmaiBloc> {
  final refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    bloc.add(const HistoryPageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        text: S.current.history_amai,
        corlorText: Colors.white,
        centerTitle: true,
        backgroundColor: colorBrandPrimary,
        elevation: 1,
        height: Dimens.d70.responsive(),
      ),
      body: BlocBuilder<HistoryAmaiBloc, HistoryAmaiState>(
        buildWhen: (previous, current) =>
            previous.history != current.history ||
            previous.isShimmerLoading != current.isShimmerLoading ||
            previous.enablePullNotifi != current.enablePullNotifi ||
            previous.page != current.page,
        builder: (context, state) {
          return state.isShimmerLoading
              ? const ListViewLoader()
              : state.history.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CommonNoItemsFoundIndicator(),
                      ],
                    )
                  : SmartRefresher(
                      primary: true,
                      controller: refreshController,
                      enablePullUp: true,
                      enablePullDown: state.enablePullNotifi,
                      onLoading: () => bloc.add(AmaiHistoryLoadMore(completer: refreshController)),
                      onRefresh: () => bloc.add(AmaiHistoryPageRefreshed(completer: refreshController)),
                      child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0.0),
                        itemCount: state.history.length,
                        itemBuilder: (BuildContext context, int index) {
                          return index == 0 || state.history[index].groub != state.history[index - 1].groub
                              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  // const SizedBox(height: 16),
                                  Container(
                                    height: Dimens.d30.responsive(),
                                    width: double.infinity,
                                    color: colorDisabled,
                                    padding: EdgeInsets.symmetric(vertical: Dimens.d4.responsive()),
                                    child: Center(
                                      child: Text(
                                        'Tháng ${state.history[index].groub ?? ''}',
                                        style: typoInterNomal14.copyWith(
                                          color: colorBrandPrimary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ShimmerLoading(
                                    isLoading: state.isShimmerLoading,
                                    loadingWidget: const LoadingItem(),
                                    child: GestureDetector(
                                      onTap: () async {
                                        // bloc.add(
                                        //     ReadNotification(type: item.type ?? '', slung: item.slug ?? '', id: item.id));
                                      },
                                      child: ListTile(
                                        title: Padding(
                                          padding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive()),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.history[index].createdAt ?? '',
                                                    style: typoInterNomal14.copyWith(color: colorTextMedium),
                                                  ),
                                                  SizedBox(
                                                    height: Dimens.d8.responsive(),
                                                  ),
                                                  Text(state.history[index].note ?? '',
                                                      style: typoInterNomal14.copyWith(color: colorTextDark)),
                                                ],
                                              ),
                                              Text(
                                                '-${state.history[index].amountAmais} Amai',
                                                style: typoInterNomal14.copyWith(
                                                    color: colorSupportWarning, fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ])
                              : ShimmerLoading(
                                  isLoading: state.isShimmerLoading,
                                  loadingWidget: const LoadingItem(),
                                  child: GestureDetector(
                                    onTap: () async {
                                      // bloc.add(
                                      //     ReadNotification(type: item.type ?? '', slung: item.slug ?? '', id: item.id));
                                    },
                                    child: ListTile(
                                      title: Padding(
                                        padding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive()),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.history[index].createdAt ?? '',
                                                  style: typoInterNomal14.copyWith(color: colorTextMedium),
                                                ),
                                                SizedBox(
                                                  height: Dimens.d8.responsive(),
                                                ),
                                                Text(
                                                  state.history[index].note ?? '',
                                                  style: typoInterNomal14.copyWith(color: colorTextDark),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '-${state.history[index].amountAmais} Amai',
                                              style: typoInterNomal14.copyWith(
                                                  color: colorSupportWarning, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    );
        },
      ),
    );
  }
}
