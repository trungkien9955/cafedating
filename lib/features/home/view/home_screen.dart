import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cafedating/core/common/widgets/app_chip.dart';
import 'package:cafedating/core/common/widgets/app_container.dart';
import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/common/widgets/app_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_loader.dart';
import 'package:cafedating/core/common/widgets/app_search_bar.dart';
import 'package:cafedating/core/common/widgets/app_text.dart';
import 'package:cafedating/core/common/widgets/app_width_spacer.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/home/controller/home_controller.dart';
import 'package:cafedating/features/home/notifier/activity/provider.dart';
import 'package:cafedating/features/home/notifier/async_place_details_notifier.dart';
import 'package:cafedating/features/home/notifier/camera_position_notifier.dart';
import 'package:cafedating/features/home/notifier/filter_notifier.dart';
import 'package:cafedating/features/home/notifier/location_notifier.dart';
import 'package:cafedating/features/home/notifier/location_response_notifier.dart';
import 'package:cafedating/features/home/notifier/marker_data_list_notifier.dart';
import 'package:cafedating/features/home/notifier/marker_list.dart';
import 'package:cafedating/features/home/notifier/nearby_persons_notifier.dart';
import 'package:cafedating/features/home/notifier/persons_notifier.dart';
import 'package:cafedating/features/home/notifier/place_details_async.dart';
import 'package:cafedating/features/home/notifier/place_details_notifier.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/features/home/notifier/selected_position_notifier.dart';
import 'package:cafedating/features/home/notifier/user_location_notifier.dart';
import 'package:cafedating/features/home/view/widgets/filter_drawer.dart';
import 'package:cafedating/features/home/view/widgets/google_place_autocomplete.dart';
import 'package:cafedating/features/loader/loading_screen.dart';
import 'package:cafedating/features/login/controller/login_controller.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/activity.dart';
import 'package:cafedating/models/filter_model.dart';
import 'package:cafedating/models/location_response.dart';
import 'package:cafedating/models/map_data.dart';
import 'package:cafedating/models/marker_data_entity.dart';
import 'package:cafedating/models/marker_profile.dart';
import 'package:cafedating/models/persons.dart';
import 'package:cafedating/models/place_details.dart';
import 'package:cafedating/models/selected_position.dart';
import 'package:cafedating/routers/route_names.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    // requestPermissionGeolocator();
    HomeController(ref: ref, context: context).requestPermissionGeolocator();
    // HomeController(ref: ref, context: context).requestNotificationPermission();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
    HomeController(ref: ref, context: context).updateFcmToken();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }
  @override
  void dispose() {
    super.dispose();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    final AsyncValue<MapData> nearbyPersonsData =
        ref.watch(nearbyPersonsProvider);
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();
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
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              locationData.location != ''
                  ? Expanded(
                      child: Text(
                        ' ${locationData.location}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          centerTitle: true,
        ),
        drawer: const FilterDrawer(),
        body: switch (nearbyPersonsData) {
          AsyncData(:final value) => Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        mapType: MapType.normal,
                        // initialCameraPosition: CameraPosition(
                        //     target: LatLng(37.785834, -122.406417),
                        //     zoom: AppConstants.cameraZoom),
                        initialCameraPosition: CameraPosition(
                            target: LatLng(value.selectedPosition.lat,
                                value.selectedPosition.lng),
                            zoom: AppConstants.cameraZoom),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        myLocationButtonEnabled: false,
                        markers: Set<Marker>.of(value.markerList),
                        circles: Set.from([
                          Circle(
                              circleId: CircleId('Current location'),
                              center: LatLng(value.selectedPosition.lat,
                                  value.selectedPosition.lng),
                              radius: 5,
                              strokeColor: Colors.pink),
                          Circle(
                            circleId: CircleId('Current radius'),
                            center: LatLng(value.selectedPosition.lat,
                                value.selectedPosition.lng),
                            radius: 1000,
                            strokeColor: Colors.blue.shade300.withOpacity(0.3),
                            strokeWidth: 1,
                            fillColor: Colors.blue.shade300.withOpacity(0.3),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                const Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: GooglePlaceAutocomplete(),
                    )),
                Positioned(
                    bottom: 24,
                    right: 24,
                    child: FloatingActionButton(
                      onPressed: () {
                        HomeController(ref: ref, context: context)
                            .requestPermissionGeolocator();
                      },
                      child: Icon(
                        Icons.my_location,
                        color: isLightTheme
                            ? AppTheme.onPrimaryContainerColor
                            : AppTheme.darkOnPrimaryContainerColor,
                      ),
                    )),
                // AppFilledButton(
                //     label: 'Print',
                //     hasIcon: false,
                //     onPressed: () {
                //       Global.storageService
                //           .setString(AppConstants.placeDetails, '');
                //       Global.storageService
                //           .setString(AppConstants.googlePlacesList, '');
                //     }),
                // Text(positionData.latitude.toString())
              ],
            ),
          AsyncError(:final error, :final stackTrace) => Center(
              child: Text('Không thể tải dữ liệu'),
            ),
          _ => const LoadingScreen()
        });
  }
}
