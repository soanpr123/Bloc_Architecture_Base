import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project/core/routers/router.dart';

part 'spalsh_state.dart';

class SpalshCubit extends Cubit<SpalshState> {
  SpalshCubit() : super(SpalshInitial());
  final tokenBox = GetIt.I<Box<String>>();
  Future<void> loadShowApp(BuildContext context) async {
    String isLogin = tokenBox.get('token', defaultValue: "").toString();

    if (isLogin.isEmpty) {
      context.router.popAndPush(const MainRoute());
    } else {
      context.router.popAndPush(LoginRoute());
    }
  }
}
