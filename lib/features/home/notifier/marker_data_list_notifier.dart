import 'package:cafedating/models/marker_data_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'marker_data_list_notifier.g.dart';

@riverpod
class MarkerDataListNotifier extends _$MarkerDataListNotifier {
  @override
  List<MarkerDataEntity> build() {
    return [];
  }

  void updateMarkerDataList(List<MarkerDataEntity> markerDataList) {
    state = markerDataList;
  }
}
