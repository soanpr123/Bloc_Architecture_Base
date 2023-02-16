import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:project/component/app_netword_image.dart';
import 'package:project/component/build_body.dart';
import 'package:project/core/style/app_style.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/notification_page/cubit/notification_cubit.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: const BackButton(
            color: Colors.black,
          ),
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
              onTap: (v) {
                print(v);
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
        body: BlocProvider(
          create: (context) => NotificationCubit()..requestNotification(),
          child: TabBarView(controller: tabController, children: [
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                return BodyBuilder(
                    apiRequestStatus: state.apiRequestStatus,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.notification.length,
                        itemBuilder: (ctx, i) {
                          final item = state.notification[i];
                          return Container(
                            // height: 100,
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                boxShadow: boxShadow),
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              const CircleAvatar(
                                radius: 24,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(24)),
                                  child: AppNetworkImage(
                                    source:
                                        "https://internal-api.amaisoft.com/storage/upload/thumbnails/a959899640085e3755f9bd09a0e07d5a.webp",
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
                          );
                        }),
                    reload: () {
                      context.read<NotificationCubit>().requestNotification();
                    });
              },
            ),
            Container()
          ]),
        ));
  }
}
