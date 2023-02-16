import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:project/component/build_body.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/features/announcement_detail/cubit/announcement_detail_cubit.dart';
import 'package:project/features/home_page/cubit/home_page_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementDetailPage extends StatelessWidget {
  final String? slug;
  final String? useCase;
  final bloc = getIt<HomePageCubit>();
  AnnouncementDetailPage({Key? key, @PathParam('slugs') this.slug, this.useCase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnnouncementDetailCubit()..requestReadAnnouncement(slug ?? "", context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: BackButton(
            color: Colors.black,
            onPressed: () async {
              if (useCase == "home") {
                bloc.requestNotifycationLocal(page: 1, perpage: 5);
                if (context.mounted) context.router.pop();
              } else {
                bloc.requestNotifycationLocal(page: 1, perpage: 5);

                if (context.mounted) context.router.pop(true);
              }
            },
          ),
          elevation: 1,
          title: Text(
            translation(context).notifycation_local,
            style: typoInterNomal18,
          ),
        ),
        body: BlocBuilder<AnnouncementDetailCubit, AnnouncementDetailState>(
          builder: (context, state) {
            return BodyBuilder(
                apiRequestStatus: state.apiRequestStatus,
                child: Markdown(
                  data: state.dataDetail.content ?? "",
                  selectable: true,
                  onTapLink: (text, href, title) {
                    print(href);
                    launchUrl(Uri.parse(href ?? ""), mode: LaunchMode.externalApplication);
                  },
                ),
                reload: () {
                  context.read<AnnouncementDetailCubit>().requestReadAnnouncement(slug ?? "", context);
                });
          },
        ),
      ),
    );
  }
}
