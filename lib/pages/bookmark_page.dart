import 'package:bloc_list_game_apps/bloc/live_game_bloc.dart';
import 'package:bloc_list_game_apps/model/game.dart';
import 'package:bloc_list_game_apps/widgets/item_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark"),
        centerTitle: true,
      ),
      body: BlocBuilder<LiveGameBloc, LiveGameState>(
        builder: (context, state) {
          if (state is LiveGameLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LiveGameLoaded) {
            if (state.games.isEmpty) {
              return const Center(child: Text("No bookmarked games"));
            }
            List<Game> games =
                state.games.where((element) => element.isSaved).toList();
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(2),
              itemCount: games.length,
              itemBuilder: (context, index) {
                return ItemGame(
                  games: games,
                  index: index,
                  onTap: () {},
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
