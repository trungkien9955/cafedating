import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/common/widgets/app_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_loader.dart';
import 'package:cafedating/core/common/widgets/app_textfield.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/home/notifier/google_places_search_key_notifier.dart';
import 'package:cafedating/features/loader/loader_notifier.dart';
import 'package:cafedating/features/profile/controller/profile_controller.dart';
import 'package:cafedating/features/profile/notifier/college/college_search_key_notifier.dart';
import 'package:cafedating/features/profile/notifier/college/search_college.dart';
import 'package:cafedating/features/profile/notifier/college/selected_college_id_notifier.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/college.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class CollegeSelectionScreen extends ConsumerStatefulWidget {
  const CollegeSelectionScreen({super.key});

  @override
  ConsumerState<CollegeSelectionScreen> createState() =>
      _CollegeSelectionScreenState();
}

class _CollegeSelectionScreenState
    extends ConsumerState<CollegeSelectionScreen> {
  final TextEditingController _controller = TextEditingController();
  String searchKey = '';
  String selectedCollegeId = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<College>> collegesData =
        ref.watch(searchCollegeProvider);
    // final bool showAppLoader = ref.watch(loaderNotifierProvider);
    final searchKeyData = ref.watch(collegeSearchKeyNotifierProvider);
    final String selectedCollegeIdData =
        ref.watch(selectedCollegeIdNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tìm trường'),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              onChanged: (value) {
                print('searchkey $value');
                ref
                    .read(collegeSearchKeyNotifierProvider.notifier)
                    .updateCollegeSearchKey(value);
                ref
                    .watch(googlePlacesSearchKeyNotifierProvider.notifier)
                    .updateGooglePlacesSearchKey(value);
              },
              decoration: InputDecoration(
                hintText: 'Vui lòng gõ tiếng Việt có dấu',
              ),
            ),
            Expanded(
                child: switch (collegesData) {
              AsyncData(:final value) => Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: value.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 50,
                                child: GestureDetector(
                                  child: Text('${value[index].name}'),
                                  onTap: () {
                                    _controller.text = value[index].name;
                                    ref
                                        .read(selectedCollegeIdNotifierProvider
                                            .notifier)
                                        .updatedSelectedCollegeIdNotifier(
                                            value[index].id);
                                    ref
                                        .watch(collegeSearchKeyNotifierProvider
                                            .notifier)
                                        .updateCollegeSearchKey('');
                                  },
                                ),
                              );
                            }),
                      ),
                    ),
                    searchKeyData == '' && selectedCollegeId == ''
                        ? Text('Vui lòng nhập tên trường')
                        : searchKeyData != '' && selectedCollegeId != ''
                            ? Text('Tìm thấy ${value.length} trường')
                            : SizedBox.shrink()
                  ],
                ),
              AsyncError(:final error, :final stackTrace) =>
                Text('$error $stackTrace'),
              _ => Center(
                  child: AppLoader(),
                )
            }),
            const SizedBox(
              height: 16,
            ),
            AppFilledButton2(
              label: 'OK',
              onPressed: selectedCollegeIdData != ''
                  ? () {
                      print(selectedCollegeIdData);
                      ProfileController(buildContext: context, ref: ref)
                          .updateCollege();
                    }
                  : null,
            )
          ],
        ),
      )),
    );
  }
}
