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
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {
    final nowPlaying7Movies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies  = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies    = ref.watch(popularMoviesProvider);
    final popularMovies     = ref.watch(popularMoviesProvider);
    final topRatedMovies    = ref.watch(popularMoviesProvider);

    if (nowPlaying7Movies.isEmpty) return const CircularProgressIndicator();

    return CustomScrollView(
      slivers: [

              const SliverAppBar(
                floating: true,
                flexibleSpace: CustomAppbar(),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (context, index) {
                    return Column(
                            children: [
                              // Carrusel
                              MoviesSliceshow(movies: nowPlaying7Movies),

                              // Now playing movies
                              MovieHorizontalListview(
                                movies: nowPlayingMovies,
                                title: 'En cines',
                                subTitle: '20/03/2024',
                                loadNextPage: () =>
                                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                              ),

                              // Upcoming movies
                              MovieHorizontalListview(
                                movies: upcomingMovies,
                                title: 'Próximos estrenos',
                                //subTitle: 'Never',
                                loadNextPage: () =>
                                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                              ),

                              // Popular movies
                              MovieHorizontalListview(
                                movies: popularMovies,
                                title: 'Populares',
                                //subTitle: 'Las más vistas',
                                loadNextPage: () =>
                                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
                              ),

                              // Top rated movies
                              MovieHorizontalListview(
                                movies: topRatedMovies,
                                title: 'Mejor valoradas',
                                //subTitle: 'Las más vistas',
                                loadNextPage: () =>
                                    ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                              ),

                              const SizedBox(height: 10),
                            ],
                          );
                  }))
      ]
      
    );
  }
}
