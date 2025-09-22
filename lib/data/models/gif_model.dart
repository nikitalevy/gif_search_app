class GifModel {
  final String id;
  final String title;
  final String previewUrl; // маленькая/превью
  final String detailUrl;  // оригинал/деталь

  GifModel({
    required this.id,
    required this.title,
    required this.previewUrl,
    required this.detailUrl,
  });

  factory GifModel.fromJson(Map<String, dynamic> json) {
    final images = (json['images'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};

    String? _pick(Map<String, dynamic>? data) {
      if (data == null) return null;
      final v = (data['url'] ?? data['webp'] ?? data['gif']);
      return v is String && v.isNotEmpty ? v : null;
    }

    final preview = _pick(images['fixed_height_small']) ??
        _pick(images['fixed_height']) ??
        _pick(images['fixed_width']) ??
        _pick(images['downsized']) ??
        '';

    final original = _pick(images['original']) ?? preview;

    return GifModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      previewUrl: preview,
      detailUrl: original,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'images': {
      'fixed_height_small': {'url': previewUrl},
      'original': {'url': detailUrl},
    },
  };
}
