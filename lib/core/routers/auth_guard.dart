import 'package:auto_route/auto_route.dart';
// import 'package:example/mobile/router/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project/core/routers/router.gr.dart';

// mock auth state

var isAuthenticated = false;

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final tokenBox = GetIt.I<Box<String>>();
    final isLogin = tokenBox.get('token', defaultValue: "");
    print(isLogin);
    if (isLogin != "") {
      print("object");
      resolver.next(true); // book was found. proceed to the page
    } else {
      router.push(LoginRoute());
    }
  }
}

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}
