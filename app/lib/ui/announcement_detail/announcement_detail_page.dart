import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

class AnnouncementDetailPage extends StatefulWidget {
  const AnnouncementDetailPage({required this.slungs, Key? key}) : super(key: key);
  final String slungs;
  @override
  _AnnouncementDetailPageState createState() => _AnnouncementDetailPageState();
}

class _AnnouncementDetailPageState extends BasePageState<AnnouncementDetailPage, AnouncementDetailBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(AnouncementPageInitiated(slungs: widget.slungs));
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        text: S.current.notifycation_local,
        centerTitle: true,
        backgroundColor: Colors.white,
        leadingIcon: const BackButton(
          color: Colors.black,
        ),
      ),
      body: BlocBuilder<AnouncementDetailBloc, AnouncementDetailState>(
        buildWhen: (previous, current) => previous.announcementDetail != current.announcementDetail,
        builder: (context, state) {
          return Markdown(
            data: state.announcementDetail.content ?? '',
            selectable: true,
            onTapLink: (text, href, title) {
              IntentUtils.openBrowserURL(url: href ?? '', inApp: false);
            },
          );
        },
      ),
    );
  }
}
