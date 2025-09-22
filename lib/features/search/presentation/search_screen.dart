import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/search_notifier.dart';
import 'gif_grid.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchNotifierProvider);
    final notifier = ref.read(searchNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Giphy Search',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: notifier.onQueryChanged,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Search GIFs...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: Builder(
              builder: (_) {
                if (state.isLoading && state.items.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wifi_off,
                            size: 64, color: Colors.grey),
                        const SizedBox(height: 12),
                        Text(state.error!,
                            style: const TextStyle(color: Colors.black54)),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => notifier.search(state.query),
                          child: const Text('Retry'),
                        )
                      ],
                    ),
                  );
                }
                if (state.items.isEmpty) {
                  return const Center(
                      child: Text('No results',
                          style: TextStyle(color: Colors.black54)));
                }
                return GifGrid(
                  gifs: state.items,
                  scrollController: notifier.scrollController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
