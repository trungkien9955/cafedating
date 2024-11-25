import 'package:cafedating/features/home/notifier/place_details_async.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'position_notifier.g.dart';

@Riverpod(keepAlive: true)
class PositionNotifier extends _$PositionNotifier {
  @override
  Position build() {
    return Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0);
  }

  void updatePosition(Position position) {
    state = position;
  }

  // void updatePositionFromPlace() {
  //   ref.listen(placeDetailsAsyncProvider, (prev, next) {
  //     if (next.hasValue) {
  //       state = Position(
  //           longitude: next.value!.geometry['location']['lat'],
  //           latitude: next.value!.geometry['location']['lng'],
  //           timestamp: DateTime.now(),
  //           accuracy: 0,
  //           altitude: 0,
  //           altitudeAccuracy: 0,
  //           heading: 0,
  //           headingAccuracy: 0,
  //           speed: 0,
  //           speedAccuracy: 0);
  //     }
  //   });
  // }
}
