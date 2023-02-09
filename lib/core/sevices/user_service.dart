import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project/core/sevices/globals.dart' as globals;
import 'package:project/core/utils/constants.dart';

class UserService {
  static final UserService instance = UserService._();
  factory UserService() => instance;
  UserService._();

  final tokenBox = GetIt.I<Box<String>>();

  Future<void> setCurrentToken(String token) async {
    globals.accessToken = token;
    await tokenBox.put(StorageBox.currentToken, token);
  }
}
