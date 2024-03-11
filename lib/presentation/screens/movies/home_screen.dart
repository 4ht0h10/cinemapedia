import 'package:cinemapedia/presentation/providers/movies/movies_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _HomeView(),
      ),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(moviesSlideShowProvider);
    //final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    if (nowPlayingMovies.isEmpty) return CircularProgressIndicator();

    return Column(
      children: [

          const CustomAppbar(),

          MoviesSliceshow(movies: nowPlayingMovies)

          /* Expanded(
            child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10) ,
                  itemCount: nowPlayingMovies.length,
                  itemBuilder: (context, index) {
                    final movie = nowPlayingMovies[index];
            
                    return ListTile(
                      title: Text(movie.title),
                    );
                  },
                ),
          ) */


      ],
    );
  }
}
