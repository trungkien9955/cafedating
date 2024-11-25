import 'dart:io';

import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/common/widgets/app_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_outlined_button.dart';
import 'package:cafedating/core/common/widgets/app_text_button.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/profile/notifier/photo/async_photo_url.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileImageScreen extends ConsumerStatefulWidget {
  const ProfileImageScreen({super.key});

  @override
  ConsumerState<ProfileImageScreen> createState() => _ProfileImageScreenState();
}

class _ProfileImageScreenState extends ConsumerState<ProfileImageScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String uploadedImageUrl = '';
  Future getImage() async {
    print('get image');
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future getImageFromCamera() async {
    try {
      var status = await Permission.camera.status;
      print(status);
      // await Permission.camera.onDeniedCallback(() {
      //   AppDialog.showSuccessDialog(context,
      //       title: 'Lỗi',
      //       subtitle: 'Bạn đã từ chối sử dụng camera',
      //       onClose: () {});
      // }).onGrantedCallback(() async {
      //   // final XFile? image =
      //   //     await _picker.pickImage(source: ImageSource.camera);

      //   // setState(() {
      //   //   _image = image;
      //   // });
      // }).onPermanentlyDeniedCallback(() {
      //   // Your code
      // }).onRestrictedCallback(() {
      //   // Your code
      // }).onLimitedCallback(() {
      //   // Your code
      // }).onProvisionalCallback(() {
      //   // Your code
      // }).request();
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadToFirebase(BuildContext context) async {
    AppDialog.showLoadingDialog(context, text: 'Đang xử lý hình ảnh...');
    FirebaseStorage storage = FirebaseStorage.instance;
    String url = '';
    Reference ref = storage.ref().child('image-${DateTime.now().toString()}');
    // Reference ref = storage.ref().child('default-avatar-2');
    File file = File(_image!.path);
    UploadTask uploadTask = ref.putFile(file);
    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      if (url != '') {
        setState(() {
          uploadedImageUrl = url;
        });
      }
      try {
        String userId = Global.storageService.getString(AppConstants.userId);
        String api = '${AppConstants.serverAddress}/users/update-photo-url';
        Response response = await AppDio().post(api,
            data: {'photoUrl': url}, queryParameters: {'userId': userId});
        if (response.statusCode == 200) {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
          if (context.mounted) {
            AppDialog.showSimpleDialog(context, text: 'Đã cập nhật hình ảnh',
                onClose: () {
              print('close');
              Navigator.of(context).pop();
            });
          }
        }
      } on DioException catch (e) {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text: '${e.response!.data['msg']}', onClose: () {
            Navigator.of(context).pop();
          });
        }
      } catch (e) {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text: 'Không thể cập nhật hình ảnh', onClose: () {
            Navigator.of(context).pop();
          });
        }
      }
    }).catchError((onError) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      if (context.mounted) {
        AppDialog.showSimpleDialog(context,
            text: 'Không thể cập nhật hình ảnh...', onClose: () {});
      }
      print(onError);
    });
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<String> asyncPhotoUrlData =
        ref.watch(asyncPhotoUrlProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Chọn ảnh đại diện'),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
                radius: 100,
                backgroundImage: _image == null
                    ? switch (asyncPhotoUrlData) {
                        AsyncData(:final value) => NetworkImage(value),
                        AsyncError() => AssetImage(
                            '${AppConstants.imageUrl}/default-avatar.png'),
                        _ => AssetImage(
                            '${AppConstants.imageUrl}/default-avatar.png')
                      }
                    : FileImage(File(_image!.path))),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppFilledButton2(
                  label: 'Chọn ảnh',
                  onPressed: () {
                    getImage();
                  }),
              SizedBox(
                width: 12,
              ),
              AppOutlinedButton(
                label: 'Camera',
                onPressed: () {
                  getImageFromCamera();
                },
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          _image != null
              ? AppFilledButton2(
                  label: 'OK',
                  onPressed: () {
                    print(_image);
                    uploadToFirebase(context);
                  },
                )
              : SizedBox.shrink()
        ],
      )),
    );
  }
}
