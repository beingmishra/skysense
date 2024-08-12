import 'package:skysense/core/error/failure.dart';
import 'package:skysense/src/data/models/weather_data_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class WeatherRepository {
  Future<Either<Failure, WeatherDataModel?>> getWeatherInfo(String locationName);
}