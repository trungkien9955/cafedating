import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'location_response_notifier.g.dart';

@riverpod
class LocationResponseNotifier extends _$LocationResponseNotifier {
  @override
  List build() {
    return [];
  }

  void updateLocationResponse(List locationResponse) {
    state = locationResponse;
  }
}
