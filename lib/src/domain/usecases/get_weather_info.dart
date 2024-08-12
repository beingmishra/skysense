import 'package:skysense/core/error/failure.dart';
import 'package:skysense/core/usecase/usecase.dart';
import 'package:skysense/src/data/models/weather_data_model.dart';
import 'package:skysense/src/domain/repositories/weather_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetWeatherInfo implements UseCase<WeatherDataModel?, String> {
  final WeatherRepository weatherRepository;
  GetWeatherInfo(this.weatherRepository);

  @override
  Future<Either<Failure, WeatherDataModel?>> call(String locationName) async {
    return await weatherRepository.getWeatherInfo(locationName);
  }
}