import 'package:cafedating/core/common/widgets/app_loader.dart';
import 'package:cafedating/core/common/widgets/app_text_body_medium.dart';
import 'package:cafedating/core/common/widgets/app_text_label_small.dart';
import 'package:cafedating/core/common/widgets/app_text_title_small.dart';
import 'package:cafedating/core/common/widgets/cafe_type_icons.dart';
import 'package:cafedating/core/common/widgets/star_rating.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/cafe/notifier/async_cafe_list.dart';
import 'package:cafedating/features/loader/loading_screen.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CafeListScreen extends ConsumerStatefulWidget {
  const CafeListScreen({super.key});

  @override
  ConsumerState<CafeListScreen> createState() => _CafeListScreenState();
}

class _CafeListScreenState extends ConsumerState<CafeListScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    String userId =
        Global.storageService.getString(AppConstants.userId).toString();
    final asyncCafeListData = ref.watch(asyncCafeListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Cafes'),
          ],
        ),
        centerTitle: true,
      ),
      body: switch (asyncCafeListData) {
        AsyncData(:final value) => ListView.separated(
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
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: value[index].photoReference != ''
                                        ? Image.network(
                                                'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${value[index].photoReference}&key=${AppConstants.googleMapApiKey}')
                                            .image
                                        : Image.asset(
                                                '${AppConstants.imageUrl}/no-image.jpg')
                                            .image
                                    // : Image.asset(
                                    //         '${AppConstants.imageUrl}/cafe-shop.jpg')
                                    //     .image
                                    )),
                          ),
                          Positioned(
                              top: 12,
                              right: 12,
                              child: GestureDetector(
                                onTap: () {
                                  ref
                                      .read(asyncCafeListProvider.notifier)
                                      .toggleBookmark(value[index].placeId);
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                      color: isLightTheme
                                          ? AppTheme.tertiaryContainerColor
                                          : AppTheme.darkTertiaryContainerColor,
                                      shape: BoxShape.circle),
                                  child:
                                      !value[index].bookmarkers.contains(userId)
                                          ? Icon(
                                              Icons.bookmark_outline,
                                              size: 20,
                                              color: isLightTheme
                                                  ? AppTheme
                                                      .onTertiaryContainerColor
                                                  : AppTheme
                                                      .darkOnTertiaryContainerColor,
                                            )
                                          : Icon(
                                              Icons.bookmark,
                                              size: 20,
                                              color: isLightTheme
                                                  ? AppTheme
                                                      .onTertiaryContainerColor
                                                  : AppTheme
                                                      .darkOnTertiaryContainerColor,
                                            ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextTitleSmall(text: value[index].name),
                            value[index].rating > 0
                                ? Row(
                                    children: [
                                      StarRating(
                                          rating: value[index].rating.round()),
                                      value[index].userRatingsTotal > 0
                                          ? AppTextLabelSmall(
                                              text: value[index]
                                                  .userRatingsTotal
                                                  .toString())
                                          : const SizedBox.shrink()
                                    ],
                                  )
                                : StarRating(rating: 0),
                            value[index].formattedAddress != ''
                                ? AppTextBodyMedium(
                                    text: value[index].formattedAddress)
                                : SizedBox.shrink(),
                            value[index].distance > 0
                                ? AppTextLabelSmall(
                                    text:
                                        '${value[index].distance.toStringAsFixed(1)} km')
                                : SizedBox.shrink(),
                            CafeTypeIcons(types: value[index].types),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: value.length),
        AsyncError(:final error, :final stackTrace) => Center(
            child: Text('Không thể tải dữ liệu $error'),
          ),
        _ => Center(
            child: AppLoader(),
          )
      },
    );
  }
}
