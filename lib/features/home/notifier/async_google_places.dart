import 'package:cafedating/features/home/notifier/google_places_search_key_notifier.dart';
import 'package:cafedating/models/google_places_response_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'async_google_places.g.dart';

@riverpod
List<GooglePlacesResponseItem> asyncGooglePlaces(AsyncGooglePlacesRef ref) {
  String searchKey = ref.watch(googlePlacesSearchKeyNotifierProvider);
  print('async google places $searchKey');
  return [];
}
