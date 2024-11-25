import 'dart:convert';
import 'dart:io';

import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/register/notifer/register_state.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/user_model.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterRepo {
  static Future<UserCredential> firebaseRegister(
      String email, String password, RegisterState registerData) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    // LoginRequestEntity loginRequestEntity = LoginRequestEntity(
    //     uid: credential.user?.uid, email: credential.user?.email);
    String api = '${AppConstants.serverAddress}/users/register';
    await AppDio().post(api,
        data: {'data': registerData.toMap()},
        queryParameters: {'uid': credential.user?.uid});
    return credential;
  }

  // static Future<String> firebaseRegisterTest(
  //     String email, String password) async {
  //   // await Global.storageService.setString(AppConstants.userToken, 'abc');
  //   var userToken = Global.storageService.getString(AppConstants.userUid);
  //   print(userToken);

  //   LoginRequestEntity loginRequestEntity = LoginRequestEntity();
  //   loginRequestEntity.email = "trungkien2411@gmail.com";
  //   final FormData form =
  //       FormData.fromMap({"mobile": "phone", "status": "status"});
  //   await AppDio().post('/users/register',
  //       data:
  //           jsonEncode({'uid': userToken, 'email': loginRequestEntity.email}));
  //   // const String api = AppConstants.serverAddress;
  //   // await Dio().post('$api/users/register', data: {"uid": "abc"});

  //   return 'credential';
  // }
}
