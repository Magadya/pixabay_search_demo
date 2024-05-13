

import 'package:equatable/equatable.dart';
import 'package:pixabay_search_demo/modules/search/models/image_model.dart';

import '../models/search_result_model.dart';


enum SearchStatus {
  loading,
  backgroundLoading,
  pending,
  error,
}

class SearchState {
  List<ImageModel>? images;
  final String? query;
  final SearchStatus status;
  final String? backendError;

  SearchState({
    this.images,
    this.query,
    this.status = SearchStatus.loading,
    this.backendError,
  });

  SearchState copyWith({
    List<ImageModel>? images,
    String? query,
    SearchStatus? status,
    String? backendError,
  }) {
    return SearchState(
      images: images ?? this.images,
      query: query ?? this.query,
      status: status ?? this.status,
      backendError: backendError ?? this.backendError,
    );
  }

}