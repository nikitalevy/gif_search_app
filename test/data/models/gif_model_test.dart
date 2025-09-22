import 'package:flutter_test/flutter_test.dart';
import 'package:chi_giphy/data/models/gif_model.dart';

void main() {
  test('GifModel parses from JSON', () {
    final json = {
      'id': '123',
      'title': 'Funny Cat',
      'images': {
        'fixed_height_small': {
          'url': 'https://example.com/preview.gif',
          'webp': 'https://example.com/preview.webp',
        },
        'original': {
          'url': 'https://example.com/original.gif',
          'webp': 'https://example.com/original.webp',
        },
      },
    };

    final gif = GifModel.fromJson(json);

    expect(gif.id, '123');
    expect(gif.title, 'Funny Cat');
    expect(gif.previewUrl, contains('preview'));
    expect(gif.detailUrl, contains('original'));
  });
}
