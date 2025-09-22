import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/gif_model.dart';
import '../services/giphy_api_service.dart';

class GifRepository {
  final GiphyApiService api;

  GifRepository(this.api);

  Future<List<GifModel>> search({
    required String query,
    required int limit,
    required int offset,
  }) {
    return api.searchGifs(query: query, limit: limit, offset: offset);
  }
}

final gifRepositoryProvider = Provider<GifRepository>((ref) {
  final api = GiphyApiService();
  return GifRepository(api);
});
