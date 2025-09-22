import 'package:flutter/material.dart';
import '../../../data/models/gif_model.dart';
import '../../detail/presentation/detail_screen.dart';

class GifTile extends StatelessWidget {
  final GifModel gif;

  const GifTile({super.key, required this.gif});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DetailScreen(gif: gif),
        ));
      },
      child: Hero(
        tag: gif.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            gif.previewUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.broken_image, size: 64),
          ),
        ),
      ),
    );
  }
}
