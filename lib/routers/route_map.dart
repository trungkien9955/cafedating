import 'package:cafedating/features/search/view/search_screen.dart';
import 'package:cafedating/features/application/view/application.dart';
import 'package:cafedating/features/auth/view/screens/login_screen.dart';
import 'package:cafedating/features/cafe/views/cafe_list_screen.dart';
import 'package:cafedating/features/home/view/home_screen.dart';
import 'package:cafedating/features/home/view/person_profile_screen.dart';
import 'package:cafedating/features/loader/loading_screen.dart';
import 'package:cafedating/features/location_permission/view/location_permission_screen.dart';
import 'package:cafedating/features/login/view/login_screen.dart';
import 'package:cafedating/features/onboarding/view/onboarding_page_view.dart';
import 'package:cafedating/features/profile/view/profile_screen.dart';
import 'package:cafedating/features/profile/widgets/change_name_screen.dart';
import 'package:cafedating/features/profile/widgets/college_selection_screen.dart';
import 'package:cafedating/features/profile/widgets/interest_selection.dart';
import 'package:cafedating/features/profile/widgets/profile_image_screen.dart';
import 'package:cafedating/features/register/view/register_screen.dart';
import 'package:cafedating/features/splash/view/splash_screen.dart';

var routeMap = {
  '/': (context) => OnboardingPageView(),
  '/home': (context) => HomeScreen(),
  '/splash': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/application': (context) => const Application(),
  '/profile': (context) => const ProfileScreen(),
  '/request-location-permission': (context) => const LocationPermissionScreen(),
  '/interests': (context) => const InterestSelection(),
  '/college-selection': (context) => const CollegeSelectionScreen(),
  '/profile-image': (context) => const ProfileImageScreen(),
  '/loading-screen': (context) => const LoadingScreen(),
  '/change-name': (context) => const ChangeNameScreen(),
  '/cafe-list-screen': (context) => const CafeListScreen(),
  '/person-profile-screen': (context) => const PersonProfileScreen(),
  '/search-screen': (context) => const SearchScreen(),
};
