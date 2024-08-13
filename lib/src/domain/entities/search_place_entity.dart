class SearchPlaceEntity {
  int id;
  String name;
  String region;
  String country;
  double lat;
  double lon;
  String url;

  SearchPlaceEntity({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "url": url,
  };
}
