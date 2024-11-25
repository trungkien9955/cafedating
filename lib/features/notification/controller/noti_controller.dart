import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/notification/provider/async_notis.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotiController {
  BuildContext context;
  WidgetRef ref;
  NotiController({required this.context, required this.ref});
  void markNotiAsRead(String id) async {
    String api = '${AppConstants.serverAddress}/users/mark-noti-as-read';
    Response response = await AppDio().post(api, queryParameters: {'id': id});
    if (response.statusCode == 200) {
      print('marked noti as read');
    }
  }

  void handleAcceptFriendRequest(
      {required String id,
      required String senderId,
      required String receiverId}) async {
    String api = '${AppConstants.serverAddress}/users/accept-friend-request';
    Object data = {'id': id, 'senderId': senderId, 'receiverId': receiverId};
    try {
      if (context.mounted) {
        AppDialog.showLoadingDialog(context, text: 'Đang chấp nhận ...');
      }
      await Future.delayed(const Duration(seconds: 1));

      Response response = await AppDio().post(api, data: {'data': data});
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (response.statusCode == 200) {
        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text: 'Đã kết bạn', onClose: () {});
        }
      }
      ref.refresh(asyncNotisProvider);
    } on DioException catch (error) {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (context.mounted) {
        AppDialog.showSimpleDialog(context,
            text: 'Không thể kết bạn. Lỗi server.', onClose: () {});
      }
    } catch (error) {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (context.mounted) {
        AppDialog.showSimpleDialog(context,
            text: 'Không thể kết bạn. Lỗi ứng dụng', onClose: () {});
      }
    }
  }

  void handleRejectFriendRequest(
      {required String id,
      required String senderId,
      required String receiverId}) async {
    String api = '${AppConstants.serverAddress}/users/accept-friend-request';
    Object data = {'id': id, 'senderId': senderId, 'receiverId': receiverId};
    try {
      if (context.mounted) {
        AppDialog.showLoadingDialog(context, text: 'Đang chấp nhận ...');
      }
      await Future.delayed(const Duration(seconds: 1));

      Response response = await AppDio().post(api, data: {'data': data});
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (response.statusCode == 200) {
        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text: 'Đã kết bạn', onClose: () {});
        }
      }
      ref.refresh(asyncNotisProvider);
    } on DioException catch (error) {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (context.mounted) {
        AppDialog.showSimpleDialog(context,
            text: 'Không thể kết bạn. Lỗi server.', onClose: () {});
      }
    } catch (error) {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (context.mounted) {
        AppDialog.showSimpleDialog(context,
            text: 'Không thể kết bạn. Lỗi ứng dụng', onClose: () {});
      }
    }
  }
}
