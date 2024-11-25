import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'college_search_key_notifier.g.dart';

@riverpod
class CollegeSearchKeyNotifier extends _$CollegeSearchKeyNotifier {
  @override
  String build() {
    return '';
  }

  void updateCollegeSearchKey(String searchKey) {
    state = searchKey;
  }
}
