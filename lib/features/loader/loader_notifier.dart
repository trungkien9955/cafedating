import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'loader_notifier.g.dart';

@riverpod
class LoaderNotifier extends _$LoaderNotifier {
  @override
  bool build() {
    return false;
  }

  void setLoader(bool value) {
    state = value;
  }
}
