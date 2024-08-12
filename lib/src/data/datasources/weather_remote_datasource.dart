import 'dart:developer';
import 'dart:io';

import 'package:skysense/core/error/exceptions.dart';
import 'package:skysense/src/data/models/weather_data_model.dart';
import 'package:http/http.dart' as http;

abstract interface class WeatherRemoteDatasource {
  Future<WeatherDataModel?> getWeatherInfo(String locationName);
}

class WeatherRemoteDatasourceImpl extends WeatherRemoteDatasource {
  @override
  Future<WeatherDataModel?> getWeatherInfo(String locationName) async {
    try {
     var response = await http.get(Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=${const String.fromEnvironment("APIKEY")}&q=$locationName&days=1&aqi=no&alerts=no"));

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

}