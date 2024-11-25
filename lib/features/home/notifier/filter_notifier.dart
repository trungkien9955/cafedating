import 'package:cafedating/models/filter_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_notifier.g.dart';

@riverpod
class FilterNotifier extends _$FilterNotifier {
  @override
  FilterModel build() {
    return FilterModel(radius: 0);
  }

  void updateFilterRadius(int radius) {
    state = state.copyWith(radius: radius);
  }
}
