import 'package:cafedating/models/map_stats.dart';
import 'package:cafedating/models/marker_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'map_stats_notifier.g.dart';

@riverpod
class MapStatsNotifier extends _$MapStatsNotifier {
  @override
  MapStats build() {
    return MapStats(nearbyPersons: []);
  }

  void updateNearbyPersons(List<MarkerProfile> nearbyPersons) {
    state = state.copyWith(nearbyPersons: nearbyPersons);
  }
}
