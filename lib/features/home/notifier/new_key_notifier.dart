import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_key_notifier.g.dart';

@riverpod
class NewKeyNotifier extends _$NewKeyNotifier {
  @override
  String build() {
    return '';
  }

  void updateNewKey(String key) {
    state = key;
  }
}
