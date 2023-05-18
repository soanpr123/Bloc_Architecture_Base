import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../blogs_detail_page/widget/hightlight_code.dart';
@RoutePage()
class AnnouncementDetailPage extends StatefulWidget {
  const AnnouncementDetailPage({required this.slungs, Key? key}) : super(key: key);
  final String slungs;
  @override
  _AnnouncementDetailPageState createState() => _AnnouncementDetailPageState();
}

class _AnnouncementDetailPageState extends BasePageState<AnnouncementDetailPage, AnouncementDetailBloc> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    bloc.add(AnouncementPageInitiated(slungs: widget.slungs));
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= 400) {
          bloc.add(const AnouncementPageShowBack(show: true)); // show the back-to-top button
        } else {
          bloc.add(const AnouncementPageShowBack(show: false)); // hide the back-to-top button
        }
      });
  }

  // bloc.add(AnouncementPageShowBack());
  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        text: S.current.notifycation_local,
        centerTitle: true,
        corlorText: Colors.white,
        leadingIcon: const BackButton(color: Colors.white),
        backgroundColor: colorBrandPrimary,
        elevation: 1,
        // height: MediaQuery.of(context).padding.top + Dimens.d60.responsive(),
      ),
      body: BlocBuilder<AnouncementDetailBloc, AnouncementDetailState>(
        buildWhen: (previous, current) =>
            previous.announcementDetail != current.announcementDetail ||
            previous.apiRequestStatus != current.apiRequestStatus,
        builder: (context, state) {
          return SafeArea(
            child: BodyBuilder(
              apiRequestStatus: state.apiRequestStatus,
              image: Assets.png.noData.image(
                width: Dimens.d265.responsive(),
                height: Dimens.d200.responsive(),
                fit: BoxFit.contain,
              ),
              reload: () {
                bloc.add(AnouncementPageInitiated(slungs: widget.slungs));
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Dimens.d8.responsive()),
                          Text(
                            state.announcementDetail.title ?? '',
                            style: typoInterNomal18.copyWith(
                              fontSize: Dimens.d18.responsive(),
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: Dimens.d12.responsive()),
                          state.announcementDetail.createdAt != ''
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: Dimens.d16.responsive(),
                                    ),
                                    SizedBox(width: Dimens.d8.responsive()),
                                    Text(
                                      state.announcementDetail.createdAt ?? '',
                                      style: typoInterNomal14.copyWith(color: colorTextMedium, height: 1.5),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimens.d8.responsive()),
                    Markdown(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      data: state.announcementDetail.content ?? '',
                      selectable: true,
                      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                        p: typoInterNomal14.copyWith(height: 1.5),
                        a: typoInterNomal14.copyWith(
                          color: colorBrandPrimary,
                        ),
                        blockquoteDecoration: BoxDecoration(
                          color: colorAmber100,
                        ),
                      ),
                      builders: {
                        'code': CodeElementBuilder(),
                      },
                      onTapLink: (text, href, title) {
                        IntentUtils.openBrowserURL(url: href ?? '', inApp: false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<AnouncementDetailBloc, AnouncementDetailState>(
        builder: (context, state) {
          return state.show
              ? GestureDetector(
                  onTap: () {
                    _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.linear);
                  },
                  child: Container(
                    width: Dimens.d40.responsive(),
                    height: Dimens.d40.responsive(),
                    decoration: BoxDecoration(
                      color: colorBrandPrimary,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }
}
