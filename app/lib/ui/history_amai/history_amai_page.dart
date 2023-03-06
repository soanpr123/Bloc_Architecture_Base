import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:resources/resources.dart';

import '../../app.dart';
import '../../shared_view/loadingview.dart';

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
      body: BlocBuilder<HistoryAmaiBloc, HistoryAmaiState>(
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
                              child: GestureDetector(
                                onTap: () async {
                                  // bloc.add(
                                  //     ReadNotification(type: item.type ?? '', slung: item.slug ?? '', id: item.id));
                                },
                                child: ListTile(
                                  leading: Assets.svg.chicken.svg(),
                                  minLeadingWidth: Dimens.d5.responsive(),
                                  title: Align(
                                    alignment: const Alignment(-1.2, 0),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive()),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.note ?? '',
                                                style: typoInterNomal14.copyWith(
                                                  color: colorTextDark,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5,
                                                ),
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
                                          Row(
                                            children: [
                                              Text(
                                                '-${e.amountAmais} ',
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
                                    ),
                                  ),
                                ),
                              ),
                            );
                            // return index == 0 || state.history[index].groub != state.history[index - 1].groub
                            //     ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            //         // const SizedBox(height: 16),
                            //         Container(
                            //           height: Dimens.d30.responsive(),
                            //           width: double.infinity,
                            //           color: colorDisabled,
                            //           padding: EdgeInsets.symmetric(vertical: Dimens.d4.responsive()),
                            //           child: Center(
                            //             child: Text(
                            //               'Tháng ${state.history[index].groub ?? ''}',
                            //               style: typoInterNomal14.copyWith(
                            //                 color: colorBrandPrimary,
                            //                 fontWeight: FontWeight.w700,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //         const SizedBox(height: 8),
                            //         ShimmerLoading(
                            //           isLoading: state.isShimmerLoading,
                            //           loadingWidget: const LoadingItem(),
                            //           child: GestureDetector(
                            //             onTap: () async {
                            //               // bloc.add(
                            //               //     ReadNotification(type: item.type ?? '', slung: item.slug ?? '', id: item.id));
                            //             },
                            //             child: ListTile(
                            //               title: Padding(
                            //                 padding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive()),
                            //                 child: Row(
                            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                   crossAxisAlignment: CrossAxisAlignment.start,
                            //                   children: [
                            //                     Column(
                            //                       crossAxisAlignment: CrossAxisAlignment.start,
                            //                       children: [
                            //                         Text(state.history[index].note ?? '',
                            //                             style: typoInterNomal14.copyWith(
                            //                               color: colorTextMedium,
                            //                               fontWeight: FontWeight.w600,
                            //                             )),
                            //                         SizedBox(
                            //                           height: Dimens.d8.responsive(),
                            //                         ),
                            //                         Text(
                            //                           state.history[index].createdAt ?? '',
                            //                           style: typoInterNomal14.copyWith(color: colorTextMedium),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                     Row(
                            //                       children: [
                            //                         Text(
                            //                           '-${state.history[index].amountAmais} ',
                            //                           style: typoInterNomal14.copyWith(
                            //                               color: colorSupportWarning, fontWeight: FontWeight.w600),
                            //                         ),
                            //                         Assets.svg.logoamai.svg(width: 20, height: 20),
                            //                       ],
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ])
                            //     : ShimmerLoading(
                            //         isLoading: state.isShimmerLoading,
                            //         loadingWidget: const LoadingItem(),
                            //         child: GestureDetector(
                            //           onTap: () async {
                            //             // bloc.add(
                            //             //     ReadNotification(type: item.type ?? '', slung: item.slug ?? '', id: item.id));
                            //           },
                            //           child: ListTile(
                            //             title: Padding(
                            //               padding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive()),
                            //               child: Row(
                            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   Column(
                            //                     crossAxisAlignment: CrossAxisAlignment.start,
                            //                     children: [
                            //                       Text(
                            //                         state.history[index].createdAt ?? '',
                            //                         style: typoInterNomal14.copyWith(color: colorTextMedium),
                            //                       ),
                            //                       SizedBox(
                            //                         height: Dimens.d8.responsive(),
                            //                       ),
                            //                       Text(
                            //                         state.history[index].note ?? '',
                            //                         style: typoInterNomal14.copyWith(color: colorTextDark),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                   Text(
                            //                     '-${state.history[index].amountAmais} Amai',
                            //                     style: typoInterNomal14.copyWith(
                            //                         color: colorSupportWarning, fontWeight: FontWeight.w600),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       );
                          },
                        ),
            ),
          );
        },
      ),
    );
  }
}
