import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_search_demo/modules/search/bloc/search_state.dart';

import '../../repository/search_repository.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repository;
  int _currentPage = 1;

  SearchCubit({
    required SearchRepository repository,
  })  : _repository = repository,
        super(
          SearchState(),
        );

  void init() {
    emit(state.copyWith(status: SearchStatus.loading));
  }

  void search(String query) {
    emit(
      state.copyWith(
        query: query,
      ),
    );
    _requestSearchList();
  }

  void searchClear(String query) {
    emit(
      state.copyWith(
        query: query,
        images: [],
      ),
    );
  }

  Future<void> refreshList() {
    _currentPage = 1;
    emit(
      state.copyWith(
        status: SearchStatus.backgroundLoading,
      ),
    );
    return _requestSearchList();
  }

  Future<void> loadNextPage() {
    _currentPage++;
    return _requestSearchList(requestNextPage: true);
  }

  Future<void> _requestSearchList({bool requestNextPage = false}) async {
    try {
      final result =
          await _repository.getImagesWithSearchQuery(state.query, requestNextPage == false ? 1 : _currentPage);
      if (requestNextPage == false) {
        emit(
          state.copyWith(
            images: result ?? [],
            status: SearchStatus.pending,
          ),
        );
      } else {
        emit(
          state.copyWith(
            images: [...state.images ?? [], ...result ?? []],
            status: SearchStatus.pending,
          ),
        );
      }
    } catch (e) {
      print("error " + e.toString());
      emit(
        state.copyWith(
          backendError: e.toString(),
          status: SearchStatus.error,
        ),
      );
    }
  }
}
