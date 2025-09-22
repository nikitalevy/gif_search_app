import 'package:flutter/material.dart';
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
            child: Image.network(
              gif.detailUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.broken_image, size: 64),
            ),
          ),
        ),
      ),
    );
  }
}
