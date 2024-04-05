import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {


  const MovieScreen({
    Key? key,
    required this.movieId
  }) : super(key: key);

  static const name = 'movie-screen';

  final String movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('Movie ID: $movieId'),
      ),
    );
  }
}

