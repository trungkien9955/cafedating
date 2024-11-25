import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/home/controller/home_controller.dart';
import 'package:cafedating/features/home/notifier/marker_data_list_notifier.dart';
import 'package:cafedating/features/home/notifier/marker_list.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/features/home/notifier/selected_position_notifier.dart';
import 'package:cafedating/main.dart';
import 'package:cafedating/models/map_data.dart';
import 'package:cafedating/models/marker_data_entity.dart';
import 'package:cafedating/models/marker_profile.dart';
import 'package:cafedating/models/nearby_person_response_entity.dart';
import 'package:cafedating/models/selected_position.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:typed_data';
part 'nearby_persons_notifier.g.dart';

@riverpod
Future<MapData> nearbyPersons(NearbyPersonsRef ref) async {
  print('fetch nearby persons');
  MapData mapData = MapData(
      markerList: [], selectedPosition: SelectedPosition(lat: 0, lng: 0));
  // Position position = ref.watch(positionNotifierProvider);
  SelectedPosition selectedPosition =
      ref.watch(selectedPositionNotifierProvider);
  String api =
      '${AppConstants.serverAddress}/map/nearby-persons?lat=${selectedPosition.lat}&long=${selectedPosition.lng}&distance=100';
  await Future.delayed(const Duration(seconds: 1));
  Response response = await AppDio().get(api);
  if (response.statusCode == 200) {
    if (response.data['data'] != null) {
      Future<BitmapDescriptor> buildMarkerIcon(String pathImage) async {
        final File markerImageFile =
            await DefaultCacheManager().getSingleFile(pathImage);
        final Uint8List markerImageBytes = await markerImageFile.readAsBytes();

        // Fetch the PNG
        // Image image = Image.network(pathImage);
        // Image image =
        //     Image.asset('${AppConstants.imageUrl}/default-avatar.png');

        // Encode the image as a list of ints
        // debugPrint('nearby person utf8 list ${image.toString()}',
        // wrapWidth: 1024);

        // List<int> list = utf8.encode(Image.image.read);
        // debugPrint('nearby person utf8 list $list', wrapWidth: 1024);
        // // Convert the int list into an unsigned 8-bit bytelist
        // Uint8List bytes = Uint8List.fromList(list);
        // debugPrint('nearby person utf8 bytes $bytes', wrapWidth: 1024);

        // BytesMapBitmap bytesMapBitmap =
        //     BytesMapBitmap(bytes, width: 100, height: 100);
        // And construct the BitmapDescriptor from the bytelist
        BitmapDescriptor bitmapDescriptor =
            BitmapDescriptor.bytes(markerImageBytes, width: 100, height: 100);
        print('bit map decoded success');

        // And return the product
        return bitmapDescriptor;
      }

      Future<BitmapDescriptor> createCustomMarker(String imgPath,
          {required int size,
          bool addBorder = false,
          Color borderColor = Colors.white,
          double borderSize = 3,
          required String title,
          Color titleColor = Colors.purple,
          Color titleBackgroundColor = Colors.transparent}) async {
        final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
        final Canvas canvas = Canvas(pictureRecorder);
        final Paint paint = Paint()..color;
        final TextPainter textPainter = TextPainter(
          textDirection: TextDirection.ltr,
        );
        final double radius = size / 2;

        //make canvas clip path to prevent image drawing over the circle
        final Path clipPath = Path();
        clipPath.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
            Radius.circular(size * 2 / 3)));
        clipPath.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
            Radius.circular(size * 2 / 3)));
        canvas.clipPath(clipPath);

        //paintImage
        final File markerImageFile =
            await DefaultCacheManager().getSingleFile(imgPath);
        final Uint8List markerImageBytes = await markerImageFile.readAsBytes();
        final ui.Codec codec = await ui.instantiateImageCodec(markerImageBytes);
        final ui.FrameInfo imageFI = await codec.getNextFrame();
        paintImage(
            canvas: canvas,
            rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
            image: imageFI.image);

        if (addBorder) {
          //draw Border
          paint..color = borderColor;
          paint..style = PaintingStyle.stroke;
          paint..strokeWidth = borderSize;
          canvas.drawCircle(Offset(radius, radius), radius, paint);
        }

        if (title != '') {
          if (title.length > 9) {
            title = title.substring(0, 9);
          }
          //draw Title background
          paint..color = titleBackgroundColor;
          paint..style = PaintingStyle.fill;
          canvas.drawRRect(
              RRect.fromRectAndRadius(
                  Rect.fromLTWH(
                      0, size * 8 / 10, size.toDouble(), size * 3 / 10),
                  Radius.circular(40)),
              paint);

          //draw Title
          textPainter.text = TextSpan(
              text: title,
              style: TextStyle(
                fontSize: radius / 2.5,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ));
          textPainter.layout();
          textPainter.paint(
              canvas,
              Offset(radius - textPainter.width / 2,
                  size * 9.5 / 10 - textPainter.height / 2));
        }

        //convert canvas as PNG bytes
        final _image = await pictureRecorder
            .endRecording()
            .toImage(size, (size * 1.1).toInt());
        final data = await _image.toByteData(format: ui.ImageByteFormat.png);

        //convert PNG bytes as BitmapDescriptor
        return BitmapDescriptor.bytes(data!.buffer.asUint8List());
      }

      List<NearbyPersonResponseEntity> nearbyPersonResponseList =
          List<NearbyPersonResponseEntity>.from(response.data['data']
              .map((item) => NearbyPersonResponseEntity.fromMap(item)));

      if (nearbyPersonResponseList.isNotEmpty) {
        List<MarkerDataEntity> list = [];

        await Future.forEach(nearbyPersonResponseList,
            (NearbyPersonResponseEntity item) async {
          await createCustomMarker(item.photoUrl, size: 60, title: '')
              .then((icon) {
            MarkerDataEntity markerDataEntity = MarkerDataEntity(
                markerId: item.id,
                lat: item.position.lat,
                lng: item.position.lng,
                title: item.name,
                snippet: '',
                icon: icon);
            list.add(markerDataEntity);
          });
        });

        List<Marker> markersList = [];
        for (var i = 0; i < list.length; i++) {
          Marker marker = Marker(
              markerId: MarkerId(list[i].markerId),
              position: LatLng(list[i].lat, list[i].lng),
              infoWindow: InfoWindow(
                  title: list[i].title,
                  snippet: list[i].snippet,
                  onTap: () {
                    navigatorKey.currentState?.pushNamed(
                        '/person-profile-screen',
                        arguments: {'userId': list[i].markerId});
                  }),
              icon: list[i].icon,
              onTap: () {});
          markersList.add(marker);
        }
        print('nearby persons ${selectedPosition.lat}');
        print('nearby persons ${selectedPosition.lng}');

        mapData = MapData(
            markerList: markersList, selectedPosition: selectedPosition);
      }
    }
  }
  return mapData;
}
