import 'dart:io';

import '../../domain.dart';

abstract class Repository {
  bool get isLoggedIn;

  bool get isFirstLaunchApp;

  bool get isFirstLogin;

  bool get isDarkMode;

  LanguageCode get languageCode;

  Stream<bool> get onConnectivityChanged;

  Future<Token> login(String email, String password);

  Future<BaseEntryData> logout();

  Future<void> resetPassword({
    required String token,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<BaseEntryData> forgotPassword(String email);
  Future<BaseEntryData> updateMe(String avt, String about);
  Future<BaseEntryData> updateMeName(String name);
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required Gender gender,
  });

  Profile getUserPreference();

  Future<void> clearCurrentUserData();

  Future<bool> saveDeviceToken(String deviceToken);

  Future<bool> saveIsFirstLogin(bool isFirstLogin);

  Future<bool> saveIsFirstLaunchApp(bool isFirstLaunchApp);

  Future<PagedList<Profile>> getUsers({
    required int page,
    required int? limit,
  });

  Future<bool> saveIsDarkMode(bool isDarkMode);

  Future<bool> saveLanguageCode(LanguageCode languageCode);

  Future<Profile> getMe();

  Future<ImageUpload> upLoadImage(File file, String type);

  Future<PagedList<AppNotification>> getNotification({
    required int page,
    required int? limit,
  });

  Future<PagedList<AppNotification>> getNotificationUnread({
    required int page,
    required int? limit,
  });
  Future<BaseEntryData> getTotalNotificationUnread();
  Future<BaseEntryData> readNotification(String id);
  Future<BaseEntryData> paymentAmai(int amai, String note);
  Future<ListDataStoreEntry> getDataStore();

  Future<AmaiOrder> getOrderStore();

  Future<BaseEntryData> orderStore(String id);

  Future<BaseEntryData> deleteOrderStore();

  Future<HistoryAmaiList> getHistory({
    required int page,
    required int? limit,
  });
}