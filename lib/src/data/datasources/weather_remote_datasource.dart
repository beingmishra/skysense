import 'dart:developer';
import 'dart:io';

import 'package:skysense/core/error/exceptions.dart';
import 'package:skysense/src/data/models/search_place_model.dart';
import 'package:skysense/src/data/models/weather_data_model.dart';
import 'package:http/http.dart' as http;

abstract interface class WeatherRemoteDatasource {
  Future<WeatherDataModel?> getWeatherInfo(String locationName);
  Future<List<SearchPlaceModel>> searchPlace(String query);
}

class WeatherRemoteDatasourceImpl extends WeatherRemoteDatasource {
  @override
  Future<WeatherDataModel?> getWeatherInfo(String locationName) async {
    try {
     var response = await http.get(Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=${const String.fromEnvironment("APIKEY")}&q=$locationName&days=11&aqi=yes&alerts=no"));

     print(response.body);
     if(response.statusCode == 200) {
       var res = weatherDataModelFromJson(response.body);
       return res;
     }

    } on SocketException catch (e) {
      throw ServerException(e.message);
    } catch (e, stack) {
      log(e.toString());
      log(stack.toString());
      throw ServerException(e.toString());
    }

    return null;
  }

  @override
  Future<List<SearchPlaceModel>> searchPlace(String query) async {
    try {
      var response = await http.get(Uri.parse("http://api.weatherapi.com/v1/search.json?key=${const String.fromEnvironment("APIKEY")}&q=$query"));

      print(response.body);
      if(response.statusCode == 200) {
        var res = searchPlaceEntityFromJson(response.body);
        return res;
      }

    } on SocketException catch (e) {
      throw ServerException(e.message);
    } catch (e, stack) {
      log(e.toString());
      log(stack.toString());
      throw ServerException(e.toString());
    }

    return [];
  }

}