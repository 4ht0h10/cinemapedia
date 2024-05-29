import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import 'package:animate_do/animate_do.dart';


class SearchMovieDelegate extends SearchDelegate <Movie?>{
  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
        FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 500),
          child: IconButton(
              onPressed: () => query = '', 
              icon: const Icon(Icons.clear),
          )
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(
              onPressed: () => close(context, null), 
              icon: Icon(Icons.arrow_back_ios_new_outlined),
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResultsfdfdf');

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return Text('buildSuggestions');
  }
}
