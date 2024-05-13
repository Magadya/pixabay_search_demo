import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_search_demo/modules/search/bloc/search_cubit.dart';

import 'modules/home/home_screen.dart';
import 'modules/repository/search_repository.dart';

void main() {
  runApp(
    BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(repository: SearchRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repo Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
