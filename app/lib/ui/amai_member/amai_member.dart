import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../shared_view/app_netword_image.dart';

class AmaiMemberPage extends StatefulWidget {
  const AmaiMemberPage({Key? key}) : super(key: key);

  @override
  _AmaiMemberState createState() => _AmaiMemberState();
}

class _AmaiMemberState extends BasePageState<AmaiMemberPage, AmaiMemberBloc> {
  late final _pagingController = CommonPagingController<MemberDataEntry>()..disposeBy(disposeBag);
  @override
  void initState() {
    super.initState();
    bloc.add(const MemberPageInitiated());
    _pagingController.listen(
      onLoadMore: () => bloc.add(const MemberLoadMore()),
    );
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AmaiMemberBloc, AmaiMemberState>(
          listenWhen: (previous, current) => previous.member != current.member,
          listener: (context, state) {
            _pagingController.appendLoadMoreOutput(state.member);
          },
        ),
        BlocListener<AmaiMemberBloc, AmaiMemberState>(
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
        text: S.current.member_amai,
        centerTitle: true,
        corlorText: Colors.white,
        backgroundColor: colorBrandPrimary,
        leadingIcon: const BackButton(color: Colors.white),
        elevation: 1,
        // height: MediaQuery.of(context).padding.top + Dimens.d60.responsive(),
      ),
      body: BlocBuilder<AmaiMemberBloc, AmaiMemberState>(
        buildWhen: (previous, current) =>
            previous.apirequest != current.apirequest ||
            previous.member != current.member ||
            previous.isShimmerLoading != current.isShimmerLoading,
        builder: (context, state) {
          return BodyBuilder(
            apiRequestStatus: state.apirequest,
            image: Assets.png.noData.image(
              width: Dimens.d265.responsive(),
              height: Dimens.d200.responsive(),
              fit: BoxFit.contain,
            ),
            child: RefreshIndicator(
              onRefresh: () {
                final completer = Completer<void>();
                bloc.add(MemberPageRefreshed(completer: completer));

                return completer.future;
              },
              child: CommonPagedGridView<MemberDataEntry>(
                padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive(), vertical: Dimens.d16.responsive()),
                pagingController: _pagingController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, item, index) {
                  return GestureDetector(
                    onTap: () {
                      navigator.showDialog(AppPopupInfo.dialogInfo(user: item, onPress: () => navigator.pop()));
                    },
                    child: Container(
                      height: Dimens.d106.responsive(),
                      width: Dimens.d106.responsive(),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        child: AppNetworkImage(
                          isAvt: true,
                          gender: item.gender??'',
                          source: item.avatar,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            reload: () {
              bloc.add(const MemberPageInitiated());
            },
          );
        },
      ),
    );
  }
}
