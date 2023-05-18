import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
@RoutePage()
class WikiPage extends StatefulWidget {
  const WikiPage({Key? key}) : super(key: key);

  @override
  _WikiPageState createState() => _WikiPageState();
}

class _WikiPageState extends BasePageState<WikiPage, WikiBloc> {
  late final _pagingController = CommonPagingController<DataWiki>()..disposeBy(disposeBag);
  @override
  void initState() {
    super.initState();
    bloc.add(const WikiPageInitiated());
    appBloc.add(const AppInitiated(handleErr: false));
    _pagingController.listen(
      onLoadMore: () => bloc.add(const WikiLoadMore()),
    );
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WikiBloc, WikiState>(
          listenWhen: (previous, current) => previous.wiki != current.wiki,
          listener: (context, state) {
            _pagingController.appendLoadMoreOutput(state.wiki);
          },
        ),
        BlocListener<WikiBloc, WikiState>(
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
      appBar: CommonAppBar(
        text: S.current.wiki,
        centerTitle: true,
        corlorText: Colors.white,
        leadingIcon: const BackButton(color: Colors.white),
        backgroundColor: colorBrandPrimary,
        elevation: 1,
        // height: MediaQuery.of(context).padding.top + Dimens.d60.responsive(),
      ),
      body: BlocBuilder<WikiBloc, WikiState>(
        buildWhen: (previous, current) => previous.apirequestNoti != current.apirequestNoti,
        builder: (context, state) {
          return BodyBuilder(
            apiRequestStatus: state.apirequestNoti,
            image: Assets.png.noData.image(
              width: Dimens.d265.responsive(),
              height: Dimens.d200.responsive(),
              fit: BoxFit.contain,
            ),
            reload: () {
              bloc.add(const WikiPageInitiated());
            },
            child: RefreshIndicator(
              onRefresh: () {
                final completer = Completer<void>();
                bloc.add(WikiPageRefreshed(completer: completer));

                return completer.future;
              },
              child: CommonPagedListView<DataWiki>(
                pagingController: _pagingController,
                itemBuilder: (context, item, index) {
                  return ListTile(
                    onTap: () {
                      bloc.add(ReadWiki(slung: item.slug ?? ''));
                    },
                    minVerticalPadding: Dimens.d16.responsive(),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.createdAt ?? '',
                              style: typoInterNomal14.copyWith(color: colorTextMedium, height: 1.5),
                            ),
                            // item.isRead !=null
                            //     ? Container(
                            //         padding: EdgeInsets.symmetric(
                            //           vertical: Dimens.d2.responsive(),
                            //           horizontal: Dimens.d12.responsive(),
                            //         ),
                            //         decoration: BoxDecoration(
                            //           color: colorSupportDanger,
                            //           borderRadius: const BorderRadius.all(
                            //             Radius.circular(5),
                            //           ),
                            //         ),
                            //         child: Text(
                            //           'Mới',
                            //           textAlign: TextAlign.center,
                            //           style: typoInterNomal14.copyWith(color: Colors.white, height: 1.5),
                            //         ),
                            //       )
                            //     : Container(),
                          ],
                        ),
                        SizedBox(
                          height: Dimens.d6.responsive(),
                        ),
                        Text(
                          item.title ?? '',
                          style: typoInterNomal16.copyWith(color: colorTextDark, height: 1.5),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
