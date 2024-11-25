import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_places_search_key_notifier.g.dart';

@riverpod
class GooglePlacesSearchKeyNotifier extends _$GooglePlacesSearchKeyNotifier {
  @override
  String build() {
    return '';
  }

  void updateGooglePlacesSearchKey(String searchKey) {
    print(searchKey);
    state = searchKey;
  }
}
