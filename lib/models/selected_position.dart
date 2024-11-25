class SelectedPosition {
  double lat;
  double lng;
  SelectedPosition({required this.lat, required this.lng});
  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
