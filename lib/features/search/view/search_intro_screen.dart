import 'package:cafedating/core/common/widgets/app_card.dart';
import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_height_spacer.dart';
import 'package:cafedating/core/common/widgets/app_text_label_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_title_large.dart';
import 'package:cafedating/core/common/widgets/app_width_spacer.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/routers/route_names.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchIntroScreen extends StatelessWidget {
  const SearchIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeightSpacer(height: 24),
            const AppTextTitleLarge(text: 'Tìm bạn bè xung quanh bạn'),
            const AppHeightSpacer(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset('${AppConstants.imageUrl}/people-group.jpg'),
            ),
            AppHeightSpacer(height: 12),
            AppCard(
              hasBgColor: false,
              child: Row(
                children: [
                  Container(
                      child: Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.info_outline),
                  )),
                  Expanded(
                    child: AppTextLabelMedium(
                        text:
                            'Bạn có thể tìm kiếm theo thành phố, quê quán, hoặc nghề nghiệp'),
                  )
                ],
              ),
            ),
            AppHeightSpacer(height: 12),
            AppFilledButton2(
              label: 'Bắt đầu',
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.searchScreen);
              },
            )
          ],
        ),
      )),
    );
  }
}
