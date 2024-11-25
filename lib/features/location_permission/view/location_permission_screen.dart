import 'package:cafedating/core/common/widgets/app_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_loader.dart';
import 'package:cafedating/features/location_permission/controller/location_permission_controller.dart';
import 'package:cafedating/routers/route_names.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionScreen extends ConsumerStatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  ConsumerState<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState
    extends ConsumerState<LocationPermissionScreen> {
  late Future<Position> requestLocationPermission;
  @override
  void initState() {
    super.initState();
    requestLocationPermission =
        LocationPermissionController(ref: ref).requestPermissionGeolocator();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: requestLocationPermission,
        builder: (context, data) {
          if (data.hasData) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.application, (route) => false);
            });
          }
          if (data.hasError) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data.error.toString()),
                      SizedBox(height: 12),
                      AppFilledButton(
                          label: 'Bật vị trí',
                          hasIcon: false,
                          onPressed: () => Geolocator.openLocationSettings())
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: AppLoader(),
              ),
            );
          }
        });
  }
}
