import 'package:cafedating/models/location_response.dart';
import 'package:cafedating/models/user_location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_location_notifier.g.dart';

@riverpod
class UserLocationNotifier extends _$UserLocationNotifier {
  @override
  UserLocation build() {
    return UserLocation(address: '', location: '');
  }

  void updateUserLocation(LocationResultItem locationData) {
    // var district = locations[0].address_components.filter((item:any)=>item.types.includes('administrative_area_level_2'))[0].long_name
    String location = '';
    String wardName = '';

    String address = locationData.formatted_address ?? '';
    String cityName = locationData
            .address_components!
            .where(
                (item) => item.types!.contains('administrative_area_level_1'))
            .first
            .long_name ??
        '';
    String districtName = locationData
            .address_components!
            .where(
                (item) => item.types!.contains('administrative_area_level_2'))
            .first
            .long_name ??
        '';

    List ward = locationData
        .address_components!
        .where((item) => item.types!.contains('administrative_area_level_3'))
        .toList();
    if (ward.isNotEmpty) {
      wardName = locationData
              .address_components!
              .where(
                  (item) => item.types!.contains('administrative_area_level_3'))
              .first
              .long_name ??
          '';
    }
    if (wardName != '') {
      location = '$wardName, $districtName';
    } else if (districtName != '') {
      location = '$districtName, $cityName';
    }

    state = state.copyWith(location: location, address: address);
  }

}
