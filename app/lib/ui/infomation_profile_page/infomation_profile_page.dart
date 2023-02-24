
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import 'bloc/infomation_profile_page_bloc.dart';

class InfomationProfilePage extends StatefulWidget {
  const InfomationProfilePage({Key? key}) : super(key: key);

  @override
  _InfomationProfilePageState createState() => _InfomationProfilePageState();
}

class _InfomationProfilePageState extends BasePageState<InfomationProfilePage, InfomationProfileBloc> {
  final aboutCtrl = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    aboutCtrl.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        text: S.current.infomation_profile,
      ),
      body: Container(),
    );
  }
}
