import 'dart:convert';

import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/models/place_details.dart';
import 'package:cafedating/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _pref;
  Future<StorageService> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> clear() async {
    await _pref.clear();
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  setBool(String key, bool value) async {
    return await _pref.setBool((key), value);
  }

  getBool(String key) async {
    return _pref.getBool(key);
  }

  bool getDeviceFirstOpen() {
    return _pref.getBool(AppConstants.firstTimeOnThisDevice) ?? false;
  }

  bool isLoggedIn() {
    return _pref.getString(AppConstants.userProfileId) != null ? true : false;
  }

  String getString(String key) {
    return _pref.getString(key) ?? '';
  }

  UserProfile getUserProfile() {
    var profile = _pref.getString(AppConstants.userProfile) ?? '';
    var profileJson = jsonDecode(profile);

    UserProfile userProfile = UserProfile.fromJson(profileJson);

    return userProfile;
  }

  List getLocationResponse() {
    String location = _pref.getString(AppConstants.locationResponse) ?? '';
    if (location != '') {
      List locationResponse = jsonDecode(location);
      return locationResponse;
    } else {
      return [];
    }
  }

  getPlaceDetails() {
    String details = _pref.getString(AppConstants.placeDetails) ?? '';
    if (details != '') {
      var placeDetails = jsonDecode(details);
      return placeDetails;
    }
  }

  getGooglePlacesList() {
    String placesList = _pref.getString(AppConstants.googlePlacesList) ?? '';
    if (placesList != '') {
      var googlePlacesList = jsonDecode(placesList);
      return googlePlacesList;
    }
  }

  getCafeList() {
    String cafeListData = _pref.getString(AppConstants.cafeList) ?? '';
    if (cafeListData != '') {
      var cafeList = jsonDecode(cafeListData);
      return cafeList;
    }
  }

  String getUserToken() {
    print('getUsertoken');
    return _pref.getString(AppConstants.userUid) ?? '';
  }
}
