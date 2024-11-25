import 'package:cafedating/core/common/widgets/app_card.dart';
import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_height_spacer.dart';
import 'package:cafedating/core/common/widgets/app_text_body_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_label_small.dart';
import 'package:cafedating/core/common/widgets/app_text_title_large.dart';
import 'package:cafedating/core/common/widgets/app_text_title_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_title_small.dart';
import 'package:cafedating/core/common/widgets/app_width_spacer.dart';
import 'package:cafedating/core/common/widgets/cafe_type_icons.dart';
import 'package:cafedating/core/common/widgets/place_types_widget.dart';
import 'package:cafedating/core/common/widgets/star_rating.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/cafe/controller/cafes_screen_controller.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/models/cafe_entities.dart';
import 'package:cafedating/routers/route_names.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class CafesScreen extends ConsumerStatefulWidget {
  const CafesScreen({super.key});

  @override
  ConsumerState<CafesScreen> createState() => _CafesScreenState();
}

class _CafesScreenState extends ConsumerState<CafesScreen> {
  List<CafeResponseItem> cafeList = [];
  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final Position positionData = ref.watch(positionNotifierProvider);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(12.0),
        child: cafeList.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeightSpacer(height: 24),
                  // Text(positionData.latitude.toString()),
                  const AppTextTitleLarge(
                      text:
                          'Tìm cafe gần bạn và xem những ai đang hoặc sẽ ở đó...'),
                  const AppHeightSpacer(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child:
                        Image.asset('${AppConstants.imageUrl}/cafe-shop.jpg'),
                  ),
                  AppHeightSpacer(height: 20),
                  AppFilledButton2(
                    label: 'Tìm kiếm',
                    onPressed: () {
                      // CafesScreenController(context: context, ref: ref)
                      //     .fetchCafes();
                      Navigator.pushNamed(context, RouteNames.cafeListScreen);
                    },
                  )
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemCount: 3,
                        padding: const EdgeInsets.all(12),
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: isLightTheme
                                  ? AppTheme.surfaceColor
                                  : AppTheme.darkSurfaceContainerColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: cafeList[index]
                                                        .photoList
                                                        .isNotEmpty
                                                    ?
                                                    // ? Image.network(
                                                    //         'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${cafeList[index].photoList[0]['photo_reference']}&key=${AppConstants.googleMapApiKey}')
                                                    //     .image
                                                    Image.asset(
                                                            '${AppConstants.imageUrl}/no-image.jpg')
                                                        .image
                                                    : Image.asset(
                                                            '${AppConstants.imageUrl}/cafe-shop.jpg')
                                                        .image)),
                                      ),
                                      Positioned(
                                          top: 12,
                                          right: 12,
                                          child: Container(
                                            height: 36,
                                            width: 36,
                                            decoration: BoxDecoration(
                                                color: isLightTheme
                                                    ? AppTheme
                                                        .tertiaryContainerColor
                                                    : AppTheme
                                                        .darkTertiaryContainerColor,
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              Icons.bookmark_outline,
                                              size: 20,
                                              color: isLightTheme
                                                  ? AppTheme
                                                      .onTertiaryContainerColor
                                                  : AppTheme
                                                      .darkOnTertiaryContainerColor,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppTextTitleSmall(
                                            text: cafeList[index].name),
                                        cafeList[index].rating > 0
                                            ? Row(
                                                children: [
                                                  StarRating(
                                                      rating: cafeList[index]
                                                          .rating
                                                          .round()),
                                                  cafeList[index]
                                                              .userRatingsTotal >
                                                          0
                                                      ? AppTextLabelSmall(
                                                          text: cafeList[index]
                                                              .userRatingsTotal
                                                              .toString())
                                                      : const SizedBox.shrink()
                                                ],
                                              )
                                            : StarRating(rating: 0),
                                        cafeList[index].formattedAddress != ''
                                            ? AppTextBodyMedium(
                                                text: cafeList[index]
                                                    .formattedAddress)
                                            : SizedBox.shrink(),
                                        cafeList[index].distance > 0
                                            ? AppTextLabelSmall(
                                                text:
                                                    '${cafeList[index].distance.toStringAsFixed(1)} km')
                                            : SizedBox.shrink(),
                                        CafeTypeIcons(
                                            types: cafeList[index].types),
                                        cafeList[index]
                                                    .openingHours['open_now'] ==
                                                true
                                            ? AppTextLabelSmall(
                                                color: Colors.green,
                                                text: 'Open')
                                            : AppTextLabelSmall(
                                                color: Colors.red,
                                                text: 'Closed')
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
      )),
    );
  }
}
