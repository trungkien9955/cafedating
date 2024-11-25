import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_position_notifier.g.dart';

@riverpod
class CameraPositionNotifier extends _$CameraPositionNotifier {
  @override
  CameraPosition build() {
    double zoom = 18;
    return CameraPosition(target: const LatLng(0, 0), zoom: zoom);
  }

  void updateCameraPosition(CameraPosition cameraPosition) {
    state = cameraPosition;
  }
}
