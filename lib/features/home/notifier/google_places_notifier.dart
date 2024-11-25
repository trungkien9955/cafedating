import 'package:cafedating/models/google_places_response_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'google_places_notifier.g.dart';

@riverpod
class GooglePlacesNotifier extends _$GooglePlacesNotifier {
  @override
  List<GooglePlacesResponseItem> build() {
    return [];
  }

  void updateGooglePlaces(List<GooglePlacesResponseItem> googlePlaceList) {
    state = googlePlaceList;
  }
}
