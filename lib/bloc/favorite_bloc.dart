import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:submission_fundamental_1/repository/repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({required this.favoriteRepository}) : super(FavoriteLoading());

  final FavoriteRepository favoriteRepository;

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    
    if (event is StartFavorite) {
      yield FavoriteLoading();
      try {
        List<String> id = await favoriteRepository.getFavorite();
        yield FavoriteLoaded(id: id);
      } catch (_) {}
    } else if (event is AddFavoriteRestaurant) {
      await favoriteRepository.addFavorite(event.id);
      yield FavoriteLoaded(id: await favoriteRepository.getFavorite());
    } else if (event is RemoveFavoriteRestaurant) {
      try {
        await favoriteRepository.deleteById(event.id);
        yield FavoriteLoaded(id: await favoriteRepository.getFavorite());
      } catch (_) {}
    }
  }
}
