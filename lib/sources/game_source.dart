import 'dart:convert';

import 'package:bloc_list_game_apps/model/game.dart';
import 'package:d_method/d_method.dart';
import 'package:http/http.dart' as http;

class GameSource {
  static Future<List<Game>?> getGame() async {
    String url = "https://www.freetogame.com/api/games";
    final response = await http.get(Uri.parse(url));

    DMethod.logResponse(response);

    try {
      if (response.statusCode == 200) {
        List<Game> games = [];
        var data = json.decode(response.body);
        for (var item in data) {
          games.add(Game.fromJson(item));
        }
        return games;
      } else {
        throw Exception("Failed to load games");
      }
    } catch (e) {
      DMethod.log(e.toString());

      return null;
    }
  }
}
