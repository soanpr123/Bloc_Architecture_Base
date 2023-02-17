import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/component/app_text_form_field.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/features/home_page/cubit/home_page_cubit.dart';
import 'package:project/features/payment_amai/cubit/payment_cubit.dart';

class PaymentAmaiPage extends StatelessWidget {
  PaymentAmaiPage({Key? key}) : super(key: key);
  final amaiCtrl = TextEditingController();
  final conentCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        var count = 0;
        context.router.popUntil((route) => count++ == 2);
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        //   leading: BackButton(
        //     color: Colors.black,
        //     onPressed: () {
        //       var count = 0;
        //       context.router.popUntil((route) => count++ == 2);
        //     },
        //   ),
        //   elevation: 1,
        //   title: Text(
        //     translation(context).store,
        //     style: typoInterNomal18,
        //   ),
        // ),
        body: BlocProvider(
          create: (context) => PaymentCubit(),
          child: SizedBox(
            child: Stack(
              children: [
                Positioned(
                  left: -16,
                  top: 50,
                  bottom: 0,
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Opacity(
                        opacity: 0.2,
                        child: Image.asset(
                          R.ASSETS_PNG_IMG_BG_GREEN_PNG,
                          // fit: Boxfi,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                                  translation(context).payment,
                                  style: typoInterNomal18.copyWith(
                                      color: colorTextDark, fontSize: 24, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: 197,
                            height: 197,
                            decoration: BoxDecoration(
                                color: Colors.grey[300], borderRadius: const BorderRadius.all(Radius.circular(200))),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<HomePageCubit, HomePageState>(
                            bloc: getIt<HomePageCubit>(),
                            builder: (context, state) {
                              return (state.profile.totalAmais ?? 0) > 0
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: AppTextFormField(
                                            controller: amaiCtrl,
                                            borderRadius: 5,
                                            keyboardType: TextInputType.number,
                                            hintText: "Nhập số amai thanh toán",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: AppTextFormField(
                                            controller: conentCtrl,
                                            maxLines: 4,
                                            borderRadius: 5,
                                            // keyboardType: TextInputType.number,
                                            hintText: "Nhập nội dung",
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Text(
                                          translation(context).amai_invalid,
                                          style: typoInterNomal18.copyWith(
                                              color: colorTextDark, fontSize: 24, fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Text(
                                            translation(context).amai_noti,
                                            textAlign: TextAlign.center,
                                            style: typoInterNomal14.copyWith(
                                                color: colorTextDark, fontSize: 14, fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    );
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 25, left: 16, right: 16),
                        child: BlocBuilder<HomePageCubit, HomePageState>(
                          bloc: getIt<HomePageCubit>(),
                          builder: (context, stateHome) {
                            return (stateHome.profile.totalAmais ?? 0) > 0
                                ? BlocBuilder<PaymentCubit, PaymentState>(
                                    builder: (context, state) {
                                      return AppElevatedButton(
                                        state: state.buttonState,
                                        onPressed: () {
                                          context
                                              .read<PaymentCubit>()
                                              .payment(amaiCtrl.text.trim(), conentCtrl.text.trim(), context);
                                        },
                                        buttonTitle: translation(context).payment,
                                      );
                                    },
                                  )
                                : AppElevatedButton(
                                    onPressed: () {
                                      var count = 0;
                                      context.router.popUntil((route) => count++ == 2);
                                    },
                                    buttonTitle: translation(context).back_to_home,
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
