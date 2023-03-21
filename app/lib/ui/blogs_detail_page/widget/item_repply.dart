import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../shared_view/app_netword_image.dart';

class ItemRepply extends StatelessWidget {
  const ItemRepply({
    super.key,
    required this.cmt,
    required this.bloc,
    required this.slungs,
  });

  final ReppyComentDataEntry cmt;
  final BlogsDetailBloc bloc;
  final String slungs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimens.d12.responsive()),
      // decoration: BoxDecoration(
      //   border: Border(
      //     top: BorderSide(color: colorUiBorder, width: 2),
      //   ),
      // ),
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
                    //  Text(
                    //   cmt.content ?? '',
                    //   style: typoInterNomal14.copyWith(
                    //     fontWeight: FontWeight.w400,
                    //     height: 1.5,
                    //     color: colorTextDark,
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimens.d8.responsive()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: typoInterNomal14.copyWith(
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                color: colorTextDark,
                              ),
                              children: [
                                cmt.replyUserName != ''
                                    ? TextSpan(
                                        text: '@${cmt.replyUserName}',
                                        style: typoInterNomal14.copyWith(
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                          color: colorTextDark,
                                        ),
                                      )
                                    : TextSpan(
                                        text: '',
                                        style: typoInterNomal14.copyWith(
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                          color: colorTextDark,
                                        ),
                                      ),
                                TextSpan(text: ' ${cmt.content}'),
                              ],
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
                            ],
                          ),
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
