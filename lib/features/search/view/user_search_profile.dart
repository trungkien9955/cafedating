import 'package:cafedating/core/common/widgets/app_card.dart';
import 'package:cafedating/core/common/widgets/app_height_spacer.dart';
import 'package:cafedating/core/common/widgets/app_text_body_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_label_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_label_small.dart';
import 'package:cafedating/core/common/widgets/app_text_title_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_title_small.dart';
import 'package:cafedating/core/common/widgets/app_width_spacer.dart';
import 'package:cafedating/routers/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserSearchProfile extends StatelessWidget {
  final String id;
  final String name;
  final String photoUrl;
  final String lastSeen;
  final String joinedAt;
  final String city;
  final String hometown;
  final String distance;
  const UserSearchProfile(
      {super.key,
      required this.id,
      required this.name,
      required this.photoUrl,
      required this.lastSeen,
      required this.joinedAt,
      required this.city,
      required this.hometown,
      required this.distance});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.personProfileScreen,
            arguments: {'userId': id});
      },
      child: AppCard(
        hasBgColor: false,
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(photoUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextTitleMedium(text: name),
                      ],
                    ),
                    AppHeightSpacer(height: 6),
                    AppTextLabelSmall(text: 'Ngày tham gia: $joinedAt'),
                    AppTextLabelSmall(text: 'Online $lastSeen'),
                    AppHeightSpacer(height: 6),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 12,
                      children: [
                        Wrap(
                          children: [
                            const Icon(
                              Icons.sync_alt,
                              size: 16,
                            ),
                            AppTextLabelSmall(text: '$distance km'),
                          ],
                        ),
                        Wrap(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                            ),
                            AppTextLabelSmall(text: city),
                          ],
                        ),
                        Wrap(
                          children: [
                            const Icon(
                              Icons.home,
                              size: 16,
                            ),
                            AppTextLabelSmall(text: hometown),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
