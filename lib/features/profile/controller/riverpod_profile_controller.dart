import 'package:cafedating/features/profile/repo/name_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'riverpod_profile_controller.g.dart';

@riverpod
class RiverpodProfileController extends _$RiverpodProfileController {
  @override
  FutureOr<void> build() {}
  Future<void> changeName({required String newName}) async {
    print('controller change name');
    NameRepo nameRepo = ref.read(nameRepoProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => nameRepo.changeName(newName));
  }
}
