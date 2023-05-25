import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badges;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import '../../shared_view/app_netword_image.dart';
import '../../shared_view/loading_widget.dart';
import '../../utils/max_word_text_input.dart';

@RoutePage()
class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends BasePageState<ReportPage, ReportPageBloc> {
  final _focus = FocusNode();
  final textEditingController = TextEditingController();
  int idKeyboardListener = 0;
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    bloc.add(const GetIssueReportPage());
    // idKeyboardListener = _keyboardUtils.add(
    //     listener: keyboard_listener.KeyboardListener(willHideKeyboard: () {
    //   print(_keyboardUtils.keyboardHeight);
    // }, willShowKeyboard: (double keyboardHeight) {
    //   print(keyboardHeight);
    // }));
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
  }

  void _onFocusChange() {
    print("Focus: ${_focus.hasFocus.toString()}");
    bloc.add(ChangeFocusInputText(focus: _focus.hasFocus));
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return BlocListener<ReportPageBloc, ReportPageState>(
      listener: (context, state) {
        if (state.closePopUp) {
          print("clear");
          textEditingController.clear();
          bloc.add(const ClosePopUp(closePopUp: false));
        }
      },
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(
        text: S.current.report,
        centerTitle: true,
        corlorText: Colors.white,
        backgroundColor: colorBrandPrimary,
        elevation: 1,
        leadingIcon: const BackButton(
          color: Colors.white,
        ),
        // height: MediaQuery.of(context).padding.top + Dimens.d60.responsive(),
      ),
      body: BlocBuilder<ReportPageBloc, ReportPageState>(
        buildWhen: (previous, current) => previous.loading != current.loading,
        builder: (context, state) {
          return BodyBuilder(
            apiRequestStatus: state.loading,
            image: Assets.png.noData.image(
              width: Dimens.d265.responsive(),
              height: Dimens.d200.responsive(),
              fit: BoxFit.contain,
            ),
            reload: () {
              bloc.add(const GetIssueReportPage());
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive(), vertical: Dimens.d16.responsive()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.png.communicationGap2.image(
                        width: 224,
                        height: 217,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    S.current.report_content,
                    textAlign: TextAlign.center,
                    style: typoInterNomal14.copyWith(fontWeight: FontWeight.w600, height: 1.5, color: colorTextMedium),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  RichText(
                    text: TextSpan(
                      text: S.current.report_lable_issure,
                      style:
                          typoInterNomal16.copyWith(color: colorTextMedium, fontWeight: FontWeight.w600, height: 1.5),
                      children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: typoInterNomal14.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: colorSupportDanger,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: state.issue
                        .map((e) => InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(40),
                              ),
                              overlayColor: MaterialStateProperty.all(colorUiBg03),
                              onTap: () {
                                bloc.add(SelectIssueReportPage(issueSelect: e));
                              },
                              child: BlocBuilder<ReportPageBloc, ReportPageState>(
                                buildWhen: (previous, current) {
                                  return previous.issueSelect.length != current.issueSelect.length;
                                },
                                builder: (context, statei) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimens.d16.responsive(),
                                      vertical: Dimens.d8.responsive(),
                                    ),
                                    decoration: BoxDecoration(
                                      color: statei.issueSelect.where((element) => element.id == e.id).isNotEmpty
                                          ? colorUiBg03
                                          : Colors.white,
                                      border: Border.all(
                                        color: statei.issueSelect.where((element) => element.id == e.id).isNotEmpty
                                            ? colorHoverPrimary
                                            : colorUiBg01,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                    child: Text(
                                      e.name ?? '',
                                      textAlign: TextAlign.justify,
                                      style: typoInterNomal14.copyWith(
                                        color: statei.issueSelect.where((element) => element.id == e.id).isNotEmpty
                                            ? colorHoverPrimary
                                            : colorTextMedium,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  RichText(
                    text: TextSpan(
                      text: S.current.report_lable_content,
                      style: typoInterNomal16.copyWith(color: colorTextMedium, fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: typoInterNomal14.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: colorSupportDanger,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  BlocBuilder<ReportPageBloc, ReportPageState>(
                    buildWhen: (previous, current) => previous.focusInput != current.focusInput,
                    builder: (context, stateC) {
                      return TextField(
                        focusNode: _focus,
                        controller: textEditingController,
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                        style: typoInterNomal14.copyWith(
                          fontSize: Dimens.d14.responsive(),
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: colorTextDark,
                        ),
                        strutStyle: const StrutStyle(
                          forceStrutHeight: true, // Đảm bảo tất cả các dòng có chiều cao giống nhau
                          height: 1.5, // Khoảng cách giữa các dòng
                        ),
                        onChanged: (v) {
                          bloc.add(InputChange(input: v));
                        },
                        inputFormatters: [
                          MaxWordTextInputFormater(
                            maxWords: 300,
                            currentLength: (v) {
                              // bloc.add(ChangeCount(count: v));
                            },
                          ),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  BlocBuilder<ReportPageBloc, ReportPageState>(
                    buildWhen: (previous, current) =>
                        previous.loadingImage != current.loadingImage || previous.image.length != current.image.length,
                    builder: (context, stateimage) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: S.current.report_image,
                              style: typoInterNomal16.copyWith(color: colorTextMedium, fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' (${stateimage.image.length}/3)',
                                  style: typoInterNomal14.copyWith(color: colorTextBland, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            overlayColor: MaterialStateProperty.all(colorDisabled),
                            onTap: stateimage.image.length == 3 || stateimage.loadingImage == APIRequestStatus.loading
                                ? null
                                : () {
                                    bloc.add(const PickImage());
                                  },
                            child: SizedBox(
                              height: Dimens.d40.responsive(),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.butt,
                                dashPattern: [8, 4],
                                color:
                                    stateimage.image.length == 3 || stateimage.loadingImage == APIRequestStatus.loading
                                        ? colorDisabled
                                        : colorUiBg02,
                                radius: const Radius.circular(5),
                                padding: const EdgeInsets.all(12),
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  stateimage.loadingImage == APIRequestStatus.loading
                                      ? SizedBox(
                                          height: Dimens.d12.responsive(),
                                          width: Dimens.d12.responsive(),
                                          child: CircularProgressIndicator(
                                            color: colorBrandPrimary,
                                            strokeWidth: 2.0,
                                          ),
                                        )
                                      : Assets.svg.uploadCloud.svg(
                                          color: stateimage.image.length == 3 ||
                                                  stateimage.loadingImage == APIRequestStatus.loading
                                              ? colorDisabled
                                              : colorBrandPrimary),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    S.current.report_upload,
                                    style: typoInterNomal14.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: stateimage.image.length == 3 ||
                                              stateimage.loadingImage == APIRequestStatus.loading
                                          ? colorDisabled
                                          : colorBrandPrimary,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          stateimage.loadingImage != APIRequestStatus.loading && stateimage.image.isEmpty
                              ? Container()
                              : Container(
                                  height: Dimens.d120.responsive(),
                                  width: double.infinity,
                                  padding: EdgeInsets.only(top: Dimens.d24.responsive()),
                                  // child: Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Flexible(
                                  //       fit: FlexFit.loose,
                                  //       child: ListView.builder(
                                  //         padding: const EdgeInsets.all(0),
                                  //         itemCount: stateimage.image.length,
                                  //         shrinkWrap: true,
                                  //         scrollDirection: Axis.horizontal,
                                  //         clipBehavior: Clip.none,
                                  //         // physics: const NeverScrollableScrollPhysics(),
                                  //         itemBuilder: (ctx, i) {
                                  //           return Row(
                                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               SizedBox(
                                  //                 width: i == 0 ? 0 : Dimens.d4.responsive(),
                                  //               ),
                                  //               SizedBox(
                                  //                 width: Dimens.d110.responsive(),
                                  //                 height: Dimens.d110.responsive(),
                                  //                 child: Stack(
                                  //                   children: [
                                  //                     Container(
                                  //                       width: Dimens.d110.responsive(),
                                  //                       height: Dimens.d110.responsive(),
                                  //                       clipBehavior: Clip.antiAliasWithSaveLayer,
                                  //                       decoration: const BoxDecoration(
                                  //                         // color: Colors.amberAccent,
                                  //                         borderRadius: BorderRadius.all(Radius.circular(5)),
                                  //                       ),
                                  //                       child: ClipRRect(
                                  //                         borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  //                         child: AppNetworkImage(
                                  //                           source: stateimage.image[i].thumb,
                                  //                           fit: BoxFit.cover,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     Align(
                                  //                       alignment: Alignment.center,
                                  //                       child: GestureDetector(
                                  //                         onTap: () {
                                  //                           bloc.add(DeleteImage(index: i));
                                  //                         },
                                  //                         child: Container(
                                  //                           decoration: BoxDecoration(
                                  //                             borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  //                             color: colorBrandSecondary,
                                  //                           ),
                                  //                           height: Dimens.d24.responsive(),
                                  //                           width: Dimens.d24.responsive(),
                                  //                           child: Column(
                                  //                             mainAxisAlignment: MainAxisAlignment.center,
                                  //                             children: [Assets.svg.bin.svg()],
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           );
                                  //         },
                                  //       ),
                                  //     ),
                                  //     stateimage.loadingImage == APIRequestStatus.loading
                                  //         ? const LoadingWidget(
                                  //             isLoadingNew: false,
                                  //           )
                                  //         : Container(),
                                  //   ],
                                  // ),
                                  child: Row(
                                    mainAxisAlignment: stateimage.image.length < 3
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.spaceBetween,
                                    children: stateimage.image
                                        .map(
                                          (e) => Padding(
                                            padding: EdgeInsets.only(
                                                left: stateimage.image.length == 2 ? Dimens.d4.responsive() : 0),
                                            child: SizedBox(
                                              width: (MediaQuery.of(context).size.width - Dimens.d40.responsive()) / 3,
                                              height: Dimens.d110.responsive(),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context).size.width - Dimens.d40.responsive()) /
                                                            3,
                                                    height: Dimens.d110.responsive(),
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    decoration: const BoxDecoration(
                                                      // color: Colors.amberAccent,
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                      child: AppNetworkImage(
                                                        source: stateimage.image[stateimage.image.indexOf(e)].thumb,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        bloc.add(DeleteImage(index: stateimage.image.indexOf(e)));
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                          color: colorBrandSecondary,
                                                        ),
                                                        height: Dimens.d24.responsive(),
                                                        width: Dimens.d24.responsive(),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [Assets.svg.bin.svg()],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: Dimens.d15.responsive(),
                  ),
                  BlocBuilder<ReportPageBloc, ReportPageState>(
                    builder: (context, statebtn) {
                      return AppElevatedButton(
                        state: statebtn.buttonState,
                        buttonTitle: 'Báo lỗi',
                        onPressed: () {
                          bloc.add(const ButtonSubmit());
                        },
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
