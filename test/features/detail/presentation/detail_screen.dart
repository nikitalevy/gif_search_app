import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data/models/gif_model.dart';

class DetailScreen extends StatelessWidget {
  final GifModel gif;

  const DetailScreen({super.key, required this.gif});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gif.title)),
      body: Center(
        child: Hero(
          tag: gif.id,
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: gif.originalUrl,
              placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) => const Icon(Icons.broken_image, size: 64),
            ),
          ),
        ),
      ),
    );
  }
}
