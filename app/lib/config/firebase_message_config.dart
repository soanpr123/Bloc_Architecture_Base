import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:domain/domain.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}

@Injectable()
class FirebaseMessageConfig {
  factory FirebaseMessageConfig() => _messageConfig;
  FirebaseMessageConfig._internal();
  static final FirebaseMessageConfig _messageConfig = FirebaseMessageConfig._internal();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const String darwinNotificationCategoryText = 'textCategory';
  static const String darwinNotificationCategoryPlain = 'plainCategory';
  static const String urlLaunchActionId = 'id_1';
  static const String navigationActionId = 'id_3';

  final AndroidNotificationChannel _androidNotificationChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
    enableLights: true,
    enableVibration: true,
    playSound: true,
    showBadge: true,
  );

  Future<void> initFirebaseMessageConfig() async {
    await _initFirebaseMessaging();
    await _initLocalNotification();
  }

  Future<void> _initFirebaseMessaging() async {
    try {
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      // Hiển thị notification khi bật app cho ios
      if (Platform.isIOS) {
        await _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
      await _firebaseMessaging.setAutoInitEnabled(true);

      await _handleTokenFirebase();
    } catch (e) {
      // debugPrint('init firebaseMessaging error $e');
      Log.e('init firebaseMessaging error $e', name: 'FirebaseMessageConfig');
    }
  }

  Future<void> _initLocalNotification() async {
    try {
      // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      //     !kIsWeb && Platform.isLinux ? null : await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
      // String initialRoute = SplashRoute.name;

      //      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      //   selectedNotificationPayload = notificationAppLaunchDetails!.notificationResponse?.payload;
      //   initialRoute = SecondPage.routeName;
      // }
      const initialzationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
      final List<DarwinNotificationCategory> darwinNotificationCategories = <DarwinNotificationCategory>[
        DarwinNotificationCategory(
          darwinNotificationCategoryText,
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.text(
              'text_1',
              'Action 1',
              buttonTitle: 'Send',
              placeholder: 'Placeholder',
            ),
          ],
        ),
        DarwinNotificationCategory(
          darwinNotificationCategoryPlain,
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain(
              'id_2',
              'Action 2 (destructive)',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            ),
            DarwinNotificationAction.plain(
              navigationActionId,
              'Action 3 (foreground)',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
            DarwinNotificationAction.plain(
              'id_4',
              'Action 4 (auth required)',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.authenticationRequired,
              },
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        ),
      ];
      final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
          // didReceiveLocalNotificationStream.add(
          //   ReceivedNotification(
          //     id: id,
          //     title: title,
          //     body: body,
          //     payload: payload,
          //   ),
          // );
        },
        notificationCategories: darwinNotificationCategories,
      );
      final initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
          switch (notificationResponse.notificationResponseType) {
            case NotificationResponseType.selectedNotification:
              Log.d(
                'selectNotificationStream.add(notificationResponse.payload) ${notificationResponse.payload}',
                name: 'FirebaseMessageConfig',
              );
              // selectNotificationStream.add(notificationResponse.payload);
              break;
            case NotificationResponseType.selectedNotificationAction:
              if (notificationResponse.actionId == navigationActionId) {
                Log.d(
                  'selectNotificationStream.add(notificationResponse.payload) action ${notificationResponse.payload}',
                  name: 'FirebaseMessageConfig',
                );

                // selectNotificationStream.add(notificationResponse.payload);
              }
              break;
          }
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );

      if (Platform.isIOS) {
        await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
      } else if (Platform.isAndroid) {
        await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(_androidNotificationChannel);
      }
    } catch (e) {
      Log.e('initLocalNotification---> error $e', name: 'FirebaseMessageConfig');
    }
  }

  Future<void> handleMessage() async {
    try {
      /// Lấy tất cả thông báo khiến ứng dụng mở từ terminated state
      /// Một khi lấy ra thông báo để điều hướng, nó sẽ bị remove
      /// Tương tác với thông báo khi ứng dụng đang ở terminated
      final initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        Log.d('click open app ${initialMessage.data} ', name: 'initialMessage FirebaseCongig');
        if (initialMessage.data.isNotEmpty) {
          Log.d('click open app ${initialMessage.data}', name: 'initialMessage.data.isNotEmpty FirebaseCongig');

          /// ['id']: Key json chứa ID của thông báo server trả về.
          /// Dùng để điều hướng vào màn chi tiết thông báo
          /// Mặc định đang là ['id']
          // Navigator.of(AppConfig.navigatorKey.currentContext).pushNamed(
          //   DetailNotificationScreen.routeName,
          //   arguments: int.tryParse(
          //     initialMessage?.data['id']?.toString(),
          //   ),
          // );
        }
      }

      /// Khi đang mở ứng dụng, thông báo Firebase sẽ vào hàm onMessage
      /// Android sẽ block toàn bộ thông báo đẩy, cần cấu hình thêm thư viện flutter_local_notifications để hiển thị thông báo cũng như tương tác thông báo
      /// IOS cần call hàm setForegroundNotificationPresentationOptions để nhận thông báo khi đang mở ứng dụng
      FirebaseMessaging.onMessage.listen(showNotification);

      /// Tương tác với thông báo khi ứng dụng đang ở background và khi đang khóa màn hình
      ///
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
          Log.d('click open app ${message.data}', name: 'onMessageOpenedApp');

          /// ['id']: Key json chứa ID của thông báo server trả về.
          /// Dùng để điều hướng vào màn chi tiết thông báo
          /// Mặc định đang là ['id']
          if (message.data.isNotEmpty) {
            // Navigator.of(AppConfig.navigatorKey.currentContext).pushNamed(
            //   DetailNotificationScreen.routeName,
            //   arguments: int.tryParse(
            //     message?.data['id']?.toString(),
            //   ),
            // );
          }
        },
      );
    } catch (e) {
      Log.e(' handle message error $e', name: 'HandleMessengerErr');
    }
  }

  void showNotification(RemoteMessage message) {
    Log.d('Got a message whilst in the foreground!', name: 'showNotification');
    Log.d('Message data: ${message.notification?.body}', name: 'showNotification with data');

    try {
      final remoteNotification = message.notification;
      final android = message.notification?.android;

      if (remoteNotification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
          remoteNotification.hashCode,
          remoteNotification.title,
          remoteNotification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidNotificationChannel.id,
              _androidNotificationChannel.name,
              importance: Importance.high,
              visibility: NotificationVisibility.public,
              priority: Priority.high,
              playSound: true,
              enableLights: true,
              enableVibration: true,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              subtitle: '',
            ),
          ),
          payload: json.encode(message.data),
        );
      }
    } catch (e) {
      debugPrint('FirebaseMessageConfig $e');
    }
  }

  Future<void> resetDeviceToken() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<void> _handleTokenFirebase() async {
    await _firebaseMessaging.getToken().then((String? token) async {
      Log.d('FIREBASE TOKEN: $token', name: 'FirebaseConfig');
      if (token != null) {
        await saveFcmToken(token);
      }
    });
    _firebaseMessaging.onTokenRefresh.listen((token) async {
      Log.d('TOKEN FIREBASE CHANGE: $token', name: 'FirebaseConfig');
      await saveFcmToken(token);
    });
  }

  Future saveFcmToken(String tokenFcm) async {
    final result = await GetIt.instance.get<GetFcmTokenUseCase>().execute(const GetFcmTokenDataInput());
    Log.d('token in data store local ${result.token}', name: 'UpdateFcmToLocal');

    if (result.token.isEmpty || result.token != tokenFcm) {
      // Token chưa được lưu hoặc khác với token lấy ra từ Firebase -> cập nhật token mới

      final result = await updateFcmToken(tokenFcm);
      if (result.data != null && result.data['status_code'] == 200) {
        runCatching(
          action: () => GetIt.instance.get<SaveTokenFcmUseCase>().execute(SaveTokenFcmInput(tokenFcm: tokenFcm)),
        );
      }
    } else {
      Log.d('token already exists store local ${result.token}', name: 'UpdateFcmToLocal');
    }
  }

  Future<BaseEntryData> updateFcmToken(String tokenFcm) async {
    final result = runCatching(
      action: () => GetIt.instance
          .get<UpdateFcmTokenUseCase>()
          .execute(UpdateFcmTokenInput(fcmToken: tokenFcm, deviceType: Platform.isIOS ? 'ios' : 'android')),
    );

    return result.when(
      success: (output) => output,
      failure: (exception) {
        Log.e('Token upload to server error $exception', name: 'updateFcmToken');

        return const BaseEntryData();
      },
    );
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
