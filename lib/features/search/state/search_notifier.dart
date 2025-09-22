import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/gif_model.dart';
import '../../../data/repository/gif_repository.dart';

class SearchState {
  final String query;
  final bool isLoading;
  final String? error;
  final List<GifModel> items;

  const SearchState({
    this.query = '',
    this.isLoading = false,
    this.error,
    this.items = const [],
  });

  SearchState copyWith({
    String? query,
    bool? isLoading,
    String? error,
    List<GifModel>? items,
  }) {
    return SearchState(
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      items: items ?? this.items,
    );
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  final GifRepository repository;
  final ScrollController scrollController = ScrollController();

  Timer? _debounce;
  static const int _limit = 25;
  int _offset = 0;
  bool _isFetching = false;

  SearchNotifier(this.repository) : super(const SearchState()) {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  void onQueryChanged(String query) {
    state = state.copyWith(query: query);
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      search(query);
    });
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = const SearchState(query: '');
      return;
    }

    state = state.copyWith(isLoading: true, query: query, items: [], error: null);
    _offset = 0;

    try {
      final results = await repository.search(
        query: query,
        limit: _limit,
        offset: _offset,
      );
      state = state.copyWith(items: results, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (_isFetching || state.isLoading || state.query.isEmpty) return;
    _isFetching = true;

    try {
      final nextOffset = state.items.length;
      final more = await repository.search(
        query: state.query,
        limit: _limit,
        offset: nextOffset,
      );

      if (more.isNotEmpty) {
        state = state.copyWith(items: [...state.items, ...more], error: null);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      _isFetching = false;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}

final searchNotifierProvider =
StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  final repo = ref.read(gifRepositoryProvider);
  return SearchNotifier(repo);
});
