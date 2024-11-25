import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'name_repo.g.dart';

class NameRepo {
  Future<String> changeName(String newName) async {
    print('change name repo');
    String api = '${AppConstants.serverAddress}/users/change-name';
    String userId =
        Global.storageService.getString(AppConstants.userId).toString();
    Response response = await AppDio().post(api,
        data: {'newName': newName}, queryParameters: {'userId': userId});
    print(response.data['data']);
    return response.data['data'];
  }
}

@riverpod
NameRepo nameRepo(NameRepoRef ref) {
  return NameRepo();
}

@riverpod
Future<String> changeName(ChangeNameRef ref, String newName) {
  return ref.watch(nameRepoProvider).changeName(newName);
}
