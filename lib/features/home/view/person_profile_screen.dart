import 'package:cafedating/core/common/widgets/app_card.dart';
import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_height_spacer.dart';
import 'package:cafedating/core/common/widgets/app_text_headline_medium.dart';
import 'package:cafedating/core/common/widgets/app_width_spacer.dart';
import 'package:cafedating/features/home/controller/home_controller.dart';
import 'package:cafedating/features/home/provider/async_person_profile.dart';
import 'package:cafedating/features/loader/loading_screen.dart';
import 'package:cafedating/models/home/person_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonProfileScreen extends ConsumerStatefulWidget {
  const PersonProfileScreen({super.key});

  @override
  ConsumerState<PersonProfileScreen> createState() =>
      _PersonProfileScreenState();
}

class _PersonProfileScreenState extends ConsumerState<PersonProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String userId = arg['userId'];
    print('person profile screen $userId');

    final AsyncValue<PersonProfile> asyncPersonProfileData =
        ref.watch(AsyncPersonProfileProvider(userId));
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Person profile'),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: switch (asyncPersonProfileData) {
        AsyncData(:final value) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(value.photoUrl),
                    ),
                  ),
                  AppHeightSpacer(height: 12),
                  Container(
                    alignment: Alignment.center,
                    child: AppFilledButton2(
                      label: 'Kết bạn',
                      onPressed: () {
                        HomeController(ref: ref, context: context)
                            .handleAddFriend(receiverId: value.id);
                      },
                    ),
                  ),
                  AppCard(
                      hasBgColor: true,
                      bgColor: Colors.transparent,
                      child: AppTextHeadlineMedium(text: 'Ngoc Phuong Trang')),
                  AppCard(
                    hasBgColor: false,
                    child: Row(
                      children: [
                        Icon(Icons.edit_square),
                        AppWidthSpacer(
                          width: 12,
                        ),
                        Expanded(
                            child: Text(
                                'Chỉ mất 3 giây để nói lời yêu, nhưng phải mất cả cuộc đời để chứng minh điều đó.')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        AsyncError(:final error, :final stackTrace) => Center(
            child: Text('${error.toString()} ${stackTrace}'),
          ),
        _ => LoadingScreen()
      }),
    );
  }
}
