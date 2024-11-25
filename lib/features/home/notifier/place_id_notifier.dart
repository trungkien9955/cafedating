import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_id_notifier.g.dart';

@riverpod
class PlaceIdNotifier extends _$PlaceIdNotifier {
  @override
  String build() {
    return '';
  }

  void updatePlaceId(String id) {
    state = id;
  }
}
