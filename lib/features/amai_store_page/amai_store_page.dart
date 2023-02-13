import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/component/build_body.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/amai_store_page/component/item_store.dart';
import 'package:project/features/amai_store_page/cubit/amai_store_cubit.dart';

class AmaiStorePage extends StatelessWidget {
  const AmaiStorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
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
                  child: SingleChildScrollView(
                    child: Column(children: [
                      state.listCanteen.isNotEmpty
                          ? Column(
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
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 280,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 16),
                                    itemBuilder: (ctx, i) {
                                      final item = state.listCanteen[i];
                                      return ItemStore(orderNo: item.orderNo ?? 0, dess: item.name ?? "");
                                    })
                              ],
                            )
                          : Container(),
                      const SizedBox(
                        height: 16,
                      ),
                      state.listCanteen.isNotEmpty
                          ? Column(
                              children: [
                                Text(
                                  "Cơm ngoài",
                                  style: typoInterNomal18.copyWith(color: colorTextDark, fontSize: 24),
                                ),
                                GridView.builder(
                                    padding: const EdgeInsets.only(top: 16),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.listCanteen.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 280,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 16),
                                    itemBuilder: (ctx, i) {
                                      final item = state.listCanteen[i];
                                      return ItemStore(orderNo: item.orderNo ?? 0, dess: item.name ?? "");
                                    })
                              ],
                            )
                          : Container()
                    ]),
                  ),
                ),
                reload: () {});
          },
        ),
      ),
    );
  }
}
