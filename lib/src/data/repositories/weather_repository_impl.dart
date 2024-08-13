import 'package:skysense/core/error/exceptions.dart';
import 'package:skysense/core/error/failure.dart';
import 'package:skysense/src/data/datasources/weather_remote_datasource.dart';
import 'package:skysense/src/data/models/search_place_model.dart';
import 'package:skysense/src/data/models/weather_data_model.dart';
import 'package:skysense/src/domain/repositories/weather_repository.dart';
import 'package:fpdart/fpdart.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource weatherRemoteDatasource;


  WeatherRepositoryImpl(this.weatherRemoteDatasource);

  @override
  Future<Either<Failure, WeatherDataModel?>> getWeatherInfo(String locationName) async {
    try {
      final data = await weatherRemoteDatasource.getWeatherInfo(locationName);
      if(data != null) {
        return right(data);
      }else {
        return left(Failure("Data not found"));
      }

    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<SearchPlaceModel>>> searchPlace(String query) async {
    try {
      final data = await weatherRemoteDatasource.searchPlace(query);
      if(data.isNotEmpty) {
        return right(data);
      }else {
        return left(Failure("Data not found"));
      }

    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}