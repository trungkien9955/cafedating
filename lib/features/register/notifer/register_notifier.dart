import 'package:cafedating/features/register/notifer/register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'register_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    return RegisterState(
        email: '',
        password: '',
        rePassword: '',
        name: '',
        gender: '',
        cityId: '');
  }

  void onEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChange(String password) {
    state = state.copyWith(password: password);
  }

  void onRepasswordChange(String rePassword) {
    state = state.copyWith(rePassword: rePassword);
  }

  void onNameChange(String name) {
    state = state.copyWith(name: name);
  }

  void onGenderChange(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onCityIdChange(String cityId) {
    state = state.copyWith(cityId: cityId);
  }
}
