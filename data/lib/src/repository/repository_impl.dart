import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartx/dartx.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../data.dart';
import 'mapper/Announcement_detail_mapper.dart';
import 'mapper/base_response_mapper.dart';
import 'mapper/data_history_mapper.dart';
import 'mapper/data_list_store_mapper.dart';
import 'mapper/list_data_history_mapper.dart';
import 'mapper/order_data_mapper.dart';
import 'mapper/upload_image_mapper.dart';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  RepositoryImpl(
    this._appApiService,
    this._appPreferences,
    // this._appDatabase,
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
  );

  final AppApiService _appApiService;
  final AppPreferences _appPreferences;
  final TokenDataMapper _tokenDataMapper;
  final BaseResponseDataMapper _baseResponseDataMapper;
  // final AppDatabase _appDatabase;
  final AnnouncementDataMapper _announcementDataMapper;
  final NotificationDataMapper _notificationDataMapper;
  final HistoryDataMapper _historyDataMapper;
  final PreferenceUserDataMapper _preferenceUserDataMapper;
  final UserDataMapper _userDataMapper;
  final AmaiListStoreMapper _amaiListStoreMapper;
  final LanguageCodeDataMapper _languageCodeDataMapper;
  final AmaiOrderDataMapper _amaiOrderDataMapper;
  final ImageUploadDataMapper _imageUploadDataMapper;
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
}
