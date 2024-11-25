import 'dart:convert';

import 'package:cafedating/core/common/widgets/app_alert.dart';
import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/common/widgets/app_text_button.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/search/notifier/search_filter_notifier.dart';
import 'package:cafedating/features/home/notifier/camera_position_notifier.dart';
import 'package:cafedating/features/home/notifier/place_details_notifier.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/features/home/notifier/selected_position_notifier.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/app_dio_entities.dart';
import 'package:cafedating/models/google_places_response_item.dart';
import 'package:cafedating/models/place_details.dart';
import 'package:cafedating/models/selected_position.dart';
import 'package:cafedating/models/user_model.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController {
  WidgetRef ref;
  BuildContext context;
  HomeController({required this.ref, required this.context});
  Future<void> updateFcmToken() async {
    final messaging = FirebaseMessaging.instance;
    final fcmToken = await messaging.getToken();
    String userId = Global.storageService.getString(AppConstants.userId);
    String api = '${AppConstants.serverAddress}/users/update-fcm-token';
    Response response = await AppDio()
        .post(api, data: {'fcmToken': fcmToken, 'userId': userId});
    if (response.statusCode == 200) {
      print('update fcm token successfully');
    }
  }

  Future<Position> requestPermissionGeolocator() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(
          'Chức năng vị trí trên thiết bị của bạn đang tắt. Không thể lấy dữ liệu vị trí');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Geolocator.openLocationSettings();
        return Future.error('Bạn đã từ chối ');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Geolocator.openLocationSettings();

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    String userId = Global.storageService.getString(AppConstants.userId);
    String api = '${AppConstants.serverAddress}/users/update-position';

    Position position = await Geolocator.getCurrentPosition();
    ref.read(positionNotifierProvider.notifier).updatePosition(position);
    ref.read(selectedPositionNotifierProvider.notifier).updateSelectedPosition(
        SelectedPosition(lat: position.latitude, lng: position.longitude));
    ref.read(searchFilterNotifierProvider.notifier).updatePosition(
        SelectedPosition(lat: position.latitude, lng: position.longitude));
    await AppDio().post(api, data: {
      'position': {'lat': position.latitude, 'long': position.longitude}
    }, queryParameters: {
      'userId': userId
    });
    // CameraPosition cameraPosition = CameraPosition(
    //     target: LatLng(position.latitude, position.longitude),
    //     zoom: AppConstants.cameraZoom);
    // ref
    //     .watch(cameraPositionNotifierProvider.notifier)
    //     .updateCameraPosition(cameraPosition);
    print('request location $position');
    return position;
  }

  Future<void> requestNotificationPermission() async {
//     final notificationSettings =
//         await FirebaseMessaging.instance.requestPermission(provisional: true);

// // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      print(apnsToken);
      // APNS token is available, make FCM plugin API requests...
    }
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
  }

  Future<PlaceDetails> fetchPlaceDetails(String placeId) async {
    PlaceDetails placeDetails = PlaceDetails(
        formatted_address: '',
        geometry: {},
        name: '',
        photos: [],
        place_id: '',
        types: []);
    if (placeId != '') {
      String api =
          'https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Cformatted_address%2Cgeometry%2Cphotos%2Crating%2Cuser_ratings_total%2Ctypes%2Cplace_id&place_id=${placeId}&key=${AppConstants.googleMapApiKey}';
      String placeDetailsStorage =
          Global.storageService.getString(AppConstants.placeDetails);
      if (placeDetailsStorage == '') {
        try {
          if (context.mounted) {
            AppDialog.showLoadingDialog(context, text: 'Đang tải dữ liệu ...');
          }
          Response response = await AppDio().get(api);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
          if (response.data['status'] == 'OK') {
            if (response.data['result'] != null) {
              Global.storageService.setString(AppConstants.placeDetails,
                  jsonEncode(response.data['result']));
              placeDetails = PlaceDetails.fromMap(response.data['result']);
              ref
                  .read(selectedPositionNotifierProvider.notifier)
                  .updateSelectedPosition(SelectedPosition(
                      lat: placeDetails.geometry['location']['lat'],
                      lng: placeDetails.geometry['location']['lng']));

              ref
                  .read(placeDetailsNotifierProvider.notifier)
                  .updatePlaceDetails(placeDetails);
              // if (context.mounted) {
              //   showPlaceDetailsDialog(context, placeDetails);
              // }
            }
          }
        } on DioException catch (e) {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
          if (context.mounted) {
            AppDialog.showSimpleDialog(context,
                text: 'Không thể tải địa điểm', onClose: () {});
          }
        } catch (e) {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
          if (context.mounted) {
            AppDialog.showSimpleDialog(context,
                text: 'Không thể tải địa điểm', onClose: () {});
          }
        }
      } else {
        print('place details available');
        var placeDetails = Global.storageService.getPlaceDetails();
        placeDetails = PlaceDetails.fromMap(placeDetails);

        ref
            .read(selectedPositionNotifierProvider.notifier)
            .updateSelectedPosition(SelectedPosition(
                lat: placeDetails.geometry['location']['lat'],
                lng: placeDetails.geometry['location']['lng']));
        ref
            .read(placeDetailsNotifierProvider.notifier)
            .updatePlaceDetails(placeDetails);
        // if (context.mounted) {
        //   showPlaceDetailsDialog(context, placeDetails);
        // }
      }
    }
    return placeDetails;
  }

  Future<List<GooglePlacesResponseItem>> fetchGooglePlaces(
      String searchKey) async {
    print('fetch google places');
    Position position = ref.read(positionNotifierProvider);
    List<GooglePlacesResponseItem> googlePlaceList = [];
    String api =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchKey&location=${position.latitude}%2C${position.longitude}&radius=250000&strictbounds=true&language=vic&country=vn&key=${AppConstants.googleMapApiKey}';
    // print(api);
    String googlePlacesListStorage =
        Global.storageService.getString(AppConstants.googlePlacesList);
    if (googlePlacesListStorage == '') {
      print('places not available yet');
      try {
        if (context.mounted) {
          AppDialog.showLoadingDialog(context, text: 'Đang tải dữ liệu ...');
        }
        await Future.delayed(const Duration(seconds: 1));
        Response response = await AppDio().get(api);
        if (response.statusCode == 200) {
          if (response.data['status'] == 'OK') {
            var list = response.data['predictions'];
            Global.storageService.setString(AppConstants.googlePlacesList,
                jsonEncode(response.data['predictions']));
            // print('fetch google place $list');
            if (list.isEmpty) {
              googlePlaceList = [];
            }
            if (list.isNotEmpty) {
              googlePlaceList = List<GooglePlacesResponseItem>.from(response
                  .data['predictions']
                  .map((item) => GooglePlacesResponseItem.fromMap(item)));
            }
          }
        }
        if (context.mounted) {
          AppDialog.hideLoadingDialog(context);
        }
      } on DioException catch (error) {
        print('fetch google places error ${error.toString()}');
        if (context.mounted) {
          AppDialog.hideLoadingDialog(context);
        }
      } catch (error) {
        if (context.mounted) {
          AppDialog.hideLoadingDialog(context);
        }
      }
    } else {
      List googlePlacesListData = Global.storageService.getGooglePlacesList();
      googlePlaceList = List<GooglePlacesResponseItem>.from(googlePlacesListData
          .map((item) => GooglePlacesResponseItem.fromMap(item)));
    }
    return googlePlaceList;
  }

  void showPlaceDetailsDialog(BuildContext context, PlaceDetails placeDetails) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(placeDetails.formatted_address),
                  AppTextButton(
                      label: 'OK',
                      onPress: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),
            ),
          );
        });
  }

  Future<void> handleAddFriend({required String receiverId}) async {
    String userId = Global.storageService.getString(AppConstants.userId);
    UserProfile userProfile = Global.storageService.getUserProfile();

    String api = '${AppConstants.serverAddress}/users/push-notification';
    try {
      if (context.mounted) {
        AppDialog.showLoadingDialog(context, text: 'Đang gửi lời mời ...');
      }
      await Future.delayed(const Duration(seconds: 1));
      Object data = {
        'title': 'Lời mời kết bạn',
        'subTitle': '${userProfile.name} đã gửi lời mời kết bạn'
      };
      Response response = await AppDio().post(api, data: {
        'data': data
      }, queryParameters: {
        'receiverId': receiverId,
        'senderId': userId,
        'type': 'friend-request'
      });
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (response.statusCode == 200) {
        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text: 'Đã gửi lời mời kết bạn', onClose: () {});
        }
      }
    } on DioException catch (error) {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (context.mounted) {
        AppDialog.showSimpleDialog(context,
            text: 'Không thể gửi lời mời kết bạn. Lỗi server.', onClose: () {});
      }
    } catch (error) {
      if (context.mounted) {
        AppDialog.hideLoadingDialog(context);
      }
      if (context.mounted) {
        AppDialog.showSimpleDialog(context,
            text: 'Không thể gửi lời mời kết bạn. Lỗi ứng dụng',
            onClose: () {});
      }
    }
  }

  Future<BitmapDescriptor> buildMarkerIcon(String pathImage) async {
    // Fetch the PNG
    Image image = Image.network(pathImage);

    // Encode the image as a list of ints
    List<int> list = utf8.encode(image.toString());

    // Convert the int list into an unsigned 8-bit bytelist
    Uint8List bytes = Uint8List.fromList(list);

    // And construct the BitmapDescriptor from the bytelist
    BitmapDescriptor bitmapDescriptor = BitmapDescriptor.bytes(bytes);

    // And return the product
    return bitmapDescriptor;
  }
}
