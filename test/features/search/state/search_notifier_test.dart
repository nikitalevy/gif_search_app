import 'package:flutter_test/flutter_test.dart';
import 'package:chi_giphy/data/models/gif_model.dart';
import 'package:chi_giphy/features/search/state/search_notifier.dart';
import 'package:chi_giphy/data/repository/gif_repository.dart';
import 'package:chi_giphy/data/services/giphy_api_service.dart';

class FakeRepo extends GifRepository {
  FakeRepo() : super(GiphyApiService());

  @override
  Future<List<GifModel>> search({
    required String query,
    required int limit,
    required int offset,
  }) async {

    return List.generate(limit, (i) {
      final id = (offset + i).toString();
      return GifModel(
        id: id,
        title: 'Gif $id',
        previewUrl: 'https://example.com/preview_$id.gif',
        detailUrl: 'https://example.com/detail_$id.gif',
      );
    });
  }
}

void main() {
  test('SearchNotifier loads first page and paginates', () async {
    final repo = FakeRepo();
    final notifier = SearchNotifier(repo);

    await notifier.search('cat');
    final firstCount = notifier.state.items.length;
    print('✅ First page count: $firstCount');

    await notifier.loadMore();
    final secondCount = notifier.state.items.length;
    print('✅ After loadMore count: $secondCount');

    expect(firstCount, greaterThan(0),
        reason: 'First page should load items');
    expect(secondCount, greaterThan(firstCount),
        reason: 'Second page should add more items');
  });
}
