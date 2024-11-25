import 'package:cafedating/models/selected_position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapData {
  List<Marker> markerList;
  SelectedPosition selectedPosition;
  MapData({required this.markerList, required this.selectedPosition});
}
