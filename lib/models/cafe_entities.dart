class CafeResponseItem {
  Map<String, dynamic> geometry;
  String formattedAddress;
  List<dynamic> photoList;
  double distance;
  String placeId;
  double rating;
  String reference;
  List<String> types;
  int userRatingsTotal;
  String name;
  Map<String, dynamic> openingHours;
  CafeResponseItem(
      {required this.geometry,
      required this.formattedAddress,
      required this.photoList,
      required this.distance,
      required this.placeId,
      required this.rating,
      required this.reference,
      required this.types,
      required this.userRatingsTotal,
      required this.name,
      required this.openingHours});
  factory CafeResponseItem.fromMap(Map<String, dynamic> map) =>
      CafeResponseItem(
          geometry: map['geometry'],
          formattedAddress:
              map['formatted_address'] != null ? map['formatted_address'] : '',
          photoList: map['photos'] ?? [],
          distance: 0,
          placeId: map['place_id'],
          rating:
              map['rating'] != null ? double.parse('${map['rating']}') : 0.0,
          reference: map['reference'],
          types: List<String>.from(map['types']),
          userRatingsTotal: map['user_ratings_total'] != null
              ? int.parse('${map['user_ratings_total']}')
              : 0,
          name: map['name'],
          openingHours: map['opening_hours'] ?? {});
  Map<String, dynamic> toMap() => {
        'name': name,
        'geometry': geometry,
        'formattedAddress': formattedAddress,
        'photoList': photoList,
        'placeId': placeId,
        'rating': rating,
        'reference': reference,
        'types': types,
        'userRatingsTotal': userRatingsTotal
      };
}

class Cafe {
  String name;
  Map<String, dynamic> geometry;
  String formattedAddress;
  String photoReference;
  double distance;
  String placeId;
  double rating;
  String reference;
  List<String> types;
  int userRatingsTotal;
  List<String> bookmarkers;

  Cafe(
      {required this.name,
      required this.geometry,
      required this.formattedAddress,
      required this.photoReference,
      required this.distance,
      required this.placeId,
      required this.rating,
      required this.reference,
      required this.types,
      required this.userRatingsTotal,
      required this.bookmarkers});
  factory Cafe.fromMap(Map<String, dynamic> map) => Cafe(
        name: map['name'] ?? '',
        geometry: map['geometry'] ?? '',
        formattedAddress: map['formatted_address'] ?? '',
        photoReference: map['photoReference'] ?? '',
        distance:
            map['distance'] != null ? double.parse('${map['distance']}') : 0.0,
        placeId: map['placeId'] ?? '',
        rating: map['rating'] != null ? double.parse('${map['rating']}') : 0.0,
        reference: map['reference'],
        types: List<String>.from(map['types']),
        userRatingsTotal: map['user_ratings_total'] != null
            ? int.parse('${map['user_ratings_total']}')
            : 0,
        bookmarkers: List<String>.from(map['bookmarkers']),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'geometry': geometry,
        'formattedAddress': formattedAddress,
        'photoReference': photoReference,
        'placeId': placeId,
        'rating': rating,
        'reference': reference,
        'types': types,
        'userRatingsTotal': userRatingsTotal,
        'bookmarkers': bookmarkers
      };
}

class CafeResponseItemPhoto {
  String photo_reference = '';
  CafeResponseItemPhoto({required this.photo_reference});
  factory CafeResponseItemPhoto.fromMap(Map<String, dynamic> map) =>
      CafeResponseItemPhoto(photo_reference: map['photo_reference']);
}
