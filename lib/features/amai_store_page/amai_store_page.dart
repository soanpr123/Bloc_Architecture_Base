import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/component/build_body.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/app_utils.dart';
import 'package:project/features/amai_store_page/component/item_store.dart';
import 'package:project/features/amai_store_page/cubit/amai_store_cubit.dart';
import 'package:project/features/profile_page/component/dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AmaiStorePage extends StatelessWidget {
  AmaiStorePage({Key? key}) : super(key: key);
  RefreshController refreshController = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Text(
          translation(context).store,
          style: typoInterNomal18,
        ),
      ),
      body: BlocProvider(
        create: (context) => AmaiStoreCubit()..requestMenu(context),
        child: BlocBuilder<AmaiStoreCubit, AmaiStoreState>(
          builder: (context, state) {
            return BodyBuilder(
                apiRequestStatus: state.apiRequestStatus,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SmartRefresher(
                    controller: refreshController,
                    onRefresh: () {
                      context.read<AmaiStoreCubit>().requestMenu(context);
                      refreshController.refreshCompleted();
                    },
                    child: SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        state.ordered.lunchMenusId != null
                            ? Column(
                                children: [
                                  Text(
                                    "Lưu ý: Món ăn sẽ được chốt trước 10h30, sau 10h30 sẽ không thể thay đổi trên hệ thống",
                                    style: typoInterNomal16.copyWith(color: colorSupportDanger),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              )
                            : Container(),
                        state.listCanteen.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cơm canteen",
                                    style: typoInterNomal18.copyWith(color: colorTextDark, fontSize: 24),
                                  ),
                                  GridView.builder(
                                      padding: const EdgeInsets.only(top: 16),
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.listCanteen.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: MediaQuery.of(context).size.height / 2,
                                          // childAspectRatio:
                                          //     MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height),
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 16),
                                      itemBuilder: (ctx, i) {
                                        final item = state.listCanteen[i];
                                        return ItemStore(
                                          title: "Thực đơn ${item.orderNo ?? 0}",
                                          dess: item.name ?? "",
                                          state: state,
                                          id: item.id ?? 0,
                                          buttonState: (state.ordered.lunchMenusId ?? 0) != (item.id ?? 0) &&
                                                      state.ordered.lunchMenusId != null ||
                                                  checkTime() == true
                                              ? AppElevatedButtonState.inactive
                                              : AppElevatedButtonState.active,
                                          onPressed: () async {
                                            if ((state.ordered.lunchMenusId ?? 0) == (item.id ?? 0)) {
                                              await context.read<AmaiStoreCubit>().deteteOrdered();
                                            } else {
                                              showDialog(
                                                  context: (context),
                                                  barrierDismissible: false,
                                                  builder: (co) {
                                                    return DialogConfirmOrder(
                                                      state: state,
                                                      bloc: context.read<AmaiStoreCubit>(),
                                                      id: item.id ?? 0,
                                                      name: "Thực đơn ${item.orderNo ?? 0}",
                                                    );
                                                  });
                                            }
                                          },
                                        );
                                      })
                                ],
                              )
                            : Container(),
                        const SizedBox(
                          height: 16,
                        ),
                        state.listOther.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cơm ngoài",
                                    style: typoInterNomal18.copyWith(color: colorTextDark, fontSize: 24),
                                  ),
                                  GridView.builder(
                                      padding: const EdgeInsets.only(top: 16),
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.listOther.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 280,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 16),
                                      itemBuilder: (ctx, i) {
                                        final item = state.listOther[i];
                                        return ItemStore(
                                          title: item.name ?? "",
                                          dess: item.name ?? "",
                                          id: item.id ?? 0,
                                          state: state,
                                          buttonState: (state.ordered.lunchMenusId ?? 0) != (item.id ?? 0) &&
                                                      state.ordered.lunchMenusId != null ||
                                                  checkTime() == true
                                              ? AppElevatedButtonState.inactive
                                              : AppElevatedButtonState.active,
                                          onPressed: () async {
                                            if ((state.ordered.lunchMenusId ?? 0) == (item.id ?? 0)) {
                                              await context.read<AmaiStoreCubit>().deteteOrdered();
                                            } else {
                                              showDialog(
                                                  context: (context),
                                                  barrierDismissible: false,
                                                  builder: (co) {
                                                    return DialogConfirmOrder(
                                                      state: state,
                                                      bloc: context.read<AmaiStoreCubit>(),
                                                      id: item.id ?? 0,
                                                      name: item.name ?? "",
                                                    );
                                                  });
                                              // await context.read<AmaiStoreCubit>().orderStore(item.id ?? 0);
                                            }
                                          },
                                        );
                                      })
                                ],
                              )
                            : Container(),
                        const SizedBox(
                          height: 16,
                        ),
                      ]),
                    ),
                  ),
                ),
                reload: () {
                  context.read<AmaiStoreCubit>().requestMenu(context);
                });
          },
        ),
      ),
    );
  }
}
