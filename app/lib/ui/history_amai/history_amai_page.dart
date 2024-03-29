import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:resources/resources.dart';

import '../../app.dart';
import '../../shared_view/loadingview.dart';
@RoutePage()
class HistoryAmaiPage extends StatefulWidget {
  const HistoryAmaiPage({Key? key}) : super(key: key);

  @override
  _HistoryAmaiState createState() => _HistoryAmaiState();
}

class _HistoryAmaiState extends BasePageState<HistoryAmaiPage, HistoryAmaiBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const HistoryPageInitiated());
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) => previous.reloadHis != current.reloadHis,
          listener: (context, state) {
            bloc.add(const HistoryPageInitiated());
          },
        ),
      ],
      child: child,
    );
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
        // height: MediaQuery.of(context).padding.top + Dimens.d56.responsive(),
      ),
      body: SafeArea(
        child: BlocBuilder<AppBloc, AppState>(
          buildWhen: (previous, current) => previous.reloadHis != current.reloadHis,
          builder: (context, stateapp) {
            return BlocBuilder<HistoryAmaiBloc, HistoryAmaiState>(
              buildWhen: (previous, current) =>
                  previous.history != current.history ||
                  previous.isShimmerLoading != current.isShimmerLoading ||
                  previous.enablePullNotifi != current.enablePullNotifi ||
                  previous.page != current.page ||
                  previous.apirequest != current.apirequest,
              builder: (context, state) {
                return BodyBuilder(
                  apiRequestStatus: state.apirequest,
                  reload: () {
                    bloc.add(const HistoryPageInitiated());
                  },
                  image: Assets.png.noData.image(
                    width: Dimens.d265.responsive(),
                    height: Dimens.d200.responsive(),
                    fit: BoxFit.contain,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () {
                      bloc.add(const HistoryPageInitiated());

                      return Future.value();
                    },
                    child: state.isShimmerLoading
                        ? const ListViewLoader()
                        : state.history.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CommonNoItemsFoundIndicator(),
                                ],
                              )
                            : GroupedListView(
                                // physics: const NeverScrollableScrollPhysics(),
                                elements: state.history,
                                // physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                order: GroupedListOrder.DESC,
                                padding: const EdgeInsets.all(0.0),
                                useStickyGroupSeparators: true,
                                groupBy: (element) => element.groub ?? '',
                                itemComparator: (item1, item2) => (item1.createdAt ?? '')
                                    .split(' ')[1]
                                    .compareTo((item2.createdAt ?? '').split(' ')[1]),
                                groupSeparatorBuilder: (String value) => Container(
                                  width: double.infinity,
                                  color: colorUiBg05,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.d24.responsive(),
                                    vertical: Dimens.d8.responsive(),
                                  ),
                                  child: Text(
                                    'Tháng $value',
                                    style: typoInterNomal14.copyWith(
                                      color: colorTextMedium,
                                      fontSize: Dimens.d12.responsive(),
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                ),

                                itemBuilder: (context, e) {
                                  return ShimmerLoading(
                                    isLoading: state.isShimmerLoading,
                                    loadingWidget: const LoadingItem(),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive()),
                                      child: ListTile(
                                        leading: e.type == 1 ? Assets.svg.chicken.svg() : Assets.svg.giftHistory.svg(),
                                        minLeadingWidth: Dimens.d5.responsive(),
                                        title: Align(
                                          alignment: const Alignment(-1.2, 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Flexible(
                                                          child: HtmlWidget(
                                                            e.note ?? '',
                                                            textStyle: typoInterNomal14.copyWith(
                                                              height: 1.5,
                                                            ),
                                                            customStylesBuilder: (element) {
                                                              if (element.className == 'text-notification-bold') {
                                                                return {
                                                                  'font-family': 'Inter',
                                                                  'font-style': 'normal',
                                                                  // 'color': '#1F2937',
                                                                  'font-weight': '600',
                                                                  // 'font-size': ' 14px',
                                                                  'line-height': '150%',
                                                                };
                                                              }

                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimens.d24.responsive(),
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              e.type == 3 ? '+${e.amountAmais} ' : '-${e.amountAmais} ',
                                                              style: typoInterNomal14.copyWith(
                                                                color: colorTextMedium,
                                                                fontWeight: FontWeight.w600,
                                                                height: 1.5,
                                                              ),
                                                            ),
                                                            Assets.svg.logoamai.svg(width: 20, height: 20),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    // SizedBox(
                                                    //   height: Dimens.d18.responsive(),
                                                    // ),
                                                    Text(
                                                      e.createdAt ?? '',
                                                      style: typoInterNomal14.copyWith(
                                                        color: colorTextBland,
                                                        height: 1.5,
                                                        fontSize: Dimens.d12.responsive(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
