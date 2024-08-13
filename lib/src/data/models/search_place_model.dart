// To parse this JSON data, do
//
//     final searchPlaceEntity = searchPlaceEntityFromJson(jsonString);

import 'dart:convert';

import 'package:skysense/src/domain/entities/search_place_entity.dart';

List<SearchPlaceModel> searchPlaceEntityFromJson(String str) => List<SearchPlaceModel>.from(json.decode(str).map((x) => SearchPlaceModel.fromJson(x)));

String searchPlaceEntityToJson(List<SearchPlaceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchPlaceModel extends SearchPlaceEntity{

  SearchPlaceModel({
    required super.id,
    required super.name,
    required super.region,
    required super.country,
    required super.lat,
    required super.lon,
    required super.url,
  });

  factory SearchPlaceModel.fromJson(Map<String, dynamic> json) => SearchPlaceModel(
    id: json["id"],
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    url: json["url"],
  );

}
