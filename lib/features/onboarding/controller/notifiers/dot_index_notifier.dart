import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dot_index_notifier.g.dart';

@riverpod
class DotIndex extends _$DotIndex {
  @override
  int build() {
    return 0;
  }

  void changeIndex(int value) {
    state = value;
  }
}
