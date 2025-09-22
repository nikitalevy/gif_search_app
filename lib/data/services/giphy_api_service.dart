import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../models/gif_model.dart';

class GiphyApiService {
  final http.Client _client;

  GiphyApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<GifModel>> searchGifs({
    required String query,
    required int limit,
    required int offset,
  }) async {
    final uri = Uri.parse('${AppConfig.giphyBaseUrl}/search').replace(queryParameters: {
      'api_key': AppConfig.giphyApiKey,
      'q': query,
      'limit': '$limit',
      'offset': '$offset',
      'rating': 'g',
      'lang': 'en',
    });

    try {
      final res = await _client.get(uri, headers: {'Accept': 'application/json'});
      if (res.statusCode != 200) {
        throw HttpException('Status ${res.statusCode}: ${res.body}');
      }
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      final data = (body['data'] as List?)?.cast<Map<String, dynamic>>() ?? const <Map<String, dynamic>>[];
      return data.map(GifModel.fromJson).toList(growable: false);
    } on SocketException {
      throw Exception('No internet connection');
    }
  }

  Future<List<GifModel>> search(String query, int limit, int offset) {
    return searchGifs(query: query, limit: limit, offset: offset);
  }
}
