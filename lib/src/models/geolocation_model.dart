class GeoLocationModel {
  String formattedAddress;
  String latitude;
  String longitude;

  GeoLocationModel();

  GeoLocationModel.fromJson(Map json) {
    updateFromJson(json);
  }

  void updateFromJson(Map json) {
    formattedAddress = json["formatted_address"];
    Map locationMap = json["geometry"]["location"];
    latitude = locationMap["lat"]?.toString();
    longitude = locationMap["lng"]?.toString();
  }

  Map<String, dynamic> toJson() => {"lat": latitude, "lng": longitude};

  bool get isEmpty => latitude == null || longitude == null;

  bool get isNotEmpty => !isEmpty;
}
