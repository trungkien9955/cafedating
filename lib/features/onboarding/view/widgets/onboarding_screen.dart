import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_height_spacer.dart';
import 'package:cafedating/core/common/widgets/app_text_body_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_body_small.dart';
import 'package:cafedating/core/common/widgets/app_text_display_large.dart';
import 'package:cafedating/core/common/widgets/app_text_headline_large.dart';
import 'package:cafedating/core/common/widgets/app_text_title_large.dart';
import 'package:cafedating/core/common/widgets/app_text_title_medium.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/global.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController controller;
  final String imagePath;
  final String title;
  final String subTitle;
  final int index;
  const OnboardingScreen(
      {super.key,
      required this.controller,
      required this.imagePath,
      required this.title,
      required this.subTitle,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const AppHeightSpacer(height: 150),
          Container(
            width: 360,
            height: 360,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imagePath)),
                shape: BoxShape.circle),
          ),
          // Image.asset(imagePath),
          const AppHeightSpacer(height: 24),
          AppTextHeadlineLarge(text: title),
          Center(child: AppTextBodyMedium(text: subTitle)),
          const SizedBox(
            height: 36,
          ),
          _nextButton(index, controller, context),
          AppHeightSpacer(height: 24)
        ],
      ),
    );
  }
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return AppFilledButton2(
    label: 'Tiếp theo',
    onPressed: () {
      if (index < 3) {
        controller.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        print(AppConstants.firstTimeOnThisDevice);
        Global.storageService.setBool(AppConstants.firstTimeOnThisDevice, true);
        Navigator.pushNamed(context, '/login');
      }
    },
  );
}
