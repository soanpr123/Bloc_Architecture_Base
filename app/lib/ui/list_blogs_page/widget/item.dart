import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../shared_view/app_netword_image.dart';

class ItemBlogs extends StatelessWidget {
  const ItemBlogs({
    super.key,
    required this.item,
  });
  final BlogsDataEntry item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.d24.responsive()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Dimens.d171.responsive(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: AppNetworkImage(
                source: item.thumb,
              ),
            ),
          ),
          SizedBox(
            height: Dimens.d12.responsive(),
          ),
          Text(
            item.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: typoInterNomal16.copyWith(color: colorTextDark, height: 1.5),
          ),
          SizedBox(
            height: Dimens.d8.responsive(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                        source: item.author?.avatar ?? '',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimens.d8.responsive(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.author?.name ?? '',
                        style: typoInterNomal14.copyWith(fontSize: 12, height: 1.5, color: colorTextMedium),
                      ),
                      Text(
                        item.createdAt ?? '',
                        style: typoInterNomal14.copyWith(fontSize: 12, height: 1.5, color: colorTextMedium),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  item.isLiked == 1
                      ? Assets.svg.heart.svg(
                          width: 20,
                          height: 20,
                        )
                      : Assets.svg.heartBlack.svg(
                          width: 20,
                          height: 20,
                        ),
                  SizedBox(
                    width: Dimens.d8.responsive(),
                  ),
                  Text(
                    '${item.totalLikes ?? 0}',
                    style: typoInterNomal14.copyWith(fontSize: 12, height: 1.5, color: colorTextMedium),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
