import 'package:cafedating/models/place_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_details_notifier.g.dart';

@riverpod
class PlaceDetailsNotifier extends _$PlaceDetailsNotifier {
  @override
  PlaceDetails build() {
    return PlaceDetails(
      // address_components: [],
      // adr_address: '',
      // business_status: '',
      formatted_address: '',
      // formatted_phone_number: '',
      geometry: {},
      // icon: '',
      // icon_background_color: '',
      // icon_mask_base_uri: '',
      // international_phone_number: '',
      name: '',
      // opening_hours: {},
      photos: [],
      place_id: '',
      // plus_code: {},
      rating: 0,
      // reference: '',
      // reviews: [],
      types: [],
      // url: '',
      user_ratings_total: 0,
      // utc_offset: 0,
      // vicinity: '',
      // website: ''
    );
  }

  void updatePlaceDetails(PlaceDetails placeDetails) {
    state = placeDetails;
  }
}
