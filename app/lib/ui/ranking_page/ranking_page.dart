import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../base/base_page_state.dart';
import '../../shared_view/app_netword_image.dart';

@RoutePage()
class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends BasePageState<RankingPage, RankingPageBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const RankingPageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        text: 'Bảng xếp hạng',
        centerTitle: true,
        corlorText: Colors.white,
        leadingIcon: const BackButton(color: Colors.white),
        backgroundColor: colorBrandPrimary,
        elevation: 1,
        // height: MediaQuery.of(context).padding.top + Dimens.d60.responsive(),
      ),
      body: BlocBuilder<RankingPageBloc, RankingPageState>(
        buildWhen: (previous, current) =>
            previous.leaderBroad != current.leaderBroad || previous.apiRequestStatus != current.apiRequestStatus,
        builder: (context, state) {
          return SafeArea(
            child: BodyBuilder(
              apiRequestStatus: state.apiRequestStatus,
              image: Assets.png.noData.image(
                width: Dimens.d265.responsive(),
                height: Dimens.d200.responsive(),
                fit: BoxFit.contain,
              ),
              reload: () {
                bloc.add(const RankingPageInitiated());
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  Container(
                    height: Dimens.d300.responsive(),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.png.icBgRank.path,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimens.d26.responsive(),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.d24.responsive(), vertical: Dimens.d8.responsive()),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                Assets.png.icVongRank.path,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                S.current.monthRank(DateTime.now().month),
                                style: typoInterNomal18.copyWith(
                                  color: colorBrandPrimary,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5,
                                ),
                              ),
                              Text(
                                S.current.congratulations,
                                style: typoInterNomal14.copyWith(
                                    color: colorSupportWarning, fontWeight: FontWeight.w600, height: 1.5),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimens.d12.responsive(),
                        ),
                        state.leaderBroad.isNotEmpty
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.d18.responsive(), vertical: Dimens.d8.responsive()),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: Dimens.d48.responsive(),
                                      width: Dimens.d48.responsive(),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                                        child: AppNetworkImageAvatar(
                                          source: state.leaderBroad.first.avatar,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimens.d4.responsive(),
                                    ),
                                    Text(
                                      state.leaderBroad.first.name ?? '',
                                      style: typoInterNomal14.copyWith(
                                        fontSize: Dimens.d14.responsive(),
                                        color: colorTextMedium,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimens.d4.responsive(),
                                    ),
                                    Text(
                                      '${state.leaderBroad.first.totalLikes ?? 0}',
                                      style: typoInterNomal14.copyWith(
                                        color: colorBrandPrimary,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: Dimens.d8.responsive(),
                        ),
                        Container(
                          height: Dimens.d38.responsive(),
                          width: Dimens.d125.responsive(),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                Assets.png.icTop1.path,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: Dimens.d272.responsive(),
                    // bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimens.d16.responsive(),
                      ),
                      padding: EdgeInsets.fromLTRB(
                        Dimens.d24.responsive(),
                        Dimens.d32.responsive(),
                        Dimens.d24.responsive(),
                        0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: boxShadow,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: state.leaderBroad.length,
                        // itemCount: 10,
                        itemBuilder: (ctx, i) {
                          final item = state.leaderBroad[i];

                          return i == 0
                              ? Container()
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                '${i + 1}',
                                                style: typoInterNomal14.copyWith(
                                                  color: colorTextMedium,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.5,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimens.d4.responsive(),
                                              ),
                                              SizedBox(
                                                height: Dimens.d32.responsive(),
                                                width: Dimens.d32.responsive(),
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                  child: AppNetworkImageAvatar(
                                                    source: item.avatar,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimens.d12.responsive(),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  item.name ?? '',
                                                  style: typoInterNomal14.copyWith(
                                                    color: colorTextMedium,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimens.d12.responsive(),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${item.totalLikes ?? 0}',
                                              style: typoInterNomal14.copyWith(
                                                color: colorTextMedium,
                                                fontWeight: FontWeight.w600,
                                                height: 1.5,
                                              ),
                                            ),
                                            Icon(
                                              (item.direction ?? -1) < 0 ? Icons.arrow_downward : Icons.arrow_upward,
                                              color: (item.direction ?? -1) < 0 ? colorRed500 : colorBrandPrimary,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimens.d32.responsive(),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
