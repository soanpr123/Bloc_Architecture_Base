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

  Future<BaseEntryData> resetPassword({
    required String currentPass,
    required String newPass,
    required String confirmPassword,
  });
  Future<GetFcmTokenDataOutput> getFcmToken();
  Future<BaseEntryData> forgotPassword(String email);
  Future<BaseEntryData> updateMe(String avt, String about);
  Future<BaseEntryData> updateFcmToken(String fcmToken, String deviceType);
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
  Future<bool> saveFcmToken(String token);
  Future<bool> saveIsFirstLaunchApp(bool isFirstLaunchApp);
  Future<PagedList<BlogsDataEntry>> getListPost({
    required int page,
    required int? limit,
    required String? categorySlug,
    required String? orderKey,
    required String? orderDir,
    required int? postType,
    required String? search,
  });

  Future<ResourceDataEntry> getResource(String type);
  Future<PopUpDonateEntry> getPopUpDonate();
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
  Future<PagedList<DataAnnoument>> getAnnounment({
    required int page,
    required int? limit,
  });

  Future<PagedList<DataWiki>> getWiki({
    required int page,
    required int? limit,
  });

  Future<WikiDetail> getDetailWiki({
    required String slungs,
  });

  Future<PagedList<AppNotification>> getNotificationUnread({
    required int page,
    required int? limit,
  });
  Future<BaseEntryData> getTotalNotificationUnread();
  Future<BaseEntryData> readNotification(String id);
  Future<BaseEntryData> readAllNotification();
  Future<QrcodeScanDataEntry> qrCodeScan(String token);
  Future<BaseEntryData> paymentAmai(int amai, String note);
  Future<ListDataStoreEntry> getDataStore();

  Future<AmaiOrder> getOrderStore();

  Future<BaseEntryData> orderStore(String id);

  Future<BaseEntryData> deleteOrderStore();
  Future<BaseEntryData> createFeedback({required Map<String, dynamic> request});
  Future<List<HistoryAmai>> getHistory({
    required int page,
    required int? limit,
  });

  Future<AnnouncementDetail> getAnnouncementsDetail({
    required String slungs,
  });

  Future<BaseEntryData> checkUserRead({
    required String slungs,
  });

  Future<BlogsDetailEntry> getDetailBlogs({
    required String slungs,
  });
  Future<List<ComentDataEntry>> getComents({
    required String slungs,
  });
  Future<BaseEntryData> likeBlogs({
    required String slungs,
  });
  Future<BaseEntryData> likeComent({
    required String slungs,
    required int id,
  });
  Future<BaseEntryData> sendAmai({
    required String slungs,
  });
  Future<PagedList<MemberDataEntry>> getListMember({
    required int page,
    required int? limit,
  });
  Future<BaseEntryData> donateAmai({
    required int receiveId,
    required int amountAmais,
    required int donateType,
    required String note,
  });
  Future<BaseEntryData> createComent(String slugs, String comment);
  Future<BaseEntryData> createRepplyComent(String id, String slugs, String comment);
  Future<List<RankingDataEntry>> getLeaderboard();
}
