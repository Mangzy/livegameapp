import 'package:bloc_list_game_apps/bloc/live_game_bloc.dart';
import 'package:bloc_list_game_apps/cubit/categories_game_cubit.dart';
import 'package:bloc_list_game_apps/widgets/item_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveGamePage extends StatefulWidget {
  const LiveGamePage({super.key});

  @override
  State<LiveGamePage> createState() => _LiveGamePageState();
}

class _LiveGamePageState extends State<LiveGamePage> {
  List<String> categories = [
    'Shooter',
    'MMORPG',
    'Horror',
    'Adventure',
    'Action',
    'Simulation',
    'Strategy',
    'Sports',
    'Racing',
    'Casual'
  ];
  @override
  void initState() {
    context.read<LiveGameBloc>().add(OnFetchLiveGame());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Games"),
        centerTitle: true,
        // add icon bookmark
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.pushNamed(context, '/saved');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<CategoriesGameCubit, String>(builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var category in categories)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<CategoriesGameCubit>()
                              .selectCategory(category);
                        },
                        child: Chip(
                          label: Text(category),
                          backgroundColor:
                              state == category ? Colors.blue : Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
          Expanded(
            child: BlocBuilder<LiveGameBloc, LiveGameState>(
              builder: (context, state) {
                if (state is LiveGameLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LiveGameLoaded) {
                  List gamesAll = state.games;
                  if (gamesAll.isEmpty) {
                    return const Center(
                      child: Text("No games"),
                    );
                  }
                  return BlocBuilder<CategoriesGameCubit, String>(
                      builder: (context, categories) {
                    List games = gamesAll
                        .where((element) => element.genre == categories)
                        .toList();
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                            onTap: () {
                              if (games[index].isSaved) {
                                context
                                    .read<LiveGameBloc>()
                                    .add(OnRemoveGame(games[index]));
                              } else {
                                context
                                    .read<LiveGameBloc>()
                                    .add(OnSaveGame(games[index]));
                              }
                            },
                          );
                        });
                  });
                } else if (state is LiveGameFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
