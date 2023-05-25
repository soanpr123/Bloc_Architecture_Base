import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../shared_view/app_netword_image.dart';
import 'widget/hightlight_code.dart';
import 'widget/item_comment.dart';

@RoutePage()
class BlogsDetailPage extends StatefulWidget {
  const BlogsDetailPage({required this.slungs, Key? key}) : super(key: key);
  final String slungs;
  @override
  _BlogsDetailPageState createState() => _BlogsDetailPageState();
}

class _BlogsDetailPageState extends BasePageState<BlogsDetailPage, BlogsDetailBloc> {
  final GlobalKey _textKey = GlobalKey();
  FocusNode _focus = FocusNode();

  late ScrollController _scrollController;
  final textComentEditor = TextEditingController();
  @override
  void initState() {
    super.initState();

    bloc.add(BlogsDetailPageInitiated(slungs: widget.slungs));
    _focus.addListener(_onFocusChange);
    _scrollController = ScrollController()
      ..addListener(() {
        // if (_focus.hasFocus) {
        //   ViewUtils.hideKeyboard(context);
        // }
        if (_scrollController.offset >= 400) {
          bloc.add(const BlogsPageShowBack(show: true)); // show the back-to-top button
        } else {
          bloc.add(const BlogsPageShowBack(show: false)); // hide the back-to-top button
        }
        bloc.add(Hidebotom(offset: _scrollController.offset, bottom: bloc.state.bottom, padding: bloc.state.padding));
      });
  }

  void _onFocusChange() {
    bloc.add(ForcusComment(isComment: _focus.hasFocus));
    // if (_focus.hasFocus) {
    //   Scrollable.ensureVisible(
    //     _textKey.currentContext!,
    //     duration: const Duration(milliseconds: 500),
    //     curve: Curves.easeInOut,
    //   );
    // }
    // debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return BlocListener<BlogsDetailBloc, BlogsDetailState>(
      listenWhen: (previous, current) => previous.isComment != current.isComment,
      listener: (context, state) {
        if (state.isComment && !_focus.hasFocus) {
          _focus.requestFocus();
        }
      },
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
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
                    physics: const ClampingScrollPhysics(),
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
                            blockquoteDecoration: BoxDecoration(
                              color: colorAmber100,
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
                        previous.show != current.show || previous.padding != current.padding,
                    builder: (context, statef) {
                      return statef.show
                          ? AnimatedPositioned(
                              duration: const Duration(milliseconds: 100),
                              right: 16,
                              bottom: 16,
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
                  BlocBuilder<BlogsDetailBloc, BlogsDetailState>(
                    buildWhen: (previous, current) =>
                        previous.bottom != current.bottom ||
                        previous.totalAmaiVotes != current.totalAmaiVotes ||
                        previous.totalLikes != current.totalLikes ||
                        previous.isLiked != current.isLiked ||
                        previous.isAmaiVotes != current.isAmaiVotes ||
                        previous.likeStatus != current.likeStatus ||
                        previous.sendAmaiStatus != current.sendAmaiStatus ||
                        previous.cmtSelect != current.cmtSelect ||
                        previous.name != current.name ||
                        previous.buttonSendState != current.buttonSendState ||
                        previous.isComment != current.isComment,
                    builder: (context, stateb) {
                      return AnimatedPositioned(
                        duration: const Duration(milliseconds: 100),
                        left: 0,
                        right: 0,
                        bottom: stateb.isComment ? 0 : stateb.bottom,
                        child: Container(
                          // height: Dimens.d64.responsive(),
                          // height: stateb.bottom,
                          // duration: const Duration(milliseconds: 100),
                          // margin: EdgeInsets.only(top: 50),
                          padding: EdgeInsets.fromLTRB(
                            Dimens.d16.responsive(),
                            Dimens.d12.responsive(),
                            Dimens.d16.responsive(),
                            Dimens.d12.responsive(),
                          ),
                          decoration: BoxDecoration(boxShadow: boxShadow, color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // stateb.isComment
                              //     ? SizedBox(
                              //         height: Dimens.d12.responsive(),
                              //       )
                              //     : Container(),
                              stateb.cmtSelect != -1 && stateb.isComment
                                  ? RichText(
                                      text: TextSpan(
                                        text: 'Đang phản hồi ',
                                        style: typoInterNomal14.copyWith(
                                          color: colorTextMedium,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: stateb.name,
                                            style: typoInterNomal14.copyWith(
                                              fontWeight: FontWeight.w600,
                                              // fontSize: 16,
                                              color: colorTextDark,
                                              height: 1.5,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '・',
                                            style: typoInterNomal14.copyWith(
                                              fontWeight: FontWeight.w400,
                                              // fontSize: 12,
                                              color: colorTextMedium,
                                              height: 1.5,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Huỷ',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => bloc.add(const DeleteSelectCmt()),
                                            style: typoInterNomal14.copyWith(
                                              fontWeight: FontWeight.w600,
                                              // fontSize: 16,
                                              color: colorBrandPrimary,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              stateb.cmtSelect != -1
                                  ? SizedBox(
                                      height: Dimens.d8.responsive(),
                                    )
                                  : Container(),
                              stateb.isComment
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: Dimens.d12.responsive()),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              // cursorHeight: Dimens.d16.responsive(),
                                              focusNode: _focus,
                                              controller: textComentEditor,
                                              minLines: 1,
                                              maxLines: 5,
                                              textInputAction: TextInputAction.newline,
                                              keyboardType: TextInputType.multiline,
                                              style: typoInterNomal14.copyWith(
                                                fontSize: Dimens.d14.responsive(),
                                                fontWeight: FontWeight.w400,
                                                height: 1.5,
                                                color: colorTextDark,
                                              ),
                                              // strutStyle: const StrutStyle(
                                              //   forceStrutHeight:
                                              //       true, // Đảm bảo tất cả các dòng có chiều cao giống nhau
                                              //   // height: 1.5, // Khoảng cách giữa các dòng
                                              // ),
                                              onChanged: (v) {
                                                bloc.add(OnChangeCmt(cmt: v));
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.symmetric(
                                                  horizontal: Dimens.d8.responsive(),
                                                  vertical: Dimens.d8.responsive(),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: colorBrandPrimary),
                                                  borderRadius: BorderRadius.circular(
                                                    5,
                                                  ),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: colorBoder01,
                                                  ),
                                                  borderRadius: BorderRadius.circular(
                                                    5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimens.d12.responsive(),
                                          ),
                                          Container(
                                            height: Dimens.d45.responsive(),
                                            // color: colorGray800,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: stateb.buttonSendState == AppElevatedButtonState.inactive
                                                      ? null
                                                      : () {
                                                          if (stateb.cmtSelect == -1) {
                                                            bloc.add(
                                                              CreateComment(
                                                                slungs: widget.slungs,
                                                                comment: textComentEditor.text.trim(),
                                                                scrollController: _scrollController,
                                                                textEdt: textComentEditor,
                                                              ),
                                                            );
                                                          } else {
                                                            bloc.add(
                                                              RepplyComment(
                                                                id: stateb.cmtSelect.toString(),
                                                                slungs: widget.slungs,
                                                                content: textComentEditor.text.trim(),
                                                                textEdt: textComentEditor,
                                                              ),
                                                            );
                                                            bloc.add(
                                                              const DeleteSelectCmt(),
                                                            );
                                                          }
                                                          ViewUtils.hideKeyboard(context);
                                                        },
                                                  child: stateb.buttonSendState == AppElevatedButtonState.loading
                                                      ? Stack(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment.center,
                                                              child: SizedBox(
                                                                width: Dimens.d16.responsive(),
                                                                height: Dimens.d16.responsive(),
                                                                child: CircularProgressIndicator(
                                                                  strokeWidth: 2.0,
                                                                  color: colorDisabled,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Assets.svg.send.svg(
                                                          color:
                                                              stateb.buttonSendState == AppElevatedButtonState.inactive
                                                                  ? colorDisabled
                                                                  : colorBrandPrimary,
                                                          width: Dimens.d20.responsive(),
                                                          height: Dimens.d20.responsive(),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),

                              Row(children: [
                                Expanded(
                                  child: TextButton(
                                    style: ButtonStyle(
                                      // backgroundColor:
                                      //     MaterialStateProperty.all(stateb.isLiked == 1 ? colorRed200 : Colors.white),
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
                                                        strokeWidth: 2.0,
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
                                      // backgroundColor: MaterialStateProperty.all(
                                      //   stateb.isAmaiVotes == 1 ? colorUiBg03 : Colors.white,
                                      // ),
                                      overlayColor: MaterialStateProperty.all(colorUiBg03),
                                    ),
                                    onPressed: () {
                                      if (stateb.isAmaiVotes == 0) {
                                        navigator.showDialog(AppPopupInfo.dialogConfirmComon(
                                          title: S.current.send_amai_warning,
                                          message: S.current.send_amai_title,
                                          titleButton: 'Tặng',
                                          onPress: () {
                                            bloc.add(SendAmai(slungs: widget.slungs));
                                          },
                                        ));
                                      }
                                    },
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          stateb.sendAmaiStatus == APIRequestStatus.loading
                                              ? Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: SizedBox(
                                                    height: 12,
                                                    width: 12,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2.0,
                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                        colorBrandPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(
                                                  height: 0,
                                                ),
                                        ],
                                      ),
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
                                        stateb.isComment ? colorUiBg03 : Colors.white,
                                      ),
                                      overlayColor: MaterialStateProperty.all(colorUiBg03),
                                    ),
                                    onPressed: () async {
                                      bloc.add(const ForcusComment(isComment: true));
                                      final RenderBox renderBox =
                                          _textKey.currentContext?.findRenderObject() as RenderBox;

                                      // _scrollController.animateTo(offset - appBarHeight - statusBarHeight,
                                      //     duration: Duration(milliseconds: 500), curve: Curves.easeInOut);

                                      await Scrollable.ensureVisible(
                                        _textKey.currentContext!,
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                      // if (!_focus.hasFocus) {
                                      //   _focus.requestFocus();
                                      // }
                                      // await _scrollController.animateTo(
                                      //   textPosition.dy - appBarHeight - statusBarHeight,
                                      //   duration: const Duration(milliseconds: 500),
                                      //   curve: Curves.easeInOut,
                                      // );

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
                                        color: stateb.isComment ? colorBrandPrimary : colorGray600,
                                      ),
                                      SizedBox(
                                        width: Dimens.d8.responsive(),
                                      ),
                                      Text(
                                        '${stateb.users.totalComments}',
                                        style: typoInterNomal14.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: stateb.isComment ? colorBrandPrimary : colorTextMedium,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      );
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
