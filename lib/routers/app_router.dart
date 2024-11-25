import 'package:cafedating/features/search/view/search_screen.dart';
import 'package:cafedating/features/application/view/application.dart';
import 'package:cafedating/features/cafe/views/cafe_list_screen.dart';
import 'package:cafedating/features/home/view/home_screen.dart';
import 'package:cafedating/features/home/view/person_profile_screen.dart';
import 'package:cafedating/features/loader/loading_screen.dart';
import 'package:cafedating/features/location_permission/view/location_permission_screen.dart';
import 'package:cafedating/features/login/view/login_screen.dart';
import 'package:cafedating/features/onboarding/view/onboarding_page_view.dart';
import 'package:cafedating/features/onboarding/view/widgets/onboarding_screen.dart';
import 'package:cafedating/features/profile/view/profile_screen.dart';
import 'package:cafedating/features/profile/widgets/change_name_screen.dart';
import 'package:cafedating/features/profile/widgets/college_selection_screen.dart';
import 'package:cafedating/features/profile/widgets/interest_selection.dart';
import 'package:cafedating/features/profile/widgets/profile_image_screen.dart';
import 'package:cafedating/features/register/view/register_screen.dart';
import 'package:cafedating/features/splash/view/splash_screen.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/routers/route_names.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static List<dynamic> routes() {
    return [
      RouteEntity(path: RouteNames.splash, page: const SplashScreen()),
      RouteEntity(path: RouteNames.home, page: const HomeScreen()),
      RouteEntity(path: RouteNames.onboarding, page: OnboardingPageView()),
      RouteEntity(path: RouteNames.login, page: const LoginScreen()),
      RouteEntity(path: RouteNames.register, page: const RegisterScreen()),
      RouteEntity(path: RouteNames.profile, page: const ProfileScreen()),
      RouteEntity(
          path: RouteNames.requestLocationPermisison,
          page: const LocationPermissionScreen()),
      RouteEntity(
          path: RouteNames.interestSelection, page: const InterestSelection()),
      RouteEntity(
          path: RouteNames.collegeSelection,
          page: const CollegeSelectionScreen()),
      RouteEntity(
          path: RouteNames.profileImage, page: const ProfileImageScreen()),
      RouteEntity(path: RouteNames.loadingScreen, page: const LoadingScreen()),
      RouteEntity(
          path: RouteNames.changeNameScreen, page: const ChangeNameScreen()),
      RouteEntity(
          path: RouteNames.cafeListScreen, page: const CafeListScreen()),
      RouteEntity(
          path: RouteNames.personProfileScreen,
          page: const PersonProfileScreen()),
      RouteEntity(path: RouteNames.searchScreen, page: const SearchScreen()),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      print('current route: ${settings.name}');
    }
    Future.delayed(Duration(seconds: 3), () {
      if (settings.name != null) {
        var result = routes().where((element) => element.path == settings.name);
        // if (result.isNotEmpty) {
        //   bool deviceFirstTime = Global.storageService.getDeviceFirstOpen();
        //   print(deviceFirstTime);
        //   if (result.first.path == RouteNames.onboarding && deviceFirstTime) {
        //     print('onboarding');
        //     bool isLoggIn = Global.storageService.isLoggedIn();
        //     if (isLoggIn) {
        //       return MaterialPageRoute(
        //           builder: (_) => const Application(), settings: settings);
        //     }
        //     return MaterialPageRoute(
        //         builder: (_) => result.first.page, settings: settings);
        //   }
        // } else {
        //   if (kDebugMode) {
        //     print('App run for the first time');
        //   }
        // }
        if (result.isNotEmpty) {
          bool isLoggIn = Global.storageService.isLoggedIn();
          if (result.first.path == RouteNames.onboarding && isLoggIn) {
            return MaterialPageRoute(
                builder: (_) => const Application(), settings: settings);
          }
          return MaterialPageRoute(
              builder: (_) => result.first.page, settings: settings);
        }
      }
    });
    return MaterialPageRoute(
        builder: (_) => const LoginScreen(), settings: settings);
  }
}

class RouteEntity {
  String path;
  Widget page;
  RouteEntity({required this.path, required this.page});
}
