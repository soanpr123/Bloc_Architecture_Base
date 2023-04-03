import 'package:app/ui/blogs_detail_page/widget/hightlight_code.dart';
import 'package:app/ui/blogs_detail_page/widget/item_comment.dart';
import 'package:domain/domain.dart';
import 'package:domain/src/entity/coment_data_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../shared_view/app_netword_image.dart';

class BlogsDetailPage extends StatefulWidget {
  const BlogsDetailPage({required this.slungs, Key? key}) : super(key: key);
  final String slungs;
  @override
  _BlogsDetailPageState createState() => _BlogsDetailPageState();
}

class _BlogsDetailPageState extends BasePageState<BlogsDetailPage, BlogsDetailBloc> {
  GlobalKey _textKey = GlobalKey();

  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    bloc.add(BlogsDetailPageInitiated(slungs: widget.slungs));

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= 400) {
          bloc.add(const BlogsPageShowBack(show: true)); // show the back-to-top button
        } else {
          bloc.add(const BlogsPageShowBack(show: false)); // hide the back-to-top button
        }
        bloc.add(Hidebotom(offset: _scrollController.offset, bottom: bloc.state.bottom, padding: bloc.state.padding));
      });
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        text: S.current.detailBlogs,
        centerTitle: true,
        corlorText: Colors.white,
        leadingIcon: const BackButton(color: Colors.white),
        backgroundColor: colorSupportInfo,
        elevation: 1,
        // height: MediaQuery.of(context).padding.top + Dimens.d60.responsive(),
      ),
      body: BlocBuilder<BlogsDetailBloc, BlogsDetailState>(
        buildWhen: (previous, current) =>
            previous.users != current.users || previous.apiRequestStatus != current.apiRequestStatus,
        builder: (context, state) {
          return SafeArea(
            bottom: false,
            child: BodyBuilder(
              apiRequestStatus: state.apiRequestStatus,
              image: Assets.png.noData.image(
                width: Dimens.d265.responsive(),
                height: Dimens.d200.responsive(),
                fit: BoxFit.contain,
              ),
              reload: () {
                bloc.add(BlogsDetailPageInitiated(slungs: widget.slungs));
              },
              child: Stack(
                children: [
                  SingleChildScrollView(
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
                                state.users.title ?? '',
                                style: typoInterNomal18.copyWith(
                                  fontSize: Dimens.d18.responsive(),
                                  height: 1.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: Dimens.d12.responsive()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  state.users.createdAt != ''
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month_outlined,
                                              size: Dimens.d16.responsive(),
                                            ),
                                            SizedBox(width: Dimens.d8.responsive()),
                                            Text(
                                              state.users.createdAt ?? '',
                                              style: typoInterNomal14.copyWith(color: colorTextMedium, height: 1.5),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  state.users.createdAt != ''
                                      ? Row(
                                          children: [
                                            Assets.svg.eyeLine
                                                .svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
                                            SizedBox(width: Dimens.d6.responsive()),
                                            Text(
                                              '${state.users.totalViewed ?? 0}',
                                              style: typoInterNomal14.copyWith(color: colorTextMedium, height: 1.5),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimens.d8.responsive()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive()),
                          child: AppNetworkImage(
                            source: state.users.url ?? '',
                          ),
                        ),
                        SizedBox(height: Dimens.d8.responsive()),
                        Markdown(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          data: state.users.content ?? '',
                          selectable: true,
                          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                            p: typoInterNomal14.copyWith(height: 1.5),
                            a: typoInterNomal14.copyWith(
                              color: colorBrandPrimary,
                            ),
                          ),
                          onTapLink: (text, href, title) {
                            IntentUtils.openBrowserURL(url: href ?? '', inApp: false);
                          },
                          builders: {
                            'code': CodeElementBuilder(),
                          },
                        ),
                        state.users.tags != null
                            // ? AlignedGridView.count(
                            //     padding: EdgeInsets.zero,
                            //     itemCount: state.users.tags!.length,
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     crossAxisCount: 3,
                            //     crossAxisSpacing: 8,
                            //     mainAxisSpacing: 16,
                            //     shrinkWrap: true,
                            //     clipBehavior: Clip.antiAlias,
                            //     itemBuilder: (ctx, i) {
                            //       final item = state.users.tags![i];

                            //       return Container(
                            //         padding: EdgeInsets.symmetric(
                            //           horizontal: Dimens.d16.responsive(),
                            //           vertical: Dimens.d4.responsive(),
                            //         ),
                            //         decoration: BoxDecoration(
                            //           color: colorUiBg04,
                            //           borderRadius: const BorderRadius.all(
                            //             Radius.circular(40),
                            //           ),
                            //         ),
                            //         child: Center(
                            //           child: Text(
                            //             '#${item.name ?? ''}',
                            //             maxLines: 1,
                            //             style: typoInterNomal14.copyWith(color: colorTextMedium),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   )
                            // : Container(),
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: state.users.tags!
                                      .map((e) => InkWell(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(40),
                                            ),
                                            overlayColor: MaterialStateProperty.all(colorDisabled),
                                            onTap: () {
                                              navigator.popUntilRoot(useRootNavigator: true);
                                              navigator.push(AppRouteInfo.listBlogsPage('#${e.name}'));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimens.d16.responsive(),
                                                vertical: Dimens.d4.responsive(),
                                              ),
                                              decoration: BoxDecoration(
                                                color: colorUiBg04,
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(40),
                                                ),
                                              ),
                                              child: Text(
                                                '#${e.name ?? ''}',
                                                style: typoInterNomal14.copyWith(color: colorTextMedium),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bình luận (${state.users.totalComments})',
                                key: _textKey,
                                style: typoInterNomal16.copyWith(
                                    color: colorTextDark, height: 1.5, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: Dimens.d12.responsive()),
                              BlocBuilder<BlogsDetailBloc, BlogsDetailState>(
                                buildWhen: (previous, current) => previous.comment != current.comment,
                                builder: (context, comentstate) {
                                  return ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: comentstate.comment.length,
                                    itemBuilder: (ctx, i) {
                                      final cmt = comentstate.comment[i];

                                      return ItemComent(
                                        cmt: cmt,
                                        bloc: bloc,
                                        slungs: widget.slungs,
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<BlogsDetailBloc, BlogsDetailState>(
                    buildWhen: (previous, current) =>
                        previous.bottom != current.bottom ||
                        previous.totalAmaiVotes != current.totalAmaiVotes ||
                        previous.totalLikes != current.totalLikes ||
                        previous.isLiked != current.isLiked ||
                        previous.isAmaiVotes != current.isAmaiVotes ||
                        previous.likeStatus != current.likeStatus ||
                        previous.sendAmaiStatus != current.sendAmaiStatus,
                    builder: (context, stateb) {
                      return AnimatedPositioned(
                        duration: const Duration(milliseconds: 100),
                        left: 0,
                        right: 0,
                        bottom: stateb.bottom,
                        child: Container(
                          height: Dimens.d64.responsive(),
                          padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive()),
                          decoration: BoxDecoration(boxShadow: boxShadow, color: Colors.white),
                          child: Row(children: [
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(stateb.isLiked == 1 ? colorRed200 : Colors.white),
                                  overlayColor: MaterialStateProperty.all(colorRed200),
                                ),
                                onPressed: () {
                                  bloc.add(LikeBlogs(slungs: widget.slungs));
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        stateb.likeStatus == APIRequestStatus.loading
                                            ? Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: SizedBox(
                                                  height: 12,
                                                  width: 12,
                                                  child: CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                      colorRed500,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(
                                                height: 0,
                                              ),
                                      ],
                                    ),
                                    // Column(
                                    //   children: [
                                    //     stateb.likeStatus == APIRequestStatus.loading
                                    //         ? SizedBox(
                                    //             width: Dimens.d8.responsive(),
                                    //           )
                                    //         : Container(),
                                    //   ],
                                    // ),
                                    Assets.svg.heartBlack.svg(
                                      width: Dimens.d20.responsive(),
                                      height: Dimens.d20.responsive(),
                                      color: stateb.isLiked == 1 ? colorRed500 : colorGray600,
                                    ),
                                    SizedBox(
                                      width: Dimens.d8.responsive(),
                                    ),
                                    Text(
                                      '${stateb.totalLikes}',
                                      style: typoInterNomal14.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: stateb.isLiked == 1 ? colorRed500 : colorTextMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimens.d8.responsive(),
                            ),
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    stateb.isAmaiVotes == 1 ? colorUiBg03 : Colors.white,
                                  ),
                                  overlayColor: MaterialStateProperty.all(colorUiBg03),
                                ),
                                onPressed: () {
                                  if (stateb.isAmaiVotes == 0) {
                                    navigator.showDialog(AppPopupInfo.dialogConfirmComon(
                                      title: S.current.send_amai,
                                      message: S.current.send_amai_title,
                                      titleButton: 'Tặng',
                                      onPress: () {
                                        bloc.add(SendAmai(slungs: widget.slungs));
                                      },
                                    ));
                                  }
                                },
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Assets.svg.logoamai.svg(
                                    width: Dimens.d20.responsive(),
                                    height: Dimens.d20.responsive(),
                                    color: stateb.isAmaiVotes == 1 ? colorBrandPrimary : colorGray600,
                                  ),
                                  SizedBox(
                                    width: Dimens.d8.responsive(),
                                  ),
                                  Text(
                                    '${stateb.totalAmaiVotes}',
                                    style: typoInterNomal14.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: stateb.isAmaiVotes == 1 ? colorBrandPrimary : colorTextMedium,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            SizedBox(
                              width: Dimens.d8.responsive(),
                            ),
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.white,
                                  ),
                                  overlayColor: MaterialStateProperty.all(colorUiBg03),
                                ),
                                onPressed: () {
                                  final RenderBox renderBox = _textKey.currentContext?.findRenderObject() as RenderBox;

                                  final textPosition = renderBox.localToGlobal(Offset.zero);
                                  final double appBarHeight = AppBar().preferredSize.height + 50;
                                  final double statusBarHeight = MediaQuery.of(context).padding.top;
                                  // _scrollController.animateTo(offset - appBarHeight - statusBarHeight,
                                  //     duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                                  if (textPosition != null) {
                                    _scrollController.animateTo(
                                      textPosition.dy - appBarHeight - statusBarHeight,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  }

                                  // _scrollController.animateTo(
                                  //   _scrollController.position.maxScrollExtent,
                                  //   duration: const Duration(milliseconds: 500),
                                  //   curve: Curves.fastOutSlowIn,
                                  // );
                                },
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Assets.svg.chat.svg(
                                    width: Dimens.d20.responsive(),
                                    height: Dimens.d20.responsive(),
                                    color: colorGray600,
                                  ),
                                  SizedBox(
                                    width: Dimens.d8.responsive(),
                                  ),
                                  Text(
                                    '${stateb.users.totalComments}',
                                    style: typoInterNomal14.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colorTextMedium,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<BlogsDetailBloc, BlogsDetailState>(
                    buildWhen: (previous, current) =>
                        previous.show != current.show || previous.padding != current.padding,
                    builder: (context, statef) {
                      return statef.show
                          ? AnimatedPositioned(
                              duration: const Duration(milliseconds: 100),
                              right: 16,
                              bottom: statef.padding + 16,
                              child: GestureDetector(
                                onTap: () {
                                  _scrollController.animateTo(0,
                                      duration: const Duration(milliseconds: 500), curve: Curves.linear);
                                },
                                child: Container(
                                  width: Dimens.d40.responsive(),
                                  height: Dimens.d40.responsive(),
                                  decoration: BoxDecoration(
                                    color: colorBrandPrimary,
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: const Icon(Icons.arrow_upward, color: Colors.white),
                                ),
                              ),
                            )
                          : Container();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
