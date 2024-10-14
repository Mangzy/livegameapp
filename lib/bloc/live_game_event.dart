part of 'live_game_bloc.dart';

sealed class LiveGameEvent {}

class OnFetchLiveGame extends LiveGameEvent {}

class OnSaveGame extends LiveGameEvent {
  final Game game;

  OnSaveGame(this.game);
}

class OnRemoveGame extends LiveGameEvent {
  final Game game;

  OnRemoveGame(this.game);
}

class OnGetSavedGame extends LiveGameEvent {}
