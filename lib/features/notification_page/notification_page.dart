import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:project/component/app_netword_image.dart';
import 'package:project/component/build_body.dart';
import 'package:project/core/style/app_style.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/notification_page/cubit/notification_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with TickerProviderStateMixin {
  late TabController tabController;
  RefreshController refreshControllerNotifi = RefreshController(initialRefresh: false);
  RefreshController refreshControllerNotifiUnread = RefreshController(initialRefresh: false);
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    refreshControllerNotifi.dispose();
    refreshControllerNotifiUnread.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationCubit()
        ..requestNotification()
        ..requestNotificationUnread(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          // leading: const BackButton(
          //   color: Colors.black,
          // ),
          elevation: 1,
          title: Text(
            translation(context).notification,
            style: typoInterNomal18,
          ),
          bottom: TabBar(
              indicatorColor: colorBrandPrimary,
              labelColor: colorBrandPrimary,
              unselectedLabelColor: colorTextBland,
              labelStyle: typoInterNomal14.copyWith(fontWeight: FontWeight.w600),
              controller: tabController,
              onTap: (v) async {
                print(v);
                if (v == 1) {
                  NotificationCubit().onRefesPageUnread(refreshControllerNotifiUnread);
                } else {
                  NotificationCubit().onRefesPage(refreshControllerNotifi);
                }
              },
              tabs: const [
                Tab(
                  text: "Tất cả",
                ),
                Tab(
                  text: "Chưa đọc",
                )
              ]),
        ),
        body: TabBarView(controller: tabController, children: [
          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              return BodyBuilder(
                  apiRequestStatus: state.apiRequestStatus,
                  child: SmartRefresher(
                    controller: refreshControllerNotifi,
                    onLoading: () => context.read<NotificationCubit>().onLoadingPage(refreshControllerNotifi),
                    onRefresh: () => context.read<NotificationCubit>().onRefesPage(refreshControllerNotifi),
                    enablePullDown: true,
                    enablePullUp: state.enablePullNotifi,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.notification.length,
                        itemBuilder: (ctx, i) {
                          final item = state.notification[i];
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<NotificationCubit>()
                                  .onTapNotifi(item.type ?? "", item.slug ?? "", item.id ?? "");
                            },
                            child: Container(
                              // height: 100,
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                  color: item.readAt != null ? Colors.white : Colors.grey.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  boxShadow: item.readAt != null ? boxShadow : null),
                              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.grey.withOpacity(0.2),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                                    child: item.type == "announcements" || item.type == "lunch_menus"
                                        ? SvgPicture.asset(
                                            R.ASSETS_SVG_LOGOAMAI_SVG,
                                            width: 32,
                                            height: 32,
                                          )
                                        : AppNetworkImage(
                                            source: item.userAvatar ??
                                                "https://internal.amaisoft.com/assets/image_default.492cb8ad.svg",
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width - 120,
                                      child: Row(
                                        children: [
                                          Flexible(
                                              child: HtmlWidget(
                                            item.title ?? "",
                                            customStylesBuilder: (element) {
                                              if (element.className == "text-notification-bold") {
                                                return {'color': 'black', 'font-weight': 'bold'};
                                              }
                                              return null;
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(item.createdAt ?? ""),
                                      ],
                                    )
                                  ],
                                )
                              ]),
                            ),
                          );
                        }),
                  ),
                  reload: () {
                    context.read<NotificationCubit>().onRefesPage(refreshControllerNotifi);
                  });
            },
          ),
          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              // print(state.apiRequestStatusUnread);
              return BodyBuilder(
                  apiRequestStatus: state.apiRequestStatusUnread,
                  child: SmartRefresher(
                    controller: refreshControllerNotifiUnread,
                    onLoading: () =>
                        context.read<NotificationCubit>().onLoadingPageUnread(refreshControllerNotifiUnread),
                    onRefresh: () => context.read<NotificationCubit>().onRefesPageUnread(refreshControllerNotifiUnread),
                    enablePullDown: true,
                    enablePullUp: state.enablePullUnread,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.notificationUnread.length,
                        itemBuilder: (ctx, i) {
                          final item = state.notificationUnread[i];
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<NotificationCubit>()
                                  .onTapNotifi(item.type ?? "", item.slug ?? "", item.id ?? "");
                            },
                            child: Container(
                              // height: 100,
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                  color: item.readAt != null ? Colors.white : Colors.grey.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  boxShadow: item.readAt != null ? boxShadow : null),
                              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.grey.withOpacity(0.2),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                                    child: item.type == "announcements" || item.type == "lunch_menus"
                                        ? SvgPicture.asset(
                                            R.ASSETS_SVG_LOGOAMAI_SVG,
                                            width: 32,
                                            height: 32,
                                          )
                                        : AppNetworkImage(
                                            source: item.userAvatar ??
                                                "https://internal.amaisoft.com/assets/image_default.492cb8ad.svg",
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width - 120,
                                      child: Row(
                                        children: [
                                          Flexible(
                                              child: HtmlWidget(
                                            item.title ?? "",
                                            customStylesBuilder: (element) {
                                              if (element.className == "text-notification-bold") {
                                                return {'color': 'black', 'font-weight': 'bold'};
                                              }
                                              return null;
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(item.createdAt ?? ""),
                                      ],
                                    )
                                  ],
                                )
                              ]),
                            ),
                          );
                        }),
                  ),
                  reload: () {
                    context.read<NotificationCubit>().onRefesPageUnread(refreshControllerNotifiUnread);
                  });
            },
          ),
        ]),
      ),
    );
  }
}
