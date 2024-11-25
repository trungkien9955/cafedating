import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/common/widgets/app_snackbar.dart';
import 'package:cafedating/features/loader/loader_notifier.dart';
import 'package:cafedating/features/register/notifer/register_notifier.dart';
import 'package:cafedating/features/register/notifer/register_state.dart';
import 'package:cafedating/features/register/repo/register_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterController {
  BuildContext context;
  WidgetRef ref;
  RegisterController({required this.context, required this.ref});
  Future<void> handleRegister() async {
    RegisterState registerState = ref.watch(registerNotifierProvider);
    var navContext = Navigator.of(ref.context);

    if (registerState.email.isEmpty) {
      AppSnackbar.showWarningMsg(context, 'Bạn cần nhập Email');
      return;
    }
    try {
      if (context.mounted) {
        AppDialog.showLoadingDialog(context, text: 'Đang xử lý...');
      }
      final credential = await RegisterRepo.firebaseRegister(
          registerState.email, registerState.password, registerState);
      if (credential.user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(registerState.name);
        // await credential.user?.updatePhotoURL(registerState.photoUrl);
        if (context.mounted) {
          AppDialog.hideLoadingDialog(context);
        }

        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text: 'Vui lòng xác nhận đăng ký tài khoản qua email',
              onClose: () {
            Navigator.of(context).pop();
          });
        }
      }
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (error.code == 'weak-password') {
        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text: 'Mật khẩu yếu.', onClose: () {});
        }
      } else if (error.code == 'email-already-in-use') {
        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text: 'Email đã được sử dụng.', onClose: () {});
        }
      }
      print('handle register ${error.toString()}');
    } catch (error) {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (context.mounted) {
        AppDialog.showSimpleDialog(context,
            text: 'Không thể đăng ký. Lỗi ứng dụng.', onClose: () {});
      }
      print('handle register ${error.toString()}');
    }
  }

  // Future<void> handleRegisterTest() async {
  //   try {
  //     await RegisterRepo.firebaseRegisterTest('email', 'password');
  //   } catch (error) {
  //     if (context.mounted) {
  //       AppSnackbar.showWarningMsg(context, 'Đã xảy ra lỗi');
  //     }
  //     print(error.toString());
  //   }
  // }
}
