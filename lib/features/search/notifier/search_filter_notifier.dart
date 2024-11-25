import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/search/search_entities.dart';
import 'package:cafedating/models/selected_position.dart';
import 'package:cafedating/models/user_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_filter_notifier.g.dart';

@Riverpod(keepAlive: true)
class SearchFilterNotifier extends _$SearchFilterNotifier {
  @override
  SearchFilter build() {
    UserProfile userProfile = Global.storageService.getUserProfile();
    Position position = ref.watch(positionNotifierProvider);
    String gender = '';
    if (userProfile.gender != null && userProfile.gender == 'male') {
      gender = 'female';
    } else if (userProfile.gender != null && userProfile.gender == 'female') {
      gender = 'male';
    } else {
      gender = 'female';
    }

    return SearchFilter(
        gender: gender,
        position:
            SelectedPosition(lat: position.latitude, lng: position.longitude),
        cityId: '',
        hometownId: '',
        jobId: '');
  }

  void updatecityId(String cityId) {
    state = state.copyWith(cityId: cityId);
  }

  void updateGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void updatePosition(SelectedPosition position) {
    state = state.copyWith(position: position);
    print('update filter position $position');
    print('update filter position ${state.position.lat}');
  }
}
