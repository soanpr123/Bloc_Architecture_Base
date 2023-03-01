import 'package:app/shared_view/loading_widget.dart';
import 'package:flutter/material.dart';

import 'error_widget.dart';

enum APIRequestStatus { unInitialized, loading, loaded, error, connectionError, nodata }

class BodyBuilder extends StatelessWidget {
  const BodyBuilder({
    required this.apiRequestStatus,
    required this.image,
    required this.child,
    required this.reload,
    Key? key,
  }) : super(key: key);
  final APIRequestStatus? apiRequestStatus;
  final Widget? child;
  final Function? reload;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    switch (apiRequestStatus) {
      case APIRequestStatus.loading:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: LoadingWidget()),
          ],
        );

      case APIRequestStatus.unInitialized:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: LoadingWidget()),
          ],
        );

      case APIRequestStatus.connectionError:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyErrorWidget(
              refreshCallBack: reload!,
              isConnection: true,
              image: image,
            ),
          ],
        );

      case APIRequestStatus.error:
        return MyErrorWidget(
          refreshCallBack: reload!,
          isConnection: false,
          image: image,
        );
      case APIRequestStatus.nodata:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyErrorWidget(
              refreshCallBack: reload!,
              isNodata: true,
              image: image,
            ),
          ],
        );
      case APIRequestStatus.loaded:
        return child ?? Container();

      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: LoadingWidget()),
          ],
        );
    }
  }
}
