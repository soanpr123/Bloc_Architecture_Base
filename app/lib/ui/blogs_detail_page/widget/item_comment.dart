import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../shared_view/app_netword_image.dart';
import 'item_repply.dart';

class ItemComent extends StatelessWidget {
  const ItemComent({
    super.key,
    required this.cmt,
    required this.bloc,
    required this.slungs,
  });

  final ComentDataEntry cmt;
  final BlogsDetailBloc bloc;
  final String slungs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive()),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colorUiBorder, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cmt.createdAt ?? '',
            style: typoInterNomal14.copyWith(color: colorTextMedium, height: 1.5),
          ),
          SizedBox(height: Dimens.d8.responsive()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimens.d32.responsive(),
                height: Dimens.d32.responsive(),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(
                    Dimens.d24.responsive(),
                  )),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(Dimens.d24.responsive())),
                  child: AppNetworkImage(
                    source: cmt.avatar,
                  ),
                ),
              ),
              SizedBox(width: Dimens.d8.responsive()),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cmt.name ?? '',
                      style: typoInterNomal16.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        color: colorTextDark,
                      ),
                    ),
                    SizedBox(height: Dimens.d12.responsive()),
                    Padding(
                      padding: EdgeInsets.only(left: Dimens.d8.responsive()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cmt.content ?? '',
                            style: typoInterNomal14.copyWith(
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: colorTextDark,
                            ),
                          ),
                          SizedBox(height: Dimens.d4.responsive()),
                          Row(
                            children: [
                              Assets.svg.heartBlack.svg(
                                width: Dimens.d20.responsive(),
                                height: Dimens.d20.responsive(),
                                color: cmt.isLiked == 1 ? colorRed500 : colorGray600,
                              ),
                              SizedBox(
                                width: Dimens.d8.responsive(),
                              ),
                              Text(
                                '${cmt.totalLikes}',
                                style: typoInterNomal14.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: cmt.isLiked == 1 ? colorRed500 : colorTextMedium,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  bloc.add(LikeComment(slungs: slungs, id: cmt.id ?? 0));
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(colorDisabled),
                                ),
                                child: Text(
                                  'Thích',
                                  style: typoInterNomal14.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: cmt.isLiked == 1 ? colorBrandPrimary : colorBrandSecondary,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                   bloc.add(const ForcusComment(isComment: true));
                                  bloc.add(SelectComent(id: cmt.id??-1,name: cmt.name??''));
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(colorDisabled),
                                ),
                                child: Text(
                                  'Phản hồi',
                                  style: typoInterNomal14.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: colorBrandSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          cmt.reply != null
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cmt.reply!.length,
                                  itemBuilder: (ctx, i) {
                                    final reppy = cmt.reply![i];

                                    return ItemRepply(
                                      cmt: reppy,
                                      bloc: bloc,
                                      slungs: slungs,
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
