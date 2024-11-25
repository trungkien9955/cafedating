import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_college_id_notifier.g.dart';

@riverpod
class SelectedCollegeIdNotifier extends _$SelectedCollegeIdNotifier {
  @override
  String build() {
    return '';
  }

  void updatedSelectedCollegeIdNotifier(String id) {
    state = id;
  }
}
