import 'package:domain/domain.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import '../../utils/max_word_text_input.dart';

class SendAmaiPage extends StatefulWidget {
  const SendAmaiPage({required this.userId, Key? key}) : super(key: key);
  final String userId;

  @override
  _SendAmaiPageState createState() => _SendAmaiPageState();
}

class _SendAmaiPageState extends BasePageState<SendAmaiPage, SendAmaiBloc> {
  final mes = {
    'Đi làm vì đam mê nhưng Amai là thực tế',
    'Quý bạn lắm á',
    'Vì bạn xứng đáng',
    'Tôi khó có bạn, bạn đói có tôi',
    'Amai khi đói bằng 1 gói khi no',
  };
  FocusNode _focus = FocusNode();
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    bloc.add(GetMemberSend(id: int.parse(widget.userId)));
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    print("Focus: ${_focus.hasFocus.toString()}");
    bloc.add(ChangeFocus(focus: _focus.hasFocus));
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        text: S.current.send_amai,
        centerTitle: true,
        corlorText: Colors.white,
        backgroundColor: colorRed500,
        elevation: 1,
        leadingIcon: const BackButton(color: Colors.white),
        // height: MediaQuery.of(context).padding.top + Dimens.d60.responsive(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: Dimens.d275.responsive(),
                      child: Assets.png.bgSendAmai.image(width: 375, height: 275, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        // the container is removed
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            S.current.send_content,
                            style: typoInterNomal14.copyWith(color: colorTextMedium, height: 1.5),
                          ),
                          SizedBox(
                            height: Dimens.d24.responsive(),
                          ),
                          RichText(
                            text: TextSpan(
                              text: S.current.user_send,
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
                          SizedBox(
                            height: Dimens.d4.responsive(),
                          ),
                          BlocBuilder<SendAmaiBloc, SendAmaiState>(
                            buildWhen: (previous, current) =>
                                previous.member != current.member ||
                                previous.selectedMember != current.selectedMember ||
                                previous.focusInput != current.focusInput ||
                                previous.errUser != current.errUser,
                            builder: (context, statem) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Dimens.d40.responsive(),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                S.current.user_send,
                                                style: typoInterNomal14.copyWith(color: colorTextBland, height: 1.5),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: statem.member
                                            .map((item) => DropdownMenuItem<DonationRecipientEntry>(
                                                  value: item,
                                                  child: Text(
                                                    item.name ?? '',
                                                    style: typoInterNomal14.copyWith(color: colorTextDark, height: 1.5),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: statem.selectedMember.id == -1 ? null : statem.selectedMember,
                                        onChanged: (value) {
                                          if (value != null) {
                                            bloc.add(SelectedMember(selectedMember: value));
                                          }
                                        },
                                        onMenuStateChange: (v) {
                                          bloc.add(ChangeFocusInput(focus: v));
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          padding: EdgeInsets.only(left: 0, right: 8, bottom: Dimens.d4.responsive()),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                              color: statem.focusInput
                                                  ? colorBrandPrimary
                                                  : statem.errUser != ''
                                                      ? colorSupportDanger
                                                      : colorBoder01,
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        iconStyleData: IconStyleData(
                                          icon: Padding(
                                            padding: EdgeInsets.only(top: Dimens.d4.responsive()),
                                            child: const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                            ),
                                          ),
                                          iconSize: 20,
                                          iconEnabledColor: colorGray600,
                                          iconDisabledColor: colorGray600,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          padding: null,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(40),
                                            thickness: MaterialStateProperty.all<double>(6),
                                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                                          ),
                                        ),
                                        menuItemStyleData: MenuItemStyleData(
                                          height: Dimens.d40.responsive(),
                                          padding: EdgeInsets.only(
                                            left: Dimens.d8.responsive(),
                                            right: Dimens.d8.responsive(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimens.d4.responsive(),
                                  ),
                                  Text(
                                    statem.errUser,
                                    style: typoInterNomal14.copyWith(
                                      fontSize: 12,
                                      height: 1.5,
                                      color: colorSupportDanger,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: Dimens.d24.responsive(),
                          ),
                          RichText(
                            text: TextSpan(
                              text: S.current.amai_number,
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
                          SizedBox(
                            height: Dimens.d4.responsive(),
                          ),
                          BlocBuilder<SendAmaiBloc, SendAmaiState>(
                            buildWhen: (previous, current) => previous.amaiCount != current.amaiCount,
                            builder: (context, stateAmai) {
                              return Column(
                                children: [
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 8,
                                    children: List.generate(
                                      3,
                                      (i) => GestureDetector(
                                        onTap: () => bloc.add(SelectAmai(
                                          index: i,
                                          amaiCount: i == 0
                                              ? 1
                                              : i == 1
                                                  ? 2
                                                  : 3,
                                        )),
                                        child: amaiNumber(
                                          numberAmai: i == 0
                                              ? 1
                                              : i == 1
                                                  ? 2
                                                  : 3,
                                          selected: i == stateAmai.index ? true : false,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimens.d4.responsive(),
                                  ),
                                  Text(
                                    stateAmai.errAmai,
                                    style: typoInterNomal14.copyWith(
                                      fontSize: 12,
                                      height: 1.5,
                                      color: colorSupportDanger,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: Dimens.d4.responsive(),
                          ),
                          RichText(
                            text: TextSpan(
                              text: S.current.message,
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
                          SizedBox(
                            height: Dimens.d4.responsive(),
                          ),
                          BlocBuilder<SendAmaiBloc, SendAmaiState>(
                            buildWhen: (previous, current) =>
                                previous.controller != current.controller ||
                                previous.focus != current.focus ||
                                previous.errSend != current.errSend,
                            builder: (context, stateC) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: stateC.focus
                                            ? colorBrandPrimary
                                            : stateC.errSend != ''
                                                ? colorSupportDanger
                                                : colorBoder01,
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: TextField(
                                      controller: _controller,
                                      focusNode: _focus,
                                      maxLines: 4,
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
                                            bloc.add(ChangeCount(count: v));
                                          },
                                        ),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                                        counter: BlocBuilder<SendAmaiBloc, SendAmaiState>(
                                          buildWhen: (previous, current) =>
                                              previous.count != current.count ||
                                              previous.controller != current.controller,
                                          builder: (context, stater) {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    style:
                                                        typoInterNomal14.copyWith(color: colorTextBland, fontSize: 12),
                                                    children: [
                                                      const TextSpan(text: '('),
                                                      TextSpan(
                                                        text: stater.count.toString(),
                                                        style: typoInterNomal14.copyWith(
                                                            color: colorTextBland, fontSize: 12),
                                                      ),
                                                      const TextSpan(
                                                        text: '/300)',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimens.d4.responsive(),
                                  ),
                                  Text(
                                    stateC.errSend,
                                    style: typoInterNomal14.copyWith(
                                      fontSize: 12,
                                      height: 1.5,
                                      color: colorSupportDanger,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: Dimens.d24.responsive(),
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: mes
                                .map((e) => InkWell(
                                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                                      overlayColor: MaterialStateProperty.all(colorDisabled),
                                      onTap: () {
                                        _controller.text = '$e. ';

                                        _controller.selection =
                                            TextSelection.fromPosition(TextPosition(offset: '$e. '.length));
                                        bloc.add(ChangeCount(count: '$e. '.length));
                                        bloc.add(InputChange(input: _controller.text));
                                        bloc.add(SelectContent(controller: _controller));
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
                                          e.toString(),
                                          style: typoInterNomal14.copyWith(color: colorTextMedium, height: 1.5),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          Padding(
                            // this is new
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                Dimens.d16.responsive(),
                Dimens.d16.responsive(),
                Dimens.d16.responsive(),
                Dimens.d24.responsive(),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: boxShadow,
              ),
              child: BlocBuilder<SendAmaiBloc, SendAmaiState>(
                buildWhen: (previous, current) =>
                    previous.privateStatus != current.privateStatus ||
                    previous.publicStatus != current.publicStatus ||
                    previous.errAmai != current.errAmai ||
                    previous.errSend != current.errSend ||
                    previous.errUser != current.errUser,
                builder: (context, stateB) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: Dimens.d40.responsive(),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              color: stateB.privateStatus == APIRequestStatus.error ? colorDisabled : colorBrandPrimary,
                            ),
                          ),
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(colorDisabled),
                            ),
                            onPressed: stateB.privateStatus == APIRequestStatus.error
                                ? null
                                : () {
                                    navigator.showDialog(AppPopupInfo.dialogConfirmComon(
                                      message: S.current.send_amai_private,
                                      title: S.current.send_amai_private_content,
                                      titleButton: 'Tặng',
                                      onPress: () {
                                        if (stateB.errAmai == '') {
                                          bloc.add(DonateButton(type: 2, id: int.parse(widget.userId)));
                                        }
                                      },
                                    ));
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: stateB.privateStatus == APIRequestStatus.loading ? 16.0 : 0.0,
                                  width: stateB.privateStatus == APIRequestStatus.loading ? 16.0 : 0.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).disabledColor,
                                    ),
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: stateB.privateStatus == APIRequestStatus.loading ? 8.0 : 0.0,
                                ),
                                Text(
                                  S.current.send_private,
                                  style: typoInterNomal14.copyWith(
                                    color: stateB.privateStatus == APIRequestStatus.error
                                        ? colorDisabled
                                        : colorBrandPrimary,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Dimens.d12.responsive(),
                      ),
                      Expanded(
                        child: AppElevatedButton(
                          state: stateB.publicStatus,
                          buttonTitle: S.current.send_public,
                          onPressed: () {
                            if (stateB.errAmai == '') {
                              bloc.add(DonateButton(type: 1, id: int.parse(widget.userId)));
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget amaiNumber({int numberAmai = 1, bool selected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive(), vertical: Dimens.d10.responsive()),
      decoration: BoxDecoration(
        color: selected ? colorUiBg03 : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: selected ? colorBrandPrimary : colorBoder01),
      ),
      child: Wrap(
        children: List.generate(
          numberAmai,
          (index) => Assets.svg.logoamai.svg(
            width: Dimens.d20.responsive(),
            height: Dimens.d20.responsive(),
            color: selected ? colorBrandPrimary : colorGray600,
          ),
        ),
      ),
    );
  }
}
