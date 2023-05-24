import 'dart:async';

import 'package:app/ui/list_blogs_page/widget/bottom_sheet_view.dart';
import 'package:app/ui/list_blogs_page/widget/item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';
import 'package:badges/badges.dart' as badges;
import '../../app.dart';

@RoutePage()
class ListBlogsPage extends StatefulWidget {
  const ListBlogsPage({required this.tag, Key? key}) : super(key: key);
  final String tag;
  @override
  _ListBlogsPageState createState() => _ListBlogsPageState();
}

class _ListBlogsPageState extends BasePageState<ListBlogsPage, ListBlogsBloc> with TickerProviderStateMixin {
  late final TabController tabController;
  late final _pagingController = CommonPagingController<BlogsDataEntry>()..disposeBy(disposeBag);
  final TextEditingController search = TextEditingController();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    search.text = widget.tag;
    bloc.add(ListBlogsPageInitiated(tag: widget.tag));

    _pagingController.listen(
      onLoadMore: () => bloc.add(const ListBlogsLoadMore()),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ListBlogsBloc, ListBlogsState>(
          listenWhen: (previous, current) => previous.blogs != current.blogs,
          listener: (context, state) {
            _pagingController.appendLoadMoreOutput(state.blogs);
          },
        ),
        BlocListener<ListBlogsBloc, ListBlogsState>(
          listenWhen: (previous, current) => previous.loadUsersException != current.loadUsersException,
          listener: (context, state) {
            _pagingController.error = state.loadUsersException;
          },
        ),
      ],
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        text: S.current.blogs,
        centerTitle: true,
        corlorText: Colors.white,
        backgroundColor: colorSupportInfo,
        elevation: 1,
        leadingIcon: const BackButton(
          color: Colors.white,
        ),
        // height: MediaQuery.of(context).padding.top + Dimens.d60.responsive(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive(), vertical: Dimens.d16.responsive()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimens.d40.responsive(),
              child: AppTextFormField(
                borderRadius: 5,
                hintText: S.current.hintTextSearch,
                onEditingComplete: () {
                  bloc.add(ListBlogsSearch(search: search.text.trim()));
                },
                controller: search,
                textInputAction: TextInputAction.done,
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.svg.searchLine.svg(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dimens.d14.responsive(),
            ),
            Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: colorBoder01,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                TabBar(
                  controller: tabController,
                  unselectedLabelColor: colorTextBland,
                  labelPadding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive(), horizontal: 0),
                  unselectedLabelStyle:
                      typoInterNomal14.copyWith(color: colorTextBland, fontWeight: FontWeight.w600, height: 1),
                  labelStyle: typoInterNomal14.copyWith(color: colorTextDark, fontWeight: FontWeight.w600, height: 1),
                  labelColor: colorTextDark,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: colorTextDark,
                  onTap: (v) {
                    bloc.add(PressTab(postType: v));
                  },
                  tabs: [
                    Text(
                      S.current.community,
                    ),
                    Text(
                      S.current.posted,
                    ),
                    Text(
                      S.current.save_draft,
                    ),
                    Text(
                      S.current.favourite,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: Dimens.d12.responsive(),
            ),
            BlocBuilder<ListBlogsBloc, ListBlogsState>(
              buildWhen: (previous, current) =>
                  previous.allPost != current.allPost ||
                  previous.newPost != current.newPost ||
                  previous.categorySelect != current.categorySelect,
              builder: (context, stateFill) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    badges.Badge(
                      badgeStyle: const badges.BadgeStyle(padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6)),
                      badgeAnimation: const badges.BadgeAnimation.fade(
                        animationDuration: Duration(milliseconds: 200),
                        loopAnimation: false,
                      ),
                      showBadge: stateFill.categorySelect.id != -1,
                      ignorePointer: false,
                      position: badges.BadgePosition.topEnd(top: -4, end: -4),
                      child: GestureDetector(
                        onTap: () async {
                          await navigator.showBarModalBottomSheetIml(
                            AppPopupInfo.bottomSheet(
                              child: BottomSheetView(
                                navigator: navigator,
                                bloc: bloc,
                              ),
                            ),
                            // backgroundColor: Colors.transparent,
                            expaned: false,
                            isDismissible: false,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            useRootNavigator: true,
                            backgroundColor: Colors.white,
                          );
                        },
                        child: Container(
                          height: Dimens.d32.responsive(),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.d16.responsive(),
                            vertical: Dimens.d4.responsive(),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: colorBrandPrimary, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: Dimens.d20.responsive(),
                                height: Dimens.d20.responsive(),
                                padding: EdgeInsets.symmetric(vertical: Dimens.d5.responsive(), horizontal: 2.5),
                                child: Assets.svg.filterFill
                                    .svg(width: Dimens.d15.responsive(), height: Dimens.d10.responsive()),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: Dimens.d2.responsive()),
                                child: Text(
                                  S.current.fillter,
                                  textAlign: TextAlign.center,
                                  style: typoInterNomal14.copyWith(
                                    color: colorBrandPrimary,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '${stateFill.allPost ? 'Mới nhất' : 'Nổi bật'}, ' '${stateFill.categorySelect.name}',
                      style:
                          typoInterNomal14.copyWith(fontWeight: FontWeight.w600, height: 1.5, color: colorTextMedium),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: Dimens.d12.responsive(),
            ),
            BlocBuilder<ListBlogsBloc, ListBlogsState>(
              buildWhen: (previous, current) => previous.blogs.data != current.blogs.data,
              builder: (context, stateSearch) {
                return stateSearch.search != ''
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: RichText(
                          text: TextSpan(
                            text: 'Hiển thị',
                            style: typoInterNomal14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: colorTextMedium,
                              fontSize: Dimens.d16.responsive(),
                              height: 1.5,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' ${stateSearch.blogs.data.length}',
                                style: typoInterNomal14.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Dimens.d16.responsive(),
                                  color: colorBrandPrimary,
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: ' kết quả.',
                                style: typoInterNomal14.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: colorTextMedium,
                                  fontSize: Dimens.d16.responsive(),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container();
              },
            ),
            Expanded(
              child: BlocBuilder<ListBlogsBloc, ListBlogsState>(
                buildWhen: (previous, current) =>
                    previous.blogs != current.blogs ||
                    previous.loading != current.loading ||
                    previous.curentTab != current.curentTab,
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () {
                      final completer = Completer<void>();
                      bloc.add(ListBlogsPageRefreshed(completer: completer));

                      return completer.future;
                    },
                    child: BodyBuilder(
                      apiRequestStatus: state.loading,
                      image: Assets.png.noData.image(
                        width: Dimens.d265.responsive(),
                        height: Dimens.d200.responsive(),
                        fit: BoxFit.contain,
                      ),
                      isLoadingNew: false,
                      child: CommonPagedListView<BlogsDataEntry>(
                        shrinkWrap: true,
                        pagingController: _pagingController,
                        itemBuilder: (context, item, index) {
                          return GestureDetector(
                            onTap: () async {
                              await navigator.push(AppRouteInfo.blogsDetail(item.slug ?? ''));
                              bloc.add(const ListBlogsPageInitiated(isIntinalLoad: false));
                            },
                            child: ItemBlogs(item: item),
                          );
                        },
                      ),
                      reload: () {
                        bloc.add(const ListBlogsPageInitiated());
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
