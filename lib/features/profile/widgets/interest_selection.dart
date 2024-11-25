import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/common/widgets/app_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_loader.dart';
import 'package:cafedating/core/common/widgets/interest_option_chip.dart';
import 'package:cafedating/features/loader/loader_notifier.dart';
import 'package:cafedating/features/profile/controller/profile_controller.dart';
import 'package:cafedating/features/profile/notifier/async_interests.dart';
import 'package:cafedating/features/profile/notifier/async_user_interests.dart';
import 'package:cafedating/features/profile/notifier/selected_interests_notifier.dart';
import 'package:cafedating/features/profile/repo/profile_repo.dart';
import 'package:cafedating/models/interest.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterestSelection extends ConsumerStatefulWidget {
  const InterestSelection({super.key});

  @override
  ConsumerState<InterestSelection> createState() => _InterestSelectionState();
}

class _InterestSelectionState extends ConsumerState<InterestSelection> {
  List<String> userSelectedInterest = [];

  @override
  void initState() {
    super.initState();
    _fetchSelectedInterests();
  }

  void _fetchSelectedInterests() async {
    await ProfileRepo.fetchUserInterests().then((value) {
      ref
          .watch(selectedInterestsNotifierProvider.notifier)
          .updateInitialSelectedInterests(value!);
      setState(() {
        userSelectedInterest = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> selectedInterestsData =
        ref.watch(selectedInterestsNotifierProvider);
    final AsyncValue<List<Interest>> interestsData =
        ref.watch(asyncInterestsProvider);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Chọn sở thích'),
            ],
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                switch (interestsData) {
                  AsyncData(:final value) => Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Wrap(
                              children: value
                                  .map((item) => InterestOptionChip(
                                        id: item.id,
                                        name: item.name,
                                        type: item.type,
                                        hasBgColor: true,
                                        bgColor: AppTheme.primaryColorLight,
                                        selected: selectedInterestsData
                                            .contains(item.id),
                                        onPressed: () {
                                          ref
                                              .watch(
                                                  selectedInterestsNotifierProvider
                                                      .notifier)
                                              .updateSelectedInterests(item.id);
                                          print(selectedInterestsData);
                                        },
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  AsyncError(:final error, :final stackTrace) => Center(
                      child: Text('$error $stackTrace'),
                    ),
                  _ => AppLoader()
                },
                AppFilledButton(
                    label: 'OK',
                    hasIcon: false,
                    onPressed: () {
                      ProfileController(buildContext: context, ref: ref)
                          .updatedSelectedInterests();
                    })
              ],
            ),
          ),
        ));
  }
}
