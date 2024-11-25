import 'dart:convert';

import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/common/widgets/app_snackbar.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/loader/loader_notifier.dart';
import 'package:cafedating/features/login/notifier/login_notifier.dart';
import 'package:cafedating/features/login/repo/login_repo.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/user_model.dart';
import 'package:cafedating/routers/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController {
  WidgetRef ref;
  BuildContext context;
  LoginController({required this.ref, required this.context});
  Future<void> handleLogin() async {
    var loginState = ref.read(loginNotifierProvider);
    if (loginState.email.isEmpty) {
      if (context.mounted) {
        AppSnackbar.showWarningMsg(context, 'Bạn cần nhập Email');
      }
      return;
    }
    if (loginState.password.isEmpty) {
      if (context.mounted) {
        AppSnackbar.showWarningMsg(context, 'Bạn cần nhập mật khẩu');
      }
      return;
    }
    try {
      if (context.mounted) {
        AppDialog.showLoadingDialog(context, text: 'Đang đăng nhập ...');
      }
      final credential =
          await LoginRepo.firebaseLogin(loginState.email, loginState.password);
      if (credential.user != null) {
        LoginRequestEntity loginRequestEntity = LoginRequestEntity();
        loginRequestEntity.email = credential.user?.email;
        await Global.storageService
            .setString(AppConstants.userUid, credential.user!.uid);
        fetchLoginData(loginRequestEntity);
      }
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (error.code == 'user-not-found') {
        if (context.mounted) {
          AppSnackbar.showWarningMsg(context, 'Email chưa được đăng ký');
        }
      }
    } catch (error) {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (context.mounted) {
        AppSnackbar.showWarningMsg(context, 'Đã xảy ra lỗi');
      }
    }
  }

  Future<void> handleLogout() async {
    if (context.mounted) {
      Navigator.of(ref.context)
          .pushNamedAndRemoveUntil('/login', (route) => false);
    }
    await FirebaseAuth.instance.signOut();
    await Global.storageService.clear();
  }

  void fetchLoginData(LoginRequestEntity loginRequestEntity) async {
    var response = await LoginRepo.fetchLoginData(params: loginRequestEntity);
    if (response.code == 200) {
      try {
        print('login controller ${response.userData}');
        Global.storageService.setString(
            AppConstants.userProfileId, jsonEncode(response.userData?.uid));
        Global.storageService
            .setString(AppConstants.userProfile, jsonEncode(response.userData));
        Global.storageService
            .setString(AppConstants.userId, response.userData?.id ?? '');
        Global.storageService.setString(
            AppConstants.userUid, jsonEncode(response.userData?.accessToken));
        if (context.mounted) {
          Navigator.of(ref.context).pushNamedAndRemoveUntil(
              RouteNames.requestLocationPermisison, (route) => false);
        }
      } catch (error) {
        if (context.mounted) {
          AppDialog.hideLoadingDialog(context);
        }
        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text: 'Không thể đăng ký. Lỗi ứng dụng.', onClose: () {});
        }
      }
    } else {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (context.mounted) {
        AppDialog.showSimpleDialog(context,
            text: 'Không thể đăng ký. Lỗi ứng dụng.', onClose: () {});
      }
    }
  }
}
