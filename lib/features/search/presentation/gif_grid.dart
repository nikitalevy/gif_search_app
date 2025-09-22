import 'package:flutter/material.dart';
import '../../../data/models/gif_model.dart';
import 'gif_tile.dart';

class GifGrid extends StatelessWidget {
  final List<GifModel> gifs;
  final ScrollController scrollController;

  const GifGrid({
    super.key,
    required this.gifs,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4;

    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: gifs.length,
      itemBuilder: (context, index) {
        final gif = gifs[index];
        return GifTile(gif: gif);
      },
    );
  }
}
