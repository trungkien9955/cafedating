import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/common/widgets/app_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_secondary_text_button.dart';
import 'package:cafedating/core/common/widgets/app_text_label_large.dart';
import 'package:cafedating/core/common/widgets/app_textfield.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/login/controller/login_controller.dart';
import 'package:cafedating/features/login/notifier/login_notifier.dart';
import 'package:cafedating/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginData = ref.watch(loginNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Đăng nhập'),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    AppTextfield(
                      onChanged: (value) {
                        ref
                            .read(loginNotifierProvider.notifier)
                            .onEmailChange(value);
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextfield(
                      onChanged: (value) {
                        ref
                            .read(loginNotifierProvider.notifier)
                            .onPasswordChange(value);
                      },
                      hintText: 'Mật khẩu',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              AppFilledButton2(
                label: 'Đăng nhập',
                onPressed: () {
                  LoginController(ref: ref, context: context).handleLogin();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              // AppFilledButton2(
              //   label: 'Test',
              //   onPressed: () {
              //     // AppDialog.showLoadingDialog(context, text: 'Loading...');
              //     AppDialog.showSimpleDialog(context,
              //         text: 'Đăng nhập thành công', onClose: () {});
              //   },
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppTextLabelLarge(text: 'Chưa có tài khoản?'),
                  AppSecondaryTextButton(
                      label: 'Tạo tài khoản',
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
