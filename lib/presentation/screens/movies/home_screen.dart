import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _HomeView(),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
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

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final nowPlaying7Movies = ref.watch(moviesSlideShowProvider);

    if (nowPlaying7Movies.isEmpty) return const CircularProgressIndicator();

    return Column(
      children: [

          const CustomAppbar(),

          MoviesSliceshow(movies: nowPlaying7Movies),

          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'En cines',
            subTitle: '19/03/2024',
          ),


      ],
    );
  }
}
