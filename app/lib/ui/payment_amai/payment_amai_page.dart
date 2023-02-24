import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../shared_view/app_text_button.dart';

class PaymentAmaiPage extends StatefulWidget {
  const PaymentAmaiPage({Key? key}) : super(key: key);

  @override
  _PaymentAmaiPageState createState() => _PaymentAmaiPageState();
}

class _PaymentAmaiPageState extends BasePageState<PaymentAmaiPage, PaymentAmaiBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigator.popUntilRoot(useRootNavigator: true);
     
        return Future.value(false);
      },
      child: CommonScaffold(
        body: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.current.payment,
                          style: typoInterNomal18.copyWith(
                              color: colorTextDark, fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimens.d16.responsive(),
                  ),
                  BlocBuilder<AppBloc, AppState>(
                    bloc: appBloc,
                    builder: (context, state) {
                      return (state.users.totalAmais ?? 0) > SymbolConstants.amaipayment
                          ? BlocBuilder<PaymentAmaiBloc, PaymentAmaiState>(
                              buildWhen: (previous, current) => previous.status != current.status,
                              builder: (context, statePay) {
                                return statePay.status ? Assets.svg.paymentDone.svg() : Assets.svg.payment1.svg();
                              },
                            )
                          : Assets.svg.paymentEr.svg();
                    },
                  ),
                  SizedBox(
                    height: Dimens.d16.responsive(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.d120),
                    child: Center(
                      child: DottedLine(
                        dashLength: 30,
                        dashGapLength: 10,
                        lineThickness: 5,
                        dashRadius: 5,
                        dashColor: colorBrandPrimary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.d16.responsive(),
                  ),
                  BlocBuilder<AppBloc, AppState>(
                    bloc: appBloc,
                    builder: (context, state) {
                      return (state.users.totalAmais ?? 0) > SymbolConstants.amaipayment
                          ? BlocBuilder<PaymentAmaiBloc, PaymentAmaiState>(
                              buildWhen: (previous, current) => previous.status != current.status,
                              builder: (context, statePay) {
                                return !statePay.status
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Assets.svg.logoamai.svg(width: 32, height: 32),
                                          SizedBox(
                                            width: Dimens.d8.responsive(),
                                          ),
                                          Text(
                                            '${SymbolConstants.amaipayment} ${S.current.amai_point('').replaceAll(':', '')}',
                                            style: typoInterNomal18.copyWith(
                                              color: colorTextDark,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        S.current.payment_done,
                                        style: typoInterNomal18.copyWith(
                                          color: colorBrandPrimary,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                              },
                            )
                          : Text(
                              S.current.amai_invalid,
                              style: typoInterNomal18.copyWith(
                                color: colorSupportWarning,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                    },
                  ),
                  SizedBox(
                    height: Dimens.d16.responsive(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.d120),
                    child: Center(
                      child: DottedLine(
                        dashLength: 30,
                        dashGapLength: 10,
                        lineThickness: 5,
                        dashRadius: 5,
                        dashColor: colorBrandPrimary,
                      ),
                    ),
                  ),
                  BlocBuilder<AppBloc, AppState>(
                    bloc: appBloc,
                    builder: (context, state) {
                      return (state.users.totalAmais ?? 0) > SymbolConstants.amaipayment
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                S.current.amai_noti,
                                textAlign: TextAlign.center,
                                style: typoInterNomal18.copyWith(
                                  color: colorTextMedium,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                    },
                  ),
                  BlocBuilder<PaymentAmaiBloc, PaymentAmaiState>(
                    buildWhen: (previous, current) => previous.status != current.status,
                    builder: (context, state) {
                      return !state.status
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                S.current.payment_code_note,
                                textAlign: TextAlign.center,
                                style: typoInterNomal18.copyWith(
                                  color: colorTextMedium,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
              BlocBuilder<AppBloc, AppState>(
                bloc: appBloc,
                builder: (context, state) {
                  return (state.users.totalAmais ?? 0) > SymbolConstants.amaipayment
                      ? BlocBuilder<PaymentAmaiBloc, PaymentAmaiState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status || previous.buttonState != current.buttonState,
                          builder: (context, statePay) {
                            return statePay.status
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      bottom: Dimens.d25.responsive(),
                                      left: Dimens.d8.responsive(),
                                      right: Dimens.d8.responsive(),
                                    ),
                                    child: AppElevatedButton(
                                      onPressed: () {
                                        navigator.popUntilRoot(useRootNavigator: true);
                                      },
                                      buttonTitle: S.current.back_to_home,
                                      mainColor: colorBrandPrimary,
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                      bottom: Dimens.d25.responsive(),
                                      left: Dimens.d8.responsive(),
                                      right: Dimens.d8.responsive(),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: Dimens.d45.responsive(),
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(Dimens.d5)),
                                              border: Border.all(color: colorBrandPrimary, width: 1),
                                            ),
                                            child: AppTextButton(
                                              onPressed: () {
                                                navigator.popUntilRoot(useRootNavigator: true);
                                              },
                                              color: colorBrandPrimary,
                                              buttonTitle: S.current.cancel,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimens.d8.responsive(),
                                        ),
                                        Expanded(
                                          child: AppElevatedButton(
                                            state: statePay.buttonState,
                                            onPressed: () {
                                              bloc.add(const PaymentAmaiInitiated());
                                            },
                                            buttonTitle: S.current.payment,
                                            mainColor: colorBrandPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                            bottom: Dimens.d25.responsive(),
                            left: Dimens.d8.responsive(),
                            right: Dimens.d8.responsive(),
                          ),
                          child: AppElevatedButton(
                            onPressed: () {
                              navigator.popUntilRoot(useRootNavigator: true);
                            },
                            buttonTitle: S.current.back_to_home,
                            mainColor: colorBrandPrimary,
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
