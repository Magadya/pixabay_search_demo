import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../search/bloc/search_cubit.dart';

import '../search/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pixabay Images Search'),
          actions: [
            IconButton(
              iconSize: kIsWeb ? 48.0 : 24.0,
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<SearchCubit>(context, listen: false),
                      child: const SearchScreen(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: const Center(child: Text('Use Search to find images')));
  }
}
