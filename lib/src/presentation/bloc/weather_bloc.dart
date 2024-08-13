import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skysense/src/data/models/search_place_model.dart';
import 'package:skysense/src/data/models/weather_data_model.dart';
import 'package:skysense/src/domain/usecases/get_weather_info.dart';
import 'package:skysense/src/domain/usecases/search_place.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherInfo _getWeatherInfo;
  final SearchPlace _searchPlace;
  WeatherBloc({required GetWeatherInfo getWeatherInfo, required SearchPlace searchPlace}) :
        _getWeatherInfo = getWeatherInfo,
        _searchPlace = searchPlace,
        super(WeatherInitial()) {
    on<GetWeatherEvent>(_onGetWeatherInfo);
    on<SearchPlaceEvent>(_onSearchPlace);
  }

  FutureOr<void> _onGetWeatherInfo(GetWeatherEvent event, Emitter<WeatherState> emit) async {

    emit(WeatherLoading());

    final res = await _getWeatherInfo(event.locationName);

    res.fold(
          (l) => emit(WeatherFailure(l.message)),
          (r) => emit(WeathersDisplaySuccess(r)),
    );
  }

  FutureOr<void> _onSearchPlace(SearchPlaceEvent event, Emitter<WeatherState> emit) async {

    emit(WeatherLoading());

    final res = await _searchPlace(event.query);

    res.fold(
          (l) => emit(WeatherFailure(l.message)),
          (r) => emit(SearchPlaceSuccess(r)),
    );
  }
}
