import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../bloc/search_cubit.dart';
import '../bloc/search_state.dart';
import 'detail_image_screen.dart';
import 'widgets/loading_footer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchQueryController = TextEditingController();
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _searchQueryController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchChanged);
    _searchQueryController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchQueryController.text;
    if (query.length >= 3) {
      Timer(const Duration(seconds: 2), () {
        context.read<SearchCubit>().search(query);
      });
    } else {
      context.read<SearchCubit>().searchClear(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchQueryController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search Images...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black),
          ),
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state.status == SearchStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.backendError ?? 'Backend error')));
          }
        },
        builder: (context, state) {
          if (_searchQueryController.text.length < 3) {
            return const Center(child: Text('Type at least 3 characters to start the search.'));
          }
          if (state.status == SearchStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == SearchStatus.pending) {
            return (state.images ?? []).isEmpty
                ? const Center(child: Text('Empty.'))
                : Column(
                    children: [
                      Expanded(
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullUp: true,
                          footer: const LoadingFooter(),
                          onRefresh: () {
                            if (_refreshController.isRefresh) {
                              context
                                  .read<SearchCubit>()
                                  .refreshList()
                                  .then((_) => _refreshController.refreshCompleted());
                            }
                          },
                          onLoading: () async {
                            if (_refreshController.isLoading) {
                              context.read<SearchCubit>().loadNextPage().then((_) => _refreshController.loadComplete());
                            }
                          },
                          child: ListView.builder(
                            itemCount: (state.images!.length / getColumnCount(context)).ceil(),
                            itemBuilder: (BuildContext context, int rowIndex) {
                              final startIndex = rowIndex * getColumnCount(context);
                              final endIndex = (rowIndex + 1) * getColumnCount(context);
                              final rowImages = state.images!.sublist(
                                  startIndex, endIndex < state.images!.length ? endIndex : state.images!.length);
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: rowImages.map((result) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: const Duration(milliseconds: 500),
                                            pageBuilder: (_, __, ___) => DetailImageScreen(imageModel: result),
                                            transitionsBuilder: (_, animation, __, child) {
                                              return SlideTransition(
                                                position: Tween<Offset>(
                                                  begin: const Offset(1.0, 0.0), // from right to left
                                                  end: Offset.zero,
                                                ).animate(animation),
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width / getColumnCount(context),
                                        height: MediaQuery.of(context).size.width / getColumnCount(context),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: 150,
                                                height: 150,
                                                child: Image.network(
                                                  result.previewURL,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Text('Views: ${result.views}'),
                                            Text('Likes: ${result.likes}'),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
          } else if (state.status == SearchStatus.error) {
            return Center(child: Text(state.backendError ?? 'Backend error'));
          }
          return const Center(child: Text('Type at least 3 characters to start the search.'));
        },
      ),
    );
  }

  int getColumnCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth / 200).floor().clamp(2, 8);
  }
}
