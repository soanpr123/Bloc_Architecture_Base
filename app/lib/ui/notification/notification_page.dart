import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../shared_view/app_netword_image.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends BasePageState<NotificationPage, NotificationBloc> with TickerProviderStateMixin {
  // RefreshController refreshControllerNotifi = RefreshController(initialRefresh: false);
  late final _pagingController = CommonPagingController<AppNotification>()..disposeBy(disposeBag);
  late final _pagingControllerUnread = CommonPagingController<AppNotification>()..disposeBy(disposeBag);
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    bloc.add(const NotificationPageInitiated());
    _pagingController.listen(
      onLoadMore: () => bloc.add(const NotificationLoadMore()),
    );
    _pagingControllerUnread.listen(
      onLoadMore: () => bloc.add(const NotificationUnreadLoadMore()),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationBloc, NotificationState>(
          listenWhen: (previous, current) => previous.notifi != current.notifi,
          listener: (context, state) {
            _pagingController.appendLoadMoreOutput(state.notifi);
          },
        ),
        BlocListener<NotificationBloc, NotificationState>(
          listenWhen: (previous, current) => previous.loadUsersException != current.loadUsersException,
          listener: (context, state) {
            _pagingController.error = state.loadUsersException;
          },
        ),
        BlocListener<NotificationBloc, NotificationState>(
          listenWhen: (previous, current) => previous.notifiUnread != current.notifiUnread,
          listener: (context, state) {
            _pagingControllerUnread.appendLoadMoreOutput(state.notifiUnread);
          },
        ),
        BlocListener<NotificationBloc, NotificationState>(
          listenWhen: (previous, current) => previous.loadNotifiUnreadException != current.loadNotifiUnreadException,
          listener: (context, state) {
            _pagingControllerUnread.error = state.loadNotifiUnreadException;
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
        text: S.current.notification,
        centerTitle: true,
        corlorText: Colors.white,
        backgroundColor: colorBrandPrimary,
        elevation: 1,
        height: Dimens.d80.responsive(),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(Dimens.d8.responsive(), 0, Dimens.d8.responsive(), 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<NotificationBloc, NotificationState>(
                  buildWhen: (previous, current) => previous.curentTab != current.curentTab,
                  builder: (context, state) {
                    return Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            tabController.animateTo(0);
                            bloc.add(NotificationonTapTab(tabController: tabController));
                            final completer = Completer<void>();
                            bloc.add(NotificationPageRefreshed(completer: completer));
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(colorDisabled),
                          ),
                          child: Text(
                            'Tất cả',
                            style: typoInterNomal14.copyWith(
                              fontWeight: FontWeight.w600,
                              color: state.curentTab == 0 ? colorBrandPrimary : colorBrandSecondary,
                              height: 1.5,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            final completer = Completer<void>();

                            tabController.animateTo(1);
                            bloc.add(NotificationonTapTab(tabController: tabController));
                            bloc.add(NotificationUnreadPageRefreshed(completer: completer));
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(colorDisabled),
                          ),
                          child: Text(
                            'Chưa đọc',
                            style: typoInterNomal14.copyWith(
                              fontWeight: FontWeight.w600,
                              color: state.curentTab == 1 ? colorBrandPrimary : colorBrandSecondary,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        bloc.add(const ReadAllNotifiPress());
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(colorDisabled),
                      ),
                      child: Row(
                        children: [
                          Assets.svg.icCheckDoubleFill
                              .svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Đã đọc',
                            style: typoInterNomal14.copyWith(fontWeight: FontWeight.w600, color: colorBrandPrimary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BlocBuilder<NotificationBloc, NotificationState>(
                  buildWhen: (previous, current) =>
                      previous.notifi != current.notifi ||
                      previous.isShimmerLoading != current.isShimmerLoading ||
                      previous.enablePullNotifi != current.enablePullNotifi ||
                      previous.page != current.page ||
                      previous.apirequestNoti != current.apirequestNoti,
                  builder: (context, state) {
                    return BodyBuilder(
                      apiRequestStatus: state.apirequestNoti,
                      image: Assets.png.noData.image(
                        width: Dimens.d265.responsive(),
                        height: Dimens.d200.responsive(),
                        fit: BoxFit.contain,
                      ),
                      reload: () {
                        bloc.add(const NotificationPageInitiated());
                      },
                      child: RefreshIndicator(
                        onRefresh: () {
                          final completer = Completer<void>();
                          bloc.add(NotificationPageRefreshed(completer: completer));

                          return completer.future;
                        },
                        child: state.isShimmerLoading && state.notifi.data.isEmpty
                            ? const _ListViewLoader()
                            : CommonPagedListView<AppNotification>(
                                pagingController: _pagingController,
                                itemBuilder: (context, item, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimens.d8.responsive(),
                                      vertical: Dimens.d4.responsive(),
                                    ),
                                    child: ShimmerLoading(
                                      isLoading: state.isShimmerLoading,
                                      loadingWidget: const _LoadingItem(),
                                      child: GestureDetector(
                                        onTap: () async {
                                          bloc.add(ReadNotification(
                                              type: item.type ?? '', slung: item.slug ?? '', id: item.id));
                                        },
                                        child: Container(
                                          // height: 100,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimens.d8.responsive(),
                                            vertical: Dimens.d8.responsive(),
                                          ),

                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Dimens.d32.responsive(),
                                                height: Dimens.d32.responsive(),
                                                alignment: Alignment.topCenter,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.2),
                                                  borderRadius: BorderRadius.all(Radius.circular(
                                                    Dimens.d24.responsive(),
                                                  )),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(Radius.circular(Dimens.d24.responsive())),
                                                  child: item.type == 'announcements' || item.type == 'lunch_menus'
                                                      ? Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Assets.svg.logoamai.svg(
                                                              width: Dimens.d20.responsive(),
                                                              height: Dimens.d20.responsive(),
                                                            ),
                                                          ],
                                                        )
                                                      : AppNetworkImage(
                                                          source: item.avatar,
                                                        ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Flexible(
                                                                child: HtmlWidget(
                                                                  item.title ?? '',
                                                                  textStyle: typoInterNomal14.copyWith(
                                                                    height: 1.5,
                                                                  ),
                                                                  customStylesBuilder: (element) {
                                                                    if (element.className == 'text-notification-bold') {
                                                                      return {
                                                                        'font-family': 'Inter',
                                                                        'font-style': 'normal',
                                                                        'color': '#1F2937',
                                                                        'font-weight': '600',
                                                                        'font-size': ' 14px',
                                                                        'line-height': '150%',
                                                                      };
                                                                    }

                                                                    return null;
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: Dimens.d4.responsive(),
                                                          ),
                                                          Text(
                                                            item.createdAt ?? '',
                                                            style: typoInterNomal14.copyWith(
                                                              height: 1.5,
                                                              fontSize: Dimens.d12.responsive(),
                                                              color: colorTextBland,
                                                              letterSpacing: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Dimens.d12.responsive(),
                                                    ),
                                                    item.readAt != ''
                                                        ? const SizedBox.shrink()
                                                        : Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                width: Dimens.d12.responsive(),
                                                                height: Dimens.d12.responsive(),
                                                                decoration: BoxDecoration(
                                                                  color: colorBrandPrimary,
                                                                  borderRadius: BorderRadius.all(Radius.circular(
                                                                    Dimens.d24.responsive(),
                                                                  )),
                                                                ),
                                                              ),
                                                            ],
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
                ),
                BlocBuilder<NotificationBloc, NotificationState>(
                  buildWhen: (previous, current) =>
                      previous.notifiUnread != current.notifiUnread ||
                      previous.isShimmerLoadingUnread != current.isShimmerLoadingUnread ||
                      previous.apirequestUnread != current.apirequestUnread,
                  builder: (context, state) {
                    return BodyBuilder(
                      apiRequestStatus: state.apirequestUnread,
                      image: Assets.png.noData.image(
                        width: Dimens.d265.responsive(),
                        height: Dimens.d200.responsive(),
                        fit: BoxFit.contain,
                      ),
                      reload: () {
                        bloc.add(const NotificationPageInitiated());
                      },
                      child: RefreshIndicator(
                        onRefresh: () {
                          final completer = Completer<void>();
                          bloc.add(NotificationUnreadPageRefreshed(completer: completer));

                          return completer.future;
                        },
                        child: state.isShimmerLoadingUnread && state.notifiUnread.data.isEmpty
                            ? const _ListViewLoader()
                            : CommonPagedListView<AppNotification>(
                                pagingController: _pagingControllerUnread,
                                itemBuilder: (context, item, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimens.d8.responsive(),
                                      vertical: Dimens.d4.responsive(),
                                    ),
                                    child: ShimmerLoading(
                                      isLoading: state.isShimmerLoadingUnread,
                                      loadingWidget: const _LoadingItem(),
                                      child: GestureDetector(
                                        onTap: () async {
                                          bloc.add(ReadNotification(
                                              type: item.type ?? '', slung: item.slug ?? '', id: item.id));
                                        },
                                        child: Container(
                                          // height: 100,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimens.d8.responsive(),
                                            vertical: Dimens.d8.responsive(),
                                          ),

                                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Container(
                                              width: Dimens.d32.responsive(),
                                              height: Dimens.d32.responsive(),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.withOpacity(0.2),
                                                borderRadius: BorderRadius.all(Radius.circular(
                                                  Dimens.d24.responsive(),
                                                )),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.all(Radius.circular(Dimens.d24.responsive())),
                                                child: item.type == 'announcements' || item.type == 'lunch_menus'
                                                    ? Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Assets.svg.logoamai.svg(
                                                            width: Dimens.d20.responsive(),
                                                            height: Dimens.d20.responsive(),
                                                          ),
                                                        ],
                                                      )
                                                    : AppNetworkImage(
                                                        source: item.avatar,
                                                      ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: HtmlWidget(
                                                          item.title ?? '',
                                                          customStylesBuilder: (element) {
                                                            if (element.className == 'text-notification-bold') {
                                                              return {'color': 'black', 'font-weight': 'bold'};
                                                            }

                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Dimens.d8.responsive(),
                                                  ),
                                                  Text(
                                                    item.createdAt ?? '',
                                                    style: typoInterNomal14.copyWith(
                                                        fontSize: Dimens.d12.responsive(), color: colorTextBland),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimens.d12.responsive(),
                                            ),
                                            item.readAt != ''
                                                ? const SizedBox.shrink()
                                                : Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        width: Dimens.d12.responsive(),
                                                        height: Dimens.d12.responsive(),
                                                        decoration: BoxDecoration(
                                                          color: colorBrandPrimary,
                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                            Dimens.d24.responsive(),
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
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
      height: Dimens.d60.responsive(),
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
