part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();
}

final class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}


final class WeatherLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

final class WeatherFailure extends WeatherState {
  final String error;
  const WeatherFailure(this.error);

  @override
  List<Object?> get props => [error];
}


final class WeathersDisplaySuccess extends WeatherState {
  final WeatherDataModel? weatherData;
  const WeathersDisplaySuccess(this.weatherData);

  @override
  List<Object?> get props => [weatherData];
}
