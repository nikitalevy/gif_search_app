import 'package:flutter_test/flutter_test.dart';
import 'package:chi_giphy/data/services/giphy_api_service.dart';

void main() {
  test('GiphyApiService returns list of GifModel', () async {
    final service = GiphyApiService();

    final gifs = await service.searchGifs(
      query: 'cat',
      limit: 1,
      offset: 0,
    );

    expect(gifs, isNotEmpty);
    expect(gifs.first.id, isNotEmpty);
  });
}
