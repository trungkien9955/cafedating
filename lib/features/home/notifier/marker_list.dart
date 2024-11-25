import 'package:cafedating/features/home/notifier/marker_data_list_notifier.dart';
import 'package:cafedating/main.dart';
import 'package:cafedating/models/marker_data_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'marker_list.g.dart';

@riverpod
List<Marker> markerList(MarkerListRef ref) {
  List<MarkerDataEntity> markerDataList =
      ref.watch(markerDataListNotifierProvider);
  if (markerDataList.isEmpty) {
    print('marker list empty');

    return [];
  } else {
    print('marker list ${markerDataList.length}');

    List<Marker> list = [];
    markerDataList.forEach((markerData) {
      Marker marker = Marker(
          markerId: MarkerId(markerData.markerId),
          position: LatLng(markerData.lat, markerData.lng),
          infoWindow: InfoWindow(
              title: markerData.title,
              snippet: markerData.snippet,
              onTap: () {
                navigatorKey.currentState?.pushNamed('/register');
              }),
          icon: markerData.icon,
          onTap: () {});
      print(marker);
      list.add(marker);
    });
    print(list.length);
    return list;
  }
}
