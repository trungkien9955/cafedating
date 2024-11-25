import 'package:cafedating/core/common/widgets/app_card.dart';
import 'package:cafedating/core/common/widgets/app_card_with_badge.dart';
import 'package:cafedating/core/common/widgets/app_card_with_button.dart';
import 'package:cafedating/core/common/widgets/app_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_loader.dart';
import 'package:cafedating/core/common/widgets/app_secondary_text_button.dart';
import 'package:cafedating/core/common/widgets/app_small_width_spacer.dart';
import 'package:cafedating/core/common/widgets/app_text.dart';
import 'package:cafedating/core/common/widgets/app_text_display_large.dart';
import 'package:cafedating/core/common/widgets/app_text_headline_large.dart';
import 'package:cafedating/core/common/widgets/app_text_headline_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_label_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_label_small.dart';
import 'package:cafedating/core/common/widgets/interest_chip.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/login/controller/login_controller.dart';
import 'package:cafedating/features/profile/controller/profile_controller.dart';
import 'package:cafedating/features/profile/notifier/college/async_college.dart';
import 'package:cafedating/features/profile/notifier/interests/async_profile_interests.dart';
import 'package:cafedating/features/profile/notifier/photo/async_photo_url.dart';
import 'package:cafedating/features/profile/widgets/interest_selection.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/college.dart';
import 'package:cafedating/models/interest.dart';
import 'package:cafedating/routers/route_names.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Interest>> interestsData =
        ref.watch(asyncProfileInterestsProvider);
    final AsyncValue<College> collegeData = ref.watch(asyncCollegeProvider);
    final AsyncValue<String> asyncphotoUrlData =
        ref.watch(asyncPhotoUrlProvider);
    String userId =
        Global.storageService.getString(AppConstants.userId).toString();
    print(userId);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Text('Profile'),
        //     ],
        //   ),
        //   centerTitle: true,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: switch (asyncphotoUrlData) {
                    AsyncData(:final value) => Stack(
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(value),
                          ),
                          Positioned(
                              right: 15,
                              bottom: 10,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                          context, RouteNames.profileImage)
                                      .then((value) {
                                    ref.refresh(asyncPhotoUrlProvider);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(90.0),
                                      color: AppTheme.primaryColor),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    AsyncError() => Stack(
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: AssetImage(
                                '${AppConstants.imageUrl}/default-avatar.png'),
                          ),
                          Positioned(
                              right: 20,
                              bottom: 10,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                          context, RouteNames.profileImage)
                                      .then((value) {
                                    ref.refresh(asyncPhotoUrlProvider);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(90.0),
                                      color: AppTheme.primaryContainerColor),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    _ => SizedBox.shrink()
                  },
                ),
                // AppFilledButton2(
                //   label: 'logout',
                //   onPressed: () {
                //     LoginController(context: context, ref: ref).handleLogout();
                //   },
                // ),
                const AppCardWithButton(
                    bgColor: Colors.transparent,
                    buttonLabel: 'Thay đổi',
                    child: AppTextHeadlineMedium(text: 'Ngoc Phuong Trang')),
                const AppCardWithButton(
                  buttonLabel: 'Thay đổi',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.edit_square),
                      AppSmallWidthSpacer(),
                      Expanded(
                          child: Text(
                              'Chỉ mất 3 giây để nói lời yêu, nhưng phải mất cả cuộc đời để chứng minh điều đó.')),
                    ],
                  ),
                ),
                AppCardWithButton(
                  buttonLabel: 'Thay đổi',
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      SizedBox(
                        width: 8,
                      ),
                      switch (collegeData) {
                        AsyncData(:final value) => Text('Đống Đa, Hà Nội'),
                        AsyncError(:final error, :final stackTrace) => Expanded(
                            child: Text(
                                'Chưa có thông tin ${error.toString} $stackTrace')),
                        _ => const AppLoader()
                      }
                    ],
                  ),
                ),
                AppCardWithButton(
                  buttonLabel: 'Thay đổi',
                  child: Row(
                    children: [
                      Icon(Icons.house),
                      SizedBox(
                        width: 8,
                      ),
                      switch (collegeData) {
                        AsyncData(:final value) => Text(
                            'Hưng Yên',
                          ),
                        AsyncError(:final error, :final stackTrace) => Expanded(
                            child: Text(
                                'Chưa chọn ${error.toString} $stackTrace')),
                        _ => const AppLoader()
                      }
                    ],
                  ),
                ),
                AppCardWithButton(
                  buttonLabel: 'Thay đổi',
                  child: Row(
                    children: [
                      Icon(Icons.school),
                      SizedBox(
                        width: 8,
                      ),
                      switch (collegeData) {
                        AsyncData(:final value) => Text(
                            value.name,
                          ),
                        AsyncError(:final error, :final stackTrace) => Expanded(
                            child: Text(
                                'Chưa chọn ${error.toString} $stackTrace')),
                        _ => const AppLoader()
                      }
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      switch (interestsData) {
                        AsyncData(:final value) => AppCardWithButton(
                            buttonLabel: 'Thay đổi',
                            onIconPressed: () {
                              Navigator.pushNamed(context, '/interests').then(
                                  (value) => {
                                        ref.refresh(
                                            asyncProfileInterestsProvider)
                                      });
                            },
                            child: Container(
                              // decoration: BoxDecoration(color: Colors.pink),
                              // padding: EdgeInsets.all(8.0),
                              width: double.infinity,
                              child: Wrap(
                                  runSpacing: 0,
                                  children: value
                                      .map((item) => InterestChip(
                                          name: item.name, type: item.type))
                                      .toList()),
                            ),
                          ),
                        AsyncError() =>
                          const Center(child: Text('Không thể tải sở thích')),
                        _ => const Center(child: AppLoader())
                      }
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
