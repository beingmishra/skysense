import 'package:get_it/get_it.dart';
import 'package:skysense/src/data/datasources/weather_remote_datasource.dart';
import 'package:skysense/src/data/repositories/weather_repository_impl.dart';
import 'package:skysense/src/domain/repositories/weather_repository.dart';
import 'package:skysense/src/domain/usecases/get_weather_info.dart';
import 'package:skysense/src/presentation/bloc/weather_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Datasource
  serviceLocator
    ..registerFactory<WeatherRemoteDatasource>(
          () => WeatherRemoteDatasourceImpl(),
    )
  // Repository
    ..registerFactory<WeatherRepository>(
          () => WeatherRepositoryImpl(
        serviceLocator(),
      ),
    )
  // UseCases
    ..registerFactory(
          () => GetWeatherInfo(
        serviceLocator(),
      ),
    )

  // Bloc
    ..registerLazySingleton(
          () => WeatherBloc(
        getWeatherInfo: serviceLocator(),
      ),
    );
}