import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_loader.dart';
import 'package:cafedating/core/common/widgets/app_text_body_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_label_medium.dart';
import 'package:cafedating/features/search/notifier/search_filter_notifier.dart';
import 'package:cafedating/features/search/provider/async_cities.dart';
import 'package:cafedating/features/search/controller/search_screen_controller.dart';
import 'package:cafedating/features/search/provider/async_hometowns.dart';
import 'package:cafedating/features/search/provider/async_users.dart';
import 'package:cafedating/features/search/view/user_search_profile.dart';
import 'package:cafedating/models/search/search_entities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

enum GenderLabel {
  female('Nữ', 'female'),
  male('Nam', 'male');

  const GenderLabel(this.label, this.value);
  final String label;
  final String value;
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<UserSearchItem> userList = [];
  @override
  Widget build(BuildContext context) {
    // final AsyncValue<List<UserSearchItem>> asyncUsersData =
    //     ref.watch(asyncUsersProvider);
    final AsyncValue<List<City>> asyncCitiesData =
        ref.watch(asyncCitiesProvider);
    final AsyncValue<List<Hometown>> asyncHometownsData =
        ref.watch(asyncHometownsProvider);
    final SearchFilter searchFilterData =
        ref.watch(searchFilterNotifierProvider);
    print('search screen ${searchFilterData.position.lat}');
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tìm kiếm'),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: [
                DropdownMenu(
                  label: const AppTextLabelMedium(text: 'Giới tính'),
                  onSelected: (item) {
                    ref
                        .read(searchFilterNotifierProvider.notifier)
                        .updateGender(item!.value);
                  },
                  dropdownMenuEntries: GenderLabel.values
                      .map<DropdownMenuEntry<GenderLabel>>((GenderLabel item) {
                    return DropdownMenuEntry<GenderLabel>(
                      value: item,
                      label: item.label,
                    );
                  }).toList(),
                ),
                switch (asyncCitiesData) {
                  AsyncData(:final value) => DropdownMenu(
                      label: const AppTextLabelMedium(text: 'Thành phố'),
                      menuHeight: 480,
                      dropdownMenuEntries: value.map((item) {
                        return DropdownMenuEntry(
                            value: item.id, label: item.name);
                      }).toList()),
                  AsyncError(:final error, :final stackTrace) =>
                    AppTextBodyMedium(text: error.toString()),
                  _ => const SizedBox.shrink()
                },
                switch (asyncHometownsData) {
                  AsyncData(:final value) => DropdownMenu(
                      label: const AppTextLabelMedium(text: 'Quê quán'),
                      dropdownMenuEntries: value.map((item) {
                        return DropdownMenuEntry(
                            value: item.id, label: item.name);
                      }).toList()),
                  AsyncError(:final error, :final stackTrace) =>
                    AppTextBodyMedium(text: error.toString()),
                  _ => const SizedBox.shrink()
                },
                AppFilledButton2(
                  label: 'Tìm kiếm',
                  onPressed: () {
                    SearchScreenController(context: context, ref: ref)
                        .fetchUsers()
                        .then((value) {
                      setState(() {
                        userList = value;
                      });
                    });
                  },
                )
              ],
            ),
            userList.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return UserSearchProfile(
                            id: userList[index].id,
                            name: userList[index].name,
                            photoUrl: userList[index].photoUrl,
                            joinedAt: userList[index].joinedAt,
                            lastSeen: userList[index].lastSeen,
                            city: userList[index].city,
                            hometown: userList[index].hometown,
                            distance: userList[index].distance,
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: userList.length),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
