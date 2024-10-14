import 'package:bloc_list_game_apps/model/game.dart';
import 'package:bloc_list_game_apps/sources/game_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'live_game_event.dart';
part 'live_game_state.dart';

class LiveGameBloc extends Bloc<LiveGameEvent, LiveGameState> {
  LiveGameBloc() : super(LiveGameInitial()) {
    on<OnFetchLiveGame>((event, emit) async {
      emit(LiveGameLoading());
      List<Game>? games = await GameSource.getGame();

      if (games != null) {
        emit(LiveGameLoaded(games));
      } else {
        emit(LiveGameFailure("Failed to load games"));
      }
    });

    on<OnSaveGame>((event, emit) async {
      if (state is LiveGameLoaded) {
        final loadedState = state as LiveGameLoaded;
        List<Game> games = List.from(loadedState.games);
        int index = games.indexWhere((element) => element.id == event.game.id);

        if (index != -1) {
          Game updatedGame = games[index].copyWith(isSaved: true);
          games[index] = updatedGame;
          emit(LiveGameLoaded(games));
        }
      }
    });

    on<OnRemoveGame>((event, emit) async {
      if (state is LiveGameLoaded) {
        final loadedState = state as LiveGameLoaded;
        List<Game> games = List.from(loadedState.games);
        int index = games.indexWhere((element) => element.id == event.game.id);

        if (index != -1) {
          Game updatedGame = games[index].copyWith(isSaved: false);
          games[index] = updatedGame;
          emit(LiveGameLoaded(games));
        }
      }
    });

    on<OnGetSavedGame>((event, emit) async {
      if (state is LiveGameLoaded) {
        final loadedState = state as LiveGameLoaded;
        List<Game> games = List.from(loadedState.games);
        List<Game> savedGames =
            games.where((element) => element.isSaved).toList();
        emit(LiveGameLoaded(savedGames));
      }
    });
  }
}
