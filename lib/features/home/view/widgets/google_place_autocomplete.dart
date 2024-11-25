import 'package:cafedating/core/common/widgets/app_chip.dart';
import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/common/widgets/app_loader.dart';
import 'package:cafedating/core/common/widgets/place_types_widget.dart';
import 'package:cafedating/core/common/widgets/star_rating.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/home/controller/home_controller.dart';
import 'package:cafedating/features/home/notifier/async_place_details_notifier.dart';
import 'package:cafedating/features/home/notifier/google_places_notifier.dart';
import 'package:cafedating/features/home/notifier/google_places_search_key_notifier.dart';
import 'package:cafedating/features/home/notifier/location_notifier.dart';
import 'package:cafedating/features/home/notifier/new_key_notifier.dart';
import 'package:cafedating/features/home/notifier/place_details_async.dart';
import 'package:cafedating/features/home/notifier/place_details_notifier.dart';
import 'package:cafedating/features/home/notifier/place_id_notifier.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/features/home/notifier/selected_position_notifier.dart';
import 'package:cafedating/features/home/notifier/user_location_notifier.dart';
import 'package:cafedating/features/loader/loader_notifier.dart';
import 'package:cafedating/models/google_places_response_item.dart';
import 'package:cafedating/models/place_details.dart';
import 'package:cafedating/models/selected_position.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class GooglePlaceAutocomplete extends ConsumerStatefulWidget {
  const GooglePlaceAutocomplete({super.key});

  @override
  ConsumerState<GooglePlaceAutocomplete> createState() =>
      _GooglePlaceAutocompleteState();
}

class _GooglePlaceAutocompleteState
    extends ConsumerState<GooglePlaceAutocomplete> {
  TextEditingController placesTextEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    placesTextEditingController.addListener(_listener);
  }

  @override
  void dispose() {
    placesTextEditingController.removeListener(_listener);
    super.dispose();
  }

  String searchKey = '';
  List<GooglePlacesResponseItem> googlePlaceList = [];
  GooglePlacesResponseItem selectedPlace = GooglePlacesResponseItem(
      description: '',
      matched_substrings: [],
      place_id: '',
      reference: '',
      structured_formatting: {},
      terms: [],
      types: []);
  void updateSelectedPlace(selectedPlace) {
    setState(() {
      selectedPlace = selectedPlace;
    });
  }

  void _listener() {
    // setState(() {
    //   searchKey = placesTextEditingController.text;
    //   HomeController(ref: ref, context: context)
    //       .fetchGooglePlaces(searchKey)
    //       .then((value) {
    //     setState(() {
    //       googlePlaceList = value;
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    final PlaceDetails placeDetailsData =
        ref.watch(placeDetailsNotifierProvider);
    // print('autocomplete ${placeDetailsData.name}');
    // print('autocomplete $googlePlaceList');
    // final googlePlacesData = ref.watch(googlePlacesNotifierProvider);
    // final googlePlacesAsync = ref.watch(googlePlacesAsyncProvider);
    // final AsyncValue<PlaceDetails> placeDetailsAsync =
    //     ref.watch(placeDetailsAsyncProvider(selectedPlace!.place_id));
    final locationData = ref.watch(userLocationNotifierProvider);
    // final asyncPlaceDetails =
    //     ref.watch(asyncPlaceDetailsNotifierProvider(selectedPlace.place_id));
    ref.listen(locationProvider, (prev, next) {
      if (next.hasValue) {
        ref
            .watch(userLocationNotifierProvider.notifier)
            .updateUserLocation(next.value!);
      }
    });

    return Column(
      children: [
        // Column(children: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        //     child: Row(
        //       children: [
        //         Expanded(
        //           flex: 1,
        //           child: Container(
        //             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //             color: isLightTheme
        //                 ? AppTheme.secondaryContainerColor
        //                 : AppTheme.darkSecondaryContainerColor,
        //             child: Row(
        //               children: [
        //                 Icon(Icons.my_location,
        //                     color: isLightTheme
        //                         ? AppTheme.onSecondaryContainerColor
        //                         : AppTheme.darkOnSecondaryContainerColor),
        //                 SizedBox(
        //                   width: 8,
        //                 ),
        //                 Flexible(
        //                     child: Text(
        //                   locationData.location,
        //                   style: TextStyle(fontSize: 10),
        //                 ))
        //               ],
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           flex: 1,
        //           child: Row(
        //             children: [
        //               Icon(Icons.location_on),
        //               Text(placeDetailsData.name)
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ]),
        Autocomplete<GooglePlacesResponseItem>(
          optionsBuilder: (TextEditingValue googlePlacesTextEditingValue) {
            // if user is input nothing
            if (googlePlacesTextEditingValue.text == '') {
              return const Iterable<GooglePlacesResponseItem>.empty();
            }
            // List<GooglePlacesResponseItem> placesData = [];

            // for (var i = 0; i < googlePlacesData.length; i++) {
            //   placesData.add(googlePlacesData[i]);
            // }

            // List<GooglePlacesResponseItem> places =
            //     List<GooglePlacesResponseItem>.from(placesData);
            return googlePlaceList.where((GooglePlacesResponseItem option) {
              return option.description
                  .contains(googlePlacesTextEditingValue.text.toLowerCase());
            });
          },
          displayStringForOption: (option) => option.description,
          fieldViewBuilder: ((context, textEditingController, focusNode,
                  onFieldSubmitted) =>
              TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                onFieldSubmitted: (value) {},
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    hintText: "Search location",
                    filled: true,
                    fillColor: Colors.white,
                    suffixIconColor: AppTheme.primaryColorLight,
                    suffixIcon: textEditingController.text.length > 0
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              textEditingController.clear();
                              setState(() {
                                searchKey = '';
                              });
                            },
                          )
                        : SizedBox.shrink(),
                    prefixIcon: IconButton(
                      onPressed: selectedPlace.place_id == ''
                          ? null
                          : () {
                              HomeController(ref: ref, context: context)
                                  .fetchPlaceDetails(selectedPlace.place_id);
                            },
                      icon: Icon(Icons.search, color: AppTheme.primaryColor),
                      disabledColor: Colors.grey,
                    ),
                    prefixIconColor: AppTheme.primaryColorLight,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.primaryColorLight!),
                        borderRadius: BorderRadius.circular(8))),
                onChanged: (value) {
                  setState(() {
                    searchKey = value;
                  });
                  HomeController(ref: ref, context: context)
                      .fetchGooglePlaces(searchKey)
                      .then((value) {
                    setState(() {
                      googlePlaceList = value;
                    });
                  });
                },
              )),
          onSelected: (GooglePlacesResponseItem place) {
            setState(() {
              selectedPlace = place;
            });
          },
        ),
      ],
    );
  }
}
