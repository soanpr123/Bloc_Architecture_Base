import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/component/build_body.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/routers/router.dart';
import 'package:project/core/style/app_style.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/features/announcement/cubit/announcement_cubit.dart';
import 'package:project/features/home_page/cubit/home_page_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final bloc = getIt<HomePageCubit>();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
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
          translation(context).notifycation_local,
          style: typoInterNomal18,
        ),
      ),
      body: BlocProvider(
        create: (context) => AnnouncementCubit()..requestNotifycationLocal(page: 1, perpage: 15),
        child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
          builder: (context, state) {
            return BodyBuilder(
                apiRequestStatus: state.notifyCationLocalStatus,
                child: SmartRefresher(
                  controller: refreshController,
                  onLoading: () => context.read<AnnouncementCubit>().onLoadingPage(refreshController),
                  onRefresh: () => context.read<AnnouncementCubit>().onRefesPage(refreshController),
                  enablePullDown: true,
                  enablePullUp: state.enablePull,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.announcementData.length,
                      itemBuilder: (ctx, i) {
                        final e = state.announcementData[i];
                        // print(e.title);
                        return GestureDetector(
                          onTap: () async {
                            final r =
                                await context.router.push(AnnouncementDetailRoute(slug: e.slug, useCase: "announPage"));
                            if (r == true) {
                              if (context.mounted) context.read<AnnouncementCubit>().onRefesPage(refreshController);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                boxShadow: boxShadow),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.title ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: typoInterNomal16.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(e.createdAt ?? ""),
                                    ],
                                  )
                                ]),
                          ),
                        );
                      }),
                ),
                reload: () {
                  bloc.requestNotifycationLocal(page: 1, perpage: 15);
                });
          },
        ),
      ),
    );
  }
}
