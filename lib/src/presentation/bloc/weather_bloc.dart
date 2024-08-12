import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skysense/src/data/models/weather_data_model.dart';
import 'package:skysense/src/domain/usecases/get_weather_info.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherInfo _getWeatherInfo;
  WeatherBloc({required GetWeatherInfo getWeatherInfo}) :
        _getWeatherInfo = getWeatherInfo,
        super(WeatherInitial()) {
    on<GetWeatherEvent>(_onGetWeatherInfo);
  }

  FutureOr<void> _onGetWeatherInfo(GetWeatherEvent event, Emitter<WeatherState> emit) async {

    emit(WeatherLoading());

    final res = await _getWeatherInfo(event.locationName);

    res.fold(
          (l) => emit(WeatherFailure(l.message)),
          (r) => emit(WeathersDisplaySuccess(r)),
    );
  }
}
