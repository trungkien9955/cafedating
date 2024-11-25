import 'package:cafedating/core/common/widgets/app_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_loader.dart';
import 'package:cafedating/core/common/widgets/app_text_body_small.dart';
import 'package:cafedating/core/common/widgets/app_text_label_medium.dart';
import 'package:cafedating/core/common/widgets/app_textfield.dart';
import 'package:cafedating/core/common/widgets/app_tip.dart';
import 'package:cafedating/features/loader/loader_notifier.dart';
import 'package:cafedating/features/login/notifier/login_notifier.dart';
import 'package:cafedating/features/register/controller/register_controller.dart';
import 'package:cafedating/features/register/notifer/register_notifier.dart';
import 'package:cafedating/features/search/provider/async_cities.dart';
import 'package:cafedating/models/search/search_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerData = ref.watch(registerNotifierProvider);
    final AsyncValue<List<City>> asyncCitiesData =
        ref.watch(asyncCitiesProvider);
    final isLoading = ref.watch(loaderNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký'),
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextfield(
                          onChanged: (value) {
                            ref
                                .read(registerNotifierProvider.notifier)
                                .onEmailChange(value);
                          },
                          hintText: 'Email',
                          prefixIcon: const Icon(
                            Icons.mail,
                            size: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AppTextfield(
                          onChanged: (value) {
                            ref
                                .read(registerNotifierProvider.notifier)
                                .onPasswordChange(value);
                          },
                          hintText: 'Mật khẩu',
                          prefixIcon: const Icon(Icons.lock, size: 16),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AppTextfield(
                          onChanged: (value) {
                            ref
                                .read(registerNotifierProvider.notifier)
                                .onRepasswordChange(value);
                          },
                          hintText: 'Nhập lại mật khẩu',
                          prefixIcon: const Icon(Icons.lock_open, size: 16),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AppTextfield(
                          onChanged: (value) {
                            ref
                                .read(registerNotifierProvider.notifier)
                                .onNameChange(value);
                          },
                          hintText: 'Tên hiển thị',
                          prefixIcon: const Icon(Icons.person, size: 16),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DropdownMenu(
                            label: AppTextLabelMedium(text: 'Giới tính'),
                            onSelected: (value) {
                              ref
                                  .read(registerNotifierProvider.notifier)
                                  .onGenderChange(value!);
                            },
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(value: 'male', label: 'Nam'),
                              DropdownMenuEntry(value: 'female', label: 'Nữ'),
                            ]),
                        const SizedBox(
                          height: 8,
                        ),
                        switch (asyncCitiesData) {
                          AsyncData(:final value) => DropdownMenu(
                              label:
                                  const AppTextLabelMedium(text: 'Thành phố'),
                              menuHeight: 300,
                              onSelected: (value) {
                                ref
                                    .read(registerNotifierProvider.notifier)
                                    .onCityIdChange(value!);
                              },
                              dropdownMenuEntries: value.map((item) {
                                return DropdownMenuEntry(
                                    value: item.id, label: item.name);
                              }).toList()),
                          AsyncError(:final error, :final stackTrace) =>
                            Text(error.toString()),
                          _ => const SizedBox.shrink()
                        },
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppFilledButton2(
                    label: 'Đăng ký',
                    onPressed: () {
                      // RegisterController(ref: ref, buildContext: context)
                      //     .handleRegister();
                      RegisterController(context: context, ref: ref)
                          .handleRegister();
                    },
                  ),
                ],
              ),
            )
          : const AppLoader(),
    );
  }
}
