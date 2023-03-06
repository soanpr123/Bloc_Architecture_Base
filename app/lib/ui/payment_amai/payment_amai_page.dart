import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';


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
          padding: EdgeInsets.fromLTRB(
            Dimens.d16.responsive(),
            Dimens.d68.responsive(),
            Dimens.d16.responsive(),
            Dimens.d24.responsive(),
          ),
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
                            color: colorTextDark,
                            fontSize: Dimens.d24.responsive(),
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimens.d80.responsive(),
                  ),
                  BlocBuilder<AppBloc, AppState>(
                    bloc: appBloc,
                    builder: (context, state) {
                      return (state.users.totalAmais ?? 0) > SymbolConstants.amaipayment
                          ? BlocBuilder<PaymentAmaiBloc, PaymentAmaiState>(
                              buildWhen: (previous, current) => previous.status != current.status,
                              builder: (context, statePay) {
                                return statePay.status
                                    ? Assets.svg.paymentDone
                                        .svg(width: Dimens.d200.responsive(), height: Dimens.d200.responsive())
                                    : Assets.svg.payment1
                                        .svg(width: Dimens.d200.responsive(), height: Dimens.d200.responsive());
                              },
                            )
                          : Assets.svg.paymentEr
                              .svg(width: Dimens.d200.responsive(), height: Dimens.d200.responsive());
                    },
                  ),
                  SizedBox(
                    height: Dimens.d24.responsive(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Assets.svg.dotIc.svg(),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  ),
                  SizedBox(
                    height: Dimens.d8.responsive(),
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
                                          Assets.svg.logoamai
                                              .svg(width: Dimens.d48.responsive(), height: Dimens.d48.responsive()),
                                          SizedBox(
                                            width: Dimens.d8.responsive(),
                                          ),
                                          Text(
                                            '${SymbolConstants.amaipayment} ${S.current.amai_point('').replaceAll(':', '')}',
                                            style: typoInterNomal18.copyWith(
                                              color: colorTextMedium,
                                              fontSize: Dimens.d24.responsive(),
                                              fontWeight: FontWeight.w700,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        S.current.payment_done,
                                        style: typoInterNomal18.copyWith(
                                          color: colorBrandPrimary,
                                          fontSize: Dimens.d24.responsive(),
                                          fontWeight: FontWeight.w700,
                                          height: 1.5,
                                        ),
                                      );
                              },
                            )
                          : Text(
                              S.current.amai_invalid,
                              style: typoInterNomal18.copyWith(
                                color: colorSupportWarning,
                                fontSize: Dimens.d24.responsive(),
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                              ),
                            );
                    },
                  ),
                  SizedBox(
                    height: Dimens.d8.responsive(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Assets.svg.dotIc.svg(),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  ),
                  SizedBox(
                    height: Dimens.d24.responsive(),
                  ),
                  BlocBuilder<AppBloc, AppState>(
                    bloc: appBloc,
                    builder: (context, state) {
                      return (state.users.totalAmais ?? 0) > SymbolConstants.amaipayment
                          ? Container()
                          : Text(
                              S.current.amai_noti,
                              textAlign: TextAlign.center,
                              style: typoInterNomal14.copyWith(
                                color: colorTextMedium,
                                fontSize: Dimens.d14.responsive(),
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            );
                    },
                  ),
                  BlocBuilder<PaymentAmaiBloc, PaymentAmaiState>(
                    buildWhen: (previous, current) => previous.status != current.status,
                    builder: (context, state) {
                      return !state.status
                          ? Container()
                          : Text(
                              S.current.payment_code_note,
                              textAlign: TextAlign.center,
                              style: typoInterNomal14.copyWith(
                                color: colorTextMedium,
                                fontSize: Dimens.d14.responsive(),
                                fontWeight: FontWeight.w400,
                                height: 1.5,
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
                                          child: AppElevatedButton(
                                            onPressed: () {
                                              navigator.popUntilRoot(useRootNavigator: true);
                                            },
                                            mainColor: colorBrandSecondary,
                                            buttonTitle: S.current.cancel,
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
