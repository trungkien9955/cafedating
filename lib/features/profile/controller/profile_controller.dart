import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/loader/loader_notifier.dart';
import 'package:cafedating/features/profile/notifier/college/selected_college_id_notifier.dart';
import 'package:cafedating/features/profile/notifier/selected_interests_notifier.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController {
  WidgetRef ref;
  BuildContext buildContext;
  ProfileController({required this.ref, required this.buildContext});
  Future<List<String>> fetchUserInterests() async {
    String userId =
        Global.storageService.getString(AppConstants.userId).toString();
    String api = '${AppConstants.serverAddress}/users/selected-interests';
    Response response =
        await AppDio().post(api, queryParameters: {"userId": userId});
    // List<Interest> selectedInterests = List<Interest>.from(
    //     response.data['data'].map((item) => Interest.fromMap(item)));
    // List<String> selectedInterestIds = [];
    // response.data['data'].map((item) => selectedInterestIds.add(item.id));
    List<String> selectedInterestIds = [];
    response.data['data'].map((item) => selectedInterestIds.add(item));
    print('async user interests ${response.data['data']}');
    return selectedInterestIds;
  }

  Future<void> updatedSelectedInterests() async {
    String api =
        '${AppConstants.serverAddress}/users/update-selected-interests';
    List<String> selectedInterests =
        ref.read(selectedInterestsNotifierProvider);
    String userId = Global.storageService.getString(AppConstants.userId);
    print(selectedInterests);
    ref.read(loaderNotifierProvider.notifier).setLoader(true);
    try {
      Response response = await AppDio().post(api,
          data: selectedInterests, queryParameters: {"userId": userId});
      if (response.statusCode == 200) {
        List<String> interests = List<String>.from(
            response.data['data'].map((item) => item.toString()));
        ref
            .read(selectedInterestsNotifierProvider.notifier)
            .updateInitialSelectedInterests(interests);
        if (buildContext.mounted) {
          AppDialog.showSuccessDialog(buildContext,
              title: '', subtitle: 'Đã cập nhật sở thích', onClose: () {});
        }
      }
      ref.read(loaderNotifierProvider.notifier).setLoader(true);
    } catch (error) {
      ref.read(loaderNotifierProvider.notifier).setLoader(true);

      if (buildContext.mounted) {
        AppDialog.showSuccessDialog(buildContext,
            title: '', subtitle: 'Không thể cập nhật sở thích', onClose: () {});
      }
      print(error.toString());
    }
  }

  void updateCollege() {
    final collegeId = ref.read(selectedCollegeIdNotifierProvider);
    if (buildContext.mounted) {
      AppDialog.showLoadingDialog(buildContext,
          text: 'Đang cập nhật dữ liệu ...');
    }
    Future.delayed(Duration(seconds: 3), () async {
      String api = '${AppConstants.serverAddress}/users/update-college';
      String userId = Global.storageService.getString(AppConstants.userId);

      try {
        Response response = await AppDio().post(api,
            data: {'collegeId': collegeId},
            queryParameters: {'userId': userId});
        if (response.statusCode == 200) {
          if (buildContext.mounted) {
            Navigator.of(buildContext).pop();
          }
          if (buildContext.mounted) {
            AppDialog.showSuccessDialog(buildContext,
                title: 'Thành công',
                subtitle: 'Đã cập nhật trường học', onClose: () {
              Navigator.of(buildContext).pop();
            });
          }
        }
      } on DioException catch (e) {
        print('update college error data ${e.response!.data}');
        if (buildContext.mounted) {
          Navigator.of(buildContext).pop();
        }
        if (buildContext.mounted) {
          AppDialog.showSuccessDialog(buildContext,
              title: 'Lỗi server',
              subtitle: e.response!.data['msg'] ?? '',
              onClose: () {});
        }
      } catch (error) {
        if (buildContext.mounted) {
          AppDialog.hideLoadingDialog(buildContext);
        }
        if (buildContext.mounted) {
          AppDialog.showSuccessDialog(buildContext,
              title: 'Lỗi ứng dụng',
              subtitle: 'Không thể cập nhật trường học',
              onClose: () {});
        }
      }
    });
  }

  void changeName(String newName) async {
    String api = '${AppConstants.serverAddress}/users/change-name';
    String userId =
        Global.storageService.getString(AppConstants.userId).toString();
    if (buildContext.mounted) {
      AppDialog.showLoadingDialog(buildContext, text: 'Đang đổi tên');
    }
    try {
      await Future.delayed(const Duration(seconds: 3));
      Response response = await AppDio().post(api,
          data: {'newName': newName}, queryParameters: {'userId': userId});
      if (response.statusCode == 200) {
        if (buildContext.mounted) {
          AppDialog.hideLoadingDialog(buildContext);
        }
        if (buildContext.mounted) {
          AppDialog.showSimpleDialog(buildContext, text: 'Đã đổi tên',
              onClose: () {
            Navigator.of(buildContext).pop();
          });
        }
      }
    } on DioException catch (error) {
      if (buildContext.mounted) {
        AppDialog.hideLoadingDialog(buildContext);
      }
      if (buildContext.mounted) {
        AppDialog.showSimpleDialog(buildContext,
            text: 'Lỗi server. ${error.response?.data['msg']}', onClose: () {
          Navigator.of(buildContext).pop();
        });
      }
    } catch (error) {
      if (buildContext.mounted) {
        AppDialog.hideLoadingDialog(buildContext);
      }
      if (buildContext.mounted) {
        AppDialog.showSimpleDialog(buildContext, text: 'Lỗi hệ thống',
            onClose: () {
          Navigator.of(buildContext).pop();
        });
      }
    }
  }

  //check camera permmission
  void checkCameraPermission() async {
    await Permission.camera.onDeniedCallback(() {
      print('denied');
    }).onGrantedCallback(() {
      print('granted');
    }).onPermanentlyDeniedCallback(() {
      // Your code
      print('permanently denied');
    }).onRestrictedCallback(() {
      // Your code
      print('restricted');
    }).onLimitedCallback(() {
      // Your code
      print('limited');
    }).onProvisionalCallback(() {
      // Your code
      print('provisional');
    }).request();
  }
}
