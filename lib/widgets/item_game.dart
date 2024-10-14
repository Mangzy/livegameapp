import 'package:flutter/material.dart';

class ItemGame extends StatelessWidget {
  const ItemGame({
    super.key,
    required this.games,
    required this.index,
    required this.onTap,
  });

  final List games;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            games[index].thumbnail,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
            child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment(0, -0.2),
            ),
          ),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(8),
          child: Text(
            games[index].title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
        // add bookmark
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              games[index].isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
              size: 32,
            ),
            onPressed: onTap,
          ),
        ),
      ],
    );
  }
}
