import 'package:domain/domain.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:resources/resources.dart';

import '../../../app.dart';
import '../../../shared_view/app_check_box.dart';

class BottomSheetView extends StatelessWidget {
  const BottomSheetView({
    super.key,
    required this.navigator,
    required this.bloc,
  });

  final AppNavigator navigator;
  final ListBlogsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive(), vertical: Dimens.d16.responsive()),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: colorUiBorder, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: Dimens.d20.responsive(),
                    height: Dimens.d20.responsive(),
                    padding: EdgeInsets.symmetric(vertical: Dimens.d5.responsive(), horizontal: 2.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.svg.filterFill.svg(width: Dimens.d15.responsive(), height: Dimens.d10.responsive()),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: Dimens.d2.responsive()),
                    child: Text(
                      S.current.fillter,
                      textAlign: TextAlign.center,
                      style: typoInterNomal16.copyWith(
                        color: colorBrandPrimary,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                  ),
                ]),
                GestureDetector(
                  onTap: () {
                    navigator.pop();
                  },
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: colorGray400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trạng thái',
                      style: typoInterNomal14.copyWith(fontWeight: FontWeight.w700, color: colorTextMedium),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    BlocBuilder<ListBlogsBloc, ListBlogsState>(
                      bloc: bloc,
                      buildWhen: (previous, current) =>
                          previous.allPost != current.allPost || previous.newPost != current.newPost,
                      builder: (context, state) {
                        // return Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       flex: 3,
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           AppCheckBox(
                        //             value: state.allPost,
                        //             onChanged: (v) {
                        //               bloc.add(const ListBlogsStatusSelect(allPost: true, newPost: false));
                        //             },
                        //             label: 'Mới nhất',
                        //           ),
                        //           AppCheckBox(
                        //             value: state.newPost,
                        //             onChanged: (v) {
                        //               bloc.add(const ListBlogsStatusSelect(allPost: false, newPost: true));
                        //             },
                        //             label: 'Nổi bật',
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Expanded(flex: 1, child: Container())
                        //   ],
                        // );
                        return AlignedGridView.count(
                          padding: EdgeInsets.zero,
                          itemCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 16,
                          shrinkWrap: true,
                          clipBehavior: Clip.antiAlias,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                index == 0
                                    ? AppCheckBox(
                                        value: state.allPost,
                                        onChanged: (v) {
                                          bloc.add(const ListBlogsStatusSelect(allPost: true, newPost: false));
                                        },
                                        label: 'Mới nhất',
                                      )
                                    : AppCheckBox(
                                        value: state.newPost,
                                        onChanged: (v) {
                                          bloc.add(const ListBlogsStatusSelect(allPost: false, newPost: true));
                                        },
                                        label: 'Nổi bật',
                                      ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Thể loại',
                      style: typoInterNomal14.copyWith(fontWeight: FontWeight.w700, color: colorTextMedium),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    BlocBuilder<ListBlogsBloc, ListBlogsState>(
                      bloc: bloc,
                      buildWhen: (previous, current) =>
                          previous.category != current.category || previous.categorySelect != current.categorySelect,
                      builder: (context, state2) {
                        return AlignedGridView.count(
                          padding: EdgeInsets.zero,
                          itemCount: state2.category.length,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 16,
                          shrinkWrap: true,
                          clipBehavior: Clip.antiAlias,
                          itemBuilder: (BuildContext context, int index) {
                            final item = state2.category[index];

                            return Row(
                              children: [
                                AppCheckBox(
                                  value: item.id == state2.categorySelect.id,
                                  onChanged: (v) {
                                    bloc.add(ListBlogsCateSelect(categorySelect: item));
                                  },
                                  label: item.name,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: AppElevatedButton(
                    mainColor: colorBrandSecondary,
                    buttonTitle: S.current.reset_fillter,
                    onPressed: () {
                      bloc.add(const ResetsFillterButtonPress());
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: AppElevatedButton(
                    mainColor: colorBrandPrimary,
                    buttonTitle: S.current.fillter,
                    onPressed: () {
                      bloc.add(const FillterButtonPress());
                      navigator.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
