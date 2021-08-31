import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:submission_fundamental_1/models/models.dart';
import 'package:submission_fundamental_1/services/services.dart';
import 'package:http/http.dart' as http;

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial());

  @override
  Stream<RestaurantState> mapEventToState(
    RestaurantEvent event,
  ) async* {
    if (event is FetchRestaurants) {
      try {
        RestaurantResult restaurants =
            await RestaurantServices.getRestaurants(http.Client());
        yield RestaurantLoaded(restaurants: restaurants);
      } catch (error) {
        yield error is ResultError
            ? RestaurantError(error.message)
            : RestaurantError('Something wrong');
      }
    }
  }
}
