import 'dart:convert';

import 'package:cafedating/core/common/widgets/app_alert.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/home/notifier/camera_position_notifier.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/models/app_dio_entities.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPermissionController {
  WidgetRef ref;
  LocationPermissionController({required this.ref});
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
        return Future.error(
            'Bạn đã từ chối chức năng vị trí. Để tiếp tục sử dụng ứng dụng, vui lòng mở lại ứng dụng và đồng ý sử dụng vị trí.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return Future.error(
          'Bạn đã từ chối chức năng vị trí. Vui lòng bật chức năng vị trí ở phần cài đặt và mở lại ứng dụng');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Position position = await Geolocator.getCurrentPosition();
    ref.watch(positionNotifierProvider.notifier).updatePosition(position);
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: AppConstants.cameraZoom);
    ref
        .watch(cameraPositionNotifierProvider.notifier)
        .updateCameraPosition(cameraPosition);
    return position;
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
