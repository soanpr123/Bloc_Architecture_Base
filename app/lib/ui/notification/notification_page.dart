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

class _NotificationPageState extends BasePageState<NotificationPage, NotificationBloc> {
  // RefreshController refreshControllerNotifi = RefreshController(initialRefresh: false);
  late final _pagingController = CommonPagingController<AppNotification>()..disposeBy(disposeBag);
  late final _pagingControllerUnread = CommonPagingController<AppNotification>()..disposeBy(disposeBag);

  @override
  void initState() {
    super.initState();
    bloc.add(const NotificationPageInitiated());
    _pagingController.listen(
      onLoadMore: () => bloc.add(const NotificationLoadMore()),
    );
    _pagingControllerUnread.listen(
      onLoadMore: () => bloc.add(const NotificationUnreadLoadMore()),
    );
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
    return DefaultTabController(
      length: 2,
      child: CommonScaffold(
        appBar: CommonAppBar(
          text: S.current.notification,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          height: Dimens.d90.responsive(),
          bottom: TabBar(
            indicatorColor: colorBrandPrimary,
            labelColor: colorBrandPrimary,
            unselectedLabelColor: colorTextBland,
            labelStyle: typoInterNomal14.copyWith(fontWeight: FontWeight.w600),
            // controller: tabController,?
            onTap: (v) async {
              // print(v);
              // if (v == 1) {
              //   NotificationCubit().onRefesPageUnread(refreshControllerNotifiUnread);
              // } else {
              //   NotificationCubit().onRefesPage(refreshControllerNotifi);
              // }
            },
            tabs: const [
              Tab(
                text: 'Tất cả',
              ),
              Tab(
                text: 'Chưa đọc',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<NotificationBloc, NotificationState>(
              buildWhen: (previous, current) =>
                  previous.notifi != current.notifi ||
                  previous.isShimmerLoading != current.isShimmerLoading ||
                  previous.enablePullNotifi != current.enablePullNotifi ||
                  previous.page != current.page,
              builder: (context, state) {
                return RefreshIndicator(
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
                                    bloc.add(
                                        ReadNotification(type: item.type ?? '', slung: item.slug ?? '', id: item.id));
                                  },
                                  child: Container(
                                    // height: 100,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: Dimens.d8.responsive(),
                                      vertical: Dimens.d8.responsive(),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimens.d16.responsive(),
                                      vertical: Dimens.d16.responsive(),
                                    ),
                                    decoration: BoxDecoration(
                                        color: item.readAt != '' ? Colors.white : Colors.grey.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        // ignore: prefer-trailing-comma
                                        boxShadow: item.readAt != '' ? boxShadow : null),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      CircleAvatar(
                                        radius: Dimens.d24.responsive(),
                                        backgroundColor: Colors.grey.withOpacity(0.2),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(Dimens.d24.responsive())),
                                          child: item.type == 'announcements' || item.type == 'lunch_menus'
                                              ? Assets.svg.logoamai
                                                  .svg(width: Dimens.d24.responsive(), height: Dimens.d24.responsive())
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
                                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(item.createdAt ?? ''),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
            BlocBuilder<NotificationBloc, NotificationState>(
              buildWhen: (previous, current) =>
                  previous.notifiUnread != current.notifiUnread ||
                  previous.isShimmerLoadingUnread != current.isShimmerLoadingUnread,
              builder: (context, state) {
                return RefreshIndicator(
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
                                    bloc.add(
                                        ReadNotification(type: item.type ?? '', slung: item.slug ?? '', id: item.id));
                                  },
                                  child: Container(
                                    // height: 100,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: Dimens.d8.responsive(),
                                      vertical: Dimens.d8.responsive(),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimens.d16.responsive(),
                                      vertical: Dimens.d16.responsive(),
                                    ),
                                    decoration: BoxDecoration(
                                        color: item.readAt != '' ? Colors.white : Colors.grey.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        // ignore: prefer-trailing-comma
                                        boxShadow: item.readAt != '' ? boxShadow : null),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      CircleAvatar(
                                        radius: Dimens.d24.responsive(),
                                        backgroundColor: Colors.grey.withOpacity(0.2),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(Dimens.d24.responsive())),
                                          child: item.type == 'announcements' || item.type == 'lunch_menus'
                                              ? Assets.svg.logoamai
                                                  .svg(width: Dimens.d24.responsive(), height: Dimens.d24.responsive())
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
                                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(item.createdAt ?? ''),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
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
