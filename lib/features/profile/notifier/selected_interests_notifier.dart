import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/models/interest.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_interests_notifier.g.dart';

@riverpod
class SelectedInterestsNotifier extends _$SelectedInterestsNotifier {
  // Future<List<String>> fetchInterests() async {
  //   String api = '${AppConstants.serverAddress}/data/interests';
  //   Response response = await AppDio().get(api);
  //   List<Interest> interests = List<Interest>.from(
  //       response.data['data'].map((item) => Interest.fromMap(item)));
  //   List<String> interestIds = [];
  //   interests.map((item) {
  //     interestIds.add(item.id);
  //   });
  //   return interestIds;
  // }

  @override
  List<String> build() {
    return [];
  }

  void updateInitialSelectedInterests(List<String> list) {
    state = list;
  }

  void updateSelectedInterests(String id) {
    if (!state.contains(id)) {
      state = [...state, id];
    } else {
      state = [
        for (final interestId in state)
          if (interestId != id) interestId
      ];
    }
  }
}
