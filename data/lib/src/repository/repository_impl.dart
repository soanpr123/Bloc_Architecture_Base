import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartx/dartx.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../data.dart';
import 'mapper/Announcement_detail_mapper.dart';
import 'mapper/base_response_mapper.dart';
import 'mapper/data_history_mapper.dart';
import 'mapper/data_list_store_mapper.dart';
import 'mapper/detail_wiki_mapper.dart';

import 'mapper/order_data_mapper.dart';
import 'mapper/popup_donate_mapper.dart';
import 'mapper/upload_image_mapper.dart';
import 'mapper/wiki_data_mapper.dart';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  RepositoryImpl(
    this._appApiService,
    this._appPreferences,
    // this._appDatabase,
    this._announmentDataMapper,
    this._preferenceUserDataMapper,
    this._userDataMapper,
    this._languageCodeDataMapper,
    this._tokenDataMapper,
    this._baseResponseDataMapper,
    this._imageUploadDataMapper,
    this._notificationDataMapper,
    this._amaiListStoreMapper,
    this._amaiOrderDataMapper,
    this._historyDataMapper,
    this._announcementDataMapper,
    this._wikitDataMapper,
    this._detailDataMapper,
    this._blogsDetailDataMapper,
    this._commentDataMapper,
    this._memberDataMapper,
    this._listBlogsDataMapper,
    this._listResourceDataMapper,
    this._popUpDonateMapper,
    this._qrcodeScanDataMapper,
  );
  final BlogsDetailDataMapper _blogsDetailDataMapper;
  final AppApiService _appApiService;
  final AppPreferences _appPreferences;
  final TokenDataMapper _tokenDataMapper;
  final BaseResponseDataMapper _baseResponseDataMapper;
  // final AppDatabase _appDatabase;
  final AnnouncementDataMapper _announcementDataMapper;
  final NotificationDataMapper _notificationDataMapper;
  final AnnounmentDataMapper _announmentDataMapper;
  final HistoryDataMapper _historyDataMapper;
  final PreferenceUserDataMapper _preferenceUserDataMapper;
  final UserDataMapper _userDataMapper;
  final AmaiListStoreMapper _amaiListStoreMapper;
  final LanguageCodeDataMapper _languageCodeDataMapper;
  final AmaiOrderDataMapper _amaiOrderDataMapper;
  final ImageUploadDataMapper _imageUploadDataMapper;
  final CommentDataMapper _commentDataMapper;
  final WikitDataMapper _wikitDataMapper;
  final WikiDetailDataMapper _detailDataMapper;
  final MemberDataMapper _memberDataMapper;
  final ListBlogsDataMapper _listBlogsDataMapper;
  final ListResourceDataMapper _listResourceDataMapper;
  final PopUpDonateMapper _popUpDonateMapper;
  final QrcodeScanDataMapper _qrcodeScanDataMapper;
  @override
  bool get isLoggedIn => _appPreferences.isLoggedIn;

  @override
  bool get isFirstLogin => _appPreferences.isFirstLogin;

  @override
  bool get isFirstLaunchApp => _appPreferences.isFirstLaunchApp;

  @override
  Stream<bool> get onConnectivityChanged =>
      Connectivity().onConnectivityChanged.map((event) => event != ConnectivityResult.none);

  @override
  bool get isDarkMode => _appPreferences.isDarkMode;

  @override
  LanguageCode get languageCode => _languageCodeDataMapper.mapToEntity(_appPreferences.languageCode);

  @override
  Future<bool> saveIsFirstLogin(bool isFirstLogin) {
    return _appPreferences.saveIsFirstLogin(isFirstLogin);
  }

  @override
  Future<bool> saveIsFirstLaunchApp(bool isFirstLaunchApp) {
    return _appPreferences.saveIsFirsLaunchApp(isFirstLaunchApp);
  }

  @override
  Future<Token> login(String email, String password) async {
    final response = await _appApiService.login(email, password);
    await _saveTokenAndUser(response.data);
    // ignore: newline-before-return
    return _tokenDataMapper.mapToEntity(response);
  }

  @override
  Future<BaseEntryData> logout() async {
    final out = await _appApiService.logout();
    // await _appPreferences.clearCurrentUserData();
    // ignore: newline-before-return
    return _baseResponseDataMapper.mapToEntity(out);
  }

  @override
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required Gender gender,
  }) async {
    // final response = await _appApiService.register(
    //   username: username,
    //   email: email,
    //   password: password,
    //   gender: _genderDataMapper.mapToData(gender),
    // );
    // await _saveTokenAndUser(response.);
  }

  @override
  Profile getUserPreference() => _preferenceUserDataMapper.mapToEntity(_appPreferences.currentUser);

  @override
  Future<void> clearCurrentUserData() => _appPreferences.clearCurrentUserData();

  @override
  Future<bool> saveDeviceToken(String deviceToken) => _appPreferences.saveDeviceToken(deviceToken);

  @override
  Future<PagedList<Profile>> getUsers({
    required int page,
    required int? limit,
  }) async {
    final response = await _appApiService.getUsers(page: page, limit: limit);

    return PagedList(data: []);
  }

  @override
  Future<bool> saveLanguageCode(LanguageCode languageCode) {
    return _appPreferences.saveLanguageCode(_languageCodeDataMapper.mapToData(languageCode));
  }

  @override
  Future<bool> saveIsDarkMode(bool isDarkMode) => _appPreferences.saveIsDarkMode(isDarkMode);

  @override
  Future<Profile> getMe() async {
    final response = await _appApiService.getMe();

    return _userDataMapper.mapToEntity(response.data);
  }

  Future<List<Object>> _saveTokenAndUser(TokenData? authData) async {
    return Future.wait([
      // _appPreferences.saveCurrentUser(PreferenceUserData(
      //   id: authData?.id ?? -1,
      //   email: authData?.email ?? '',
      // )),

      if (authData != null && !authData.accessToken.isNullOrEmpty)
        _appPreferences.saveAccessToken(authData.accessToken ?? ''),
    ]);
  }

  @override
  Future<BaseEntryData> forgotPassword(String email) async {
    final ouput = await _appApiService.forgotPassword(email);

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<BaseEntryData> updateMe(String avt, String about) async {
    final ouput = await _appApiService.updateMe(avt, about);

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<BaseEntryData> updateMeName(String name) async {
    final ouput = await _appApiService.updateMename(name);

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<ImageUpload> upLoadImage(File file, String type) async {
    final ouput = await _appApiService.uploadImage(file, type);

    return _imageUploadDataMapper.mapToEntity(ouput);
  }

  @override
  Future<PagedList<AppNotification>> getNotification({required int page, required int? limit}) async {
    final response = await _appApiService.getNotification(page: page, limit: limit);

    return PagedList(
      data: _notificationDataMapper.mapToListEntity(response.data?.data ?? []),
      perPage: response.data?.perPage,
      currentPage: response.data?.currentPage,
      total: response.data?.total,
      totalPage: response.data?.totalPage,
    );
  }

  @override
  Future<PagedList<AppNotification>> getNotificationUnread({required int page, required int? limit}) async {
    final response = await _appApiService.getNotificationUnread(page: page, limit: limit);

    return PagedList(
      data: _notificationDataMapper.mapToListEntity(response.data?.data ?? []),
      perPage: response.data?.perPage,
      currentPage: response.data?.currentPage,
      total: response.data?.total,
      totalPage: response.data?.totalPage,
    );
  }

  @override
  Future<BaseEntryData> getTotalNotificationUnread() async {
    final ouput = await _appApiService.getTotalNoti();

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<BaseEntryData> readNotification(String id) async {
    final ouput = await _appApiService.readNotifi(id);

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<BaseEntryData> paymentAmai(int amai, String note) async {
    final ouput = await _appApiService.payment(amai, note);

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<ListDataStoreEntry> getDataStore() async {
    final ouput = await _appApiService.getDataStore();

    return _amaiListStoreMapper.mapToEntity(ouput.data);
  }

  @override
  Future<BaseEntryData> deleteOrderStore() async {
    final ouput = await _appApiService.deleteOrderStore();

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<AmaiOrder> getOrderStore() async {
    final ouput = await _appApiService.getOrderStore();

    return _amaiOrderDataMapper.mapToEntity(ouput.data);
  }

  @override
  Future<BaseEntryData> orderStore(String id) async {
    final ouput = await _appApiService.orderStore(id);

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<List<HistoryAmai>> getHistory({required int page, required int? limit}) async {
    final response = await _appApiService.getHistoryData(page: page, limit: limit);

    return _historyDataMapper.mapToListEntity(response.data);
  }

  @override
  Future<AnnouncementDetail> getAnnouncementsDetail({required String slungs}) async {
    final response = await _appApiService.getAnnouncementDetail(slungs);

    return _announcementDataMapper.mapToEntity(response.data);
  }

  @override
  Future<BaseEntryData> resetPassword(
      {required String currentPass, required String newPass, required String confirmPassword}) async {
    final ouput = await _appApiService.resetPassword(pass: currentPass, newpass: newPass, password: confirmPassword);

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<BaseEntryData> readAllNotification() async {
    final ouput = await _appApiService.readAll();

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<PagedList<DataAnnoument>> getAnnounment({required int page, required int? limit}) async {
    final response = await _appApiService.getAnnounment(page: page, limit: limit);

    return PagedList(
      data: _announmentDataMapper.mapToListEntity(response.data?.data ?? []),
      perPage: response.data?.perPage,
      currentPage: response.data?.currentPage,
      total: response.data?.total,
      totalPage: response.data?.totalPage,
    );
  }

  @override
  Future<BaseEntryData> checkUserRead({required String slungs}) async {
    final ouput = await _appApiService.checkUserRead(slungs: slungs);

    return _baseResponseDataMapper.mapToEntity(ouput);
  }

  @override
  Future<WikiDetail> getDetailWiki({required String slungs}) async {
    final response = await _appApiService.getDetailWiki(slungs: slungs);

    return _detailDataMapper.mapToEntity(response.data);
  }

  @override
  Future<PagedList<DataWiki>> getWiki({required int page, required int? limit}) async {
    final response = await _appApiService.getListWiki(page: page, limit: limit);

    return PagedList(
      data: _wikitDataMapper.mapToListEntity(response.data?.data ?? []),
      perPage: response.data?.perPage,
      currentPage: response.data?.currentPage,
      total: response.data?.total,
      totalPage: response.data?.totalPage,
    );
  }

  @override
  Future<BlogsDetailEntry> getDetailBlogs({required String slungs}) async {
    final response = await _appApiService.getDetailBlogs(slungs: slungs);

    return _blogsDetailDataMapper.mapToEntity(response.data);
  }

  @override
  Future<List<ComentDataEntry>> getComents({required String slungs}) async {
    final response = await _appApiService.getComent(slungs);

    return _commentDataMapper.mapToListEntity(response.data);
  }

  @override
  Future<BaseEntryData> likeBlogs({required String slungs}) async {
    final response = await _appApiService.likeBlogs(slungs: slungs);

    return _baseResponseDataMapper.mapToEntity(response);
  }

  @override
  Future<BaseEntryData> likeComent({required String slungs, required int id}) async {
    final response = await _appApiService.likeComment(slungs: slungs, id: id);

    return _baseResponseDataMapper.mapToEntity(response);
  }

  @override
  Future<BaseEntryData> sendAmai({required String slungs}) async {
    final response = await _appApiService.sendAmai(slungs: slungs);

    return _baseResponseDataMapper.mapToEntity(response);
  }

  @override
  Future<PagedList<MemberDataEntry>> getListMember({required int page, required int? limit}) async {
    final response = await _appApiService.getMember(page: page, limit: limit);

    return PagedList(
      data: _memberDataMapper.mapToListEntity(response.data?.data ?? []),
      perPage: response.data?.perPage,
      currentPage: response.data?.currentPage,
      total: response.data?.total,
      totalPage: response.data?.totalPage,
    );
  }

  @override
  Future<PagedList<BlogsDataEntry>> getListPost({
    required int page,
    required int? limit,
    required String? categorySlug,
    required String? orderKey,
    required String? orderDir,
    required int? postType,
    required String? search,
  }) async {
    final response = await _appApiService.getListBlogs(
      page: page,
      limit: limit,
      categorySlug: categorySlug,
      orderKey: orderKey,
      orderDir: orderDir,
      postType: postType,
      search: search,
    );

    return PagedList(
      data: _listBlogsDataMapper.mapToEntity(response.data).blogs,
      perPage: response.data?.perPage,
      currentPage: response.data?.currentPage,
      total: response.data?.total,
      totalPage: response.data?.totalPage,
    );
  }

  @override
  Future<ResourceDataEntry> getResource(String type) async {
    final response = await _appApiService.getResource(type);

    return _listResourceDataMapper.mapToEntity(response.data);
  }

  @override
  Future<BaseEntryData> donateAmai(
      {required int receiveId, required int amountAmais, required int donateType, required String note}) async {
    final response = await _appApiService.donateAmai(receiveId, amountAmais, donateType, note);

    return _baseResponseDataMapper.mapToEntity(response);
  }

  @override
  Future<PopUpDonateEntry> getPopUpDonate() async {
    final response = await _appApiService.getPopUpdonate();

    return _popUpDonateMapper.mapToEntity(response.data);
  }

  @override
  Future<QrcodeScanDataEntry> qrCodeScan(String token) async {
    final response = await _appApiService.qrCodeScan(token);

    return _qrcodeScanDataMapper.mapToEntity(response.data);
  }
}
