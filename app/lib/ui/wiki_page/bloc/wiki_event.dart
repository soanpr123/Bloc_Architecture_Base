
import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'wiki_event.freezed.dart';

abstract class WikiEvent extends BaseBlocEvent {
  const WikiEvent();
}

@freezed
class WikiPageInitiated extends WikiEvent with _$WikiPageInitiated {
  const factory WikiPageInitiated() = _WikiPageInitiated;
}

@freezed
class ReadWiki extends WikiEvent with _$ReadWiki {
  const factory ReadWiki({
    required String slung,
  }) = _ReadWiki;
}

@freezed
class WikiPageRefreshed extends WikiEvent with _$WikiPageRefreshed {
  const factory WikiPageRefreshed({
    required Completer<void> completer,
  }) = _WikiPageRefreshed;
}

@freezed
class WikiLoadMore extends WikiEvent with _$WikiLoadMore {
  const factory WikiLoadMore() = _WikiLoadMore;
}
