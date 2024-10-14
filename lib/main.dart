import 'package:bloc_list_game_apps/bloc/live_game_bloc.dart';
import 'package:bloc_list_game_apps/cubit/categories_game_cubit.dart';
import 'package:bloc_list_game_apps/pages/bookmark_page.dart';
import 'package:bloc_list_game_apps/pages/live_game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LiveGameBloc()),
        BlocProvider(create: (context) => CategoriesGameCubit())
      ],
      child: MaterialApp(home: const LiveGamePage(), routes: {
        '/saved': (context) => const BookmarkPage(),
      }),
    );
  }
}
