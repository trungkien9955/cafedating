import 'package:cafedating/core/common/widgets/app_card.dart';
import 'package:cafedating/core/common/widgets/app_height_spacer.dart';
import 'package:cafedating/core/common/widgets/app_secondary_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_secondary_text_button.dart';
import 'package:cafedating/core/common/widgets/app_tertiary_text_button.dart';
import 'package:cafedating/core/common/widgets/app_text_body_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_body_small.dart';
import 'package:cafedating/core/common/widgets/app_text_label_small.dart';
import 'package:cafedating/core/common/widgets/app_text_title_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_title_small.dart';
import 'package:cafedating/features/notification/controller/noti_controller.dart';
import 'package:cafedating/features/notification/provider/async_notis.dart';
import 'package:cafedating/routers/route_names.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotiItem extends ConsumerWidget {
  String id;
  String title;
  String body;
  String type;
  String senderPhotoUrl;
  String senderId;
  String receiverId;
  String time;
  bool isRead;
  NotiItem(
      {super.key,
      required this.id,
      required this.title,
      required this.body,
      required this.type,
      required this.senderPhotoUrl,
      required this.senderId,
      required this.receiverId,
      required this.time,
      required this.isRead});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return GestureDetector(
      onTap: () {
        NotiController(context: context, ref: ref).markNotiAsRead(id);
        Navigator.pushNamed(context, RouteNames.personProfileScreen,
            arguments: {'userId': senderId}).then((value) {
          ref.refresh(asyncNotisProvider);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isLightTheme
                ? isRead
                    ? AppTheme.lowSurfaceColor
                    : AppTheme.surfaceColor
                : isRead
                    ? AppTheme.darkSurfaceColor
                    : AppTheme.darkHighSurfaceColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(senderPhotoUrl),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextTitleMedium(text: title),
                        AppTextLabelSmall(text: time)
                      ],
                    ),
                    AppHeightSpacer(height: 4),
                    AppTextBodySmall(text: body),
                    type == 'friend-request'
                        ? Wrap(
                            children: [
                              AppSecondaryTextButton(
                                label: 'Đồng ý',
                                onPressed: () {
                                  NotiController(context: context, ref: ref)
                                      .handleAcceptFriendRequest(
                                          id: id,
                                          senderId: senderId,
                                          receiverId: receiverId);
                                },
                              ),
                              const AppTertiaryTextButton(label: 'Từ chối')
                            ],
                          )
                        : type == 'friend-request-accepted'
                            ? const Wrap(
                                children: [
                                  AppSecondaryTextButton(
                                    label: 'Đã đồng ý',
                                  )
                                ],
                              )
                            : const SizedBox.shrink()
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
