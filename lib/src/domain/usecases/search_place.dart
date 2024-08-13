import 'package:skysense/core/error/failure.dart';
import 'package:skysense/core/usecase/usecase.dart';
import 'package:skysense/src/data/models/search_place_model.dart';
import 'package:skysense/src/domain/repositories/weather_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchPlace implements UseCase<List<SearchPlaceModel>, String> {
  final WeatherRepository weatherRepository;
  SearchPlace(this.weatherRepository);

  @override
  Future<Either<Failure, List<SearchPlaceModel>>> call(String query) async {
    return await weatherRepository.searchPlace(query);
  }
}