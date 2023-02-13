import 'package:flutter/material.dart';
import 'package:project/component/error_widget.dart';
import 'package:project/component/loading_widget.dart';
import 'package:project/core/utils/enum/api_request_status.dart';

class BodyBuilder extends StatelessWidget {
  final APIRequestStatus? apiRequestStatus;
  final Widget? child;
  final Function? reload;

  const BodyBuilder({Key? key, required this.apiRequestStatus, required this.child, required this.reload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    switch (apiRequestStatus) {
      case APIRequestStatus.loading:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(child: LoadingWidget()),
          ],
        );

      case APIRequestStatus.unInitialized:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(child: LoadingWidget()),
          ],
        );

      case APIRequestStatus.connectionError:
        return MyErrorWidget(
          refreshCallBack: reload!,
          isConnection: true,
        );

      case APIRequestStatus.error:
        return MyErrorWidget(
          refreshCallBack: reload!,
          isConnection: false,
        );
      case APIRequestStatus.nodata:
        return MyErrorWidget(
          refreshCallBack: reload!,
          isNodata: true,
        );
      case APIRequestStatus.storenodata:
        return MyErrorWidget(
          refreshCallBack: reload!,
          isStoreNodata: true,
        );
      case APIRequestStatus.loaded:
        return child ?? Container();

      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(child: LoadingWidget()),
          ],
        );
    }
  }
}
