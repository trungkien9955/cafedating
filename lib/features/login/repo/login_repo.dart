import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/models/user_model.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo {
  static Future<UserCredential> firebaseLogin(
      String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential;
  }

  static Future<LoginResponseEntity> fetchLoginData(
      {LoginRequestEntity? params}) async {
    String api = '${AppConstants.serverAddress}/users/login';
    Response response =
        await AppDio().post(api, queryParameters: params?.toMap());
    return LoginResponseEntity.fromJson(response.data);
  }
}
