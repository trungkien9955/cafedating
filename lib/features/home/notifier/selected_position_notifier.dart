import 'package:cafedating/models/selected_position.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_position_notifier.g.dart';

@riverpod
class SelectedPositionNotifier extends _$SelectedPositionNotifier {
  @override
  SelectedPosition build() {
    return SelectedPosition(lat: 39.5695288187466, lng: -107.3051380447742);
  }

  void updateSelectedPosition(SelectedPosition selectedPosition) {
    state = selectedPosition;
  }
}
