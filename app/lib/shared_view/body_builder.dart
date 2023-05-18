import 'package:flutter/material.dart';

import 'error_widget.dart';
import 'loading_widget.dart';

enum APIRequestStatus { unInitialized, loading, loaded, error, connectionError, nodata }

class BodyBuilder extends StatelessWidget {
  const BodyBuilder({
    required this.apiRequestStatus,
    required this.image,
    required this.child,
    required this.reload,
    this.isStore = false,
    this.isLoadingNew = true,
    Key? key,
  }) : super(key: key);
  final APIRequestStatus? apiRequestStatus;
  final Widget? child;
  final Function? reload;
  final bool isStore;
  final Widget image;
  final bool isLoadingNew;

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
            Center(child: LoadingWidget(isLoadingNew: isLoadingNew)),
          ],
        );

      case APIRequestStatus.unInitialized:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: LoadingWidget(isLoadingNew: isLoadingNew)),
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
              isStore: isStore,
              image: image,
            ),
          ],
        );
      case APIRequestStatus.loaded:
        return child ?? Container();

      default:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: LoadingWidget()),
          ],
        );
    }
  }
}
