import 'package:cafedating/core/common/widgets/app_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_loader.dart';
import 'package:cafedating/core/common/widgets/app_text_button.dart';
import 'package:cafedating/core/common/widgets/app_text_label_medium.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static AppDialog _instance = AppDialog.internal();

  AppDialog.internal();

  factory AppDialog() => _instance;
  static showSuccessDialog(BuildContext context,
      {required String title,
      required String subtitle,
      required VoidCallback onClose}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: [
                AppFilledButton(
                    label: 'OK',
                    hasIcon: false,
                    onPressed: () => Navigator.pop(context))
              ]);
        }).then((value) => {onClose()});
  }

  static void showLoadingDialog(BuildContext context,
      {required String text, VoidCallback? onClose}) {
    showDialog(
        context: context,
        builder: (_) {
          return const Dialog.fullscreen(
            // backgroundColor: Colors.grey.withOpacity(.3),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLoader(),
                  SizedBox(
                    height: 16,
                  ),
                  AppTextLabelMedium(text: 'Loading...')
                ],
              ),
            ),
          );
        }).then((value) => onClose);
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showSimpleDialog(BuildContext context,
      {required String text, required VoidCallback onClose}) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            // backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextLabelMedium(text: text),
                  AppTextButton(
                      label: 'OK',
                      onPress: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),
            ),
          );
        }).then((value) {
      onClose();
    });
  }
}
