import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RounedRectangleShimmer(
      width: double.infinity,
      height: Dimens.d60.responsive(),
    );
  }
}

// ignore: prefer-single-widget-per-file
class ListViewLoader extends StatelessWidget {
  const ListViewLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: UiConstants.shimmerItemCount,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.d8.responsive(),
          vertical: Dimens.d8.responsive(),
        ),
        child: const ShimmerLoading(
          loadingWidget: LoadingItem(),
          isLoading: true,
          child: LoadingItem(),
        ),
      ),
    );
  }
}
