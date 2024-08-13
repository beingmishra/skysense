part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}


class GetWeatherEvent extends WeatherEvent {
  final String locationName;

  const GetWeatherEvent({required this.locationName});

  @override
  List<Object> get props => [locationName];
}

class SearchPlaceEvent extends WeatherEvent {
  final String query;

  const SearchPlaceEvent({required this.query});

  @override
  List<Object> get props => [query];
}