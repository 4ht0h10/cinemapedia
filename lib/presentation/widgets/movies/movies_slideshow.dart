import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MoviesSliceshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSliceshow({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        autoplay: true,
        viewportFraction: 0.8,
        scale: 0.9,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return _SlideCarrousel(movie: movies[index]);
        },
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary, color: colors.secondary)),
      ),
    );
  }
}

class _SlideCarrousel extends StatelessWidget {
  final Movie movie;

  const _SlideCarrousel({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
                  movie.backdropPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    
                    if (loadingProgress != null) {

                      return const DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black12));
                    }

                    return GestureDetector(
                      
                      child: FadeIn(child: child),
                      onTap: () => context.push('/movie/${movie.id}'),
                      );
                  },
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    // TODO: Appropriate logging or analytics, e.g.
                    // myAnalytics.recordError(
                    //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                    //   exception,
                    //   stackTrace,
                    // );
                    print('**** Ha petado la recuperación de la imagen: ${movie.backdropPath}');
                    return const Text('AAAAHHH!!!!!');
                  },
                ),
        ),
      ),
    );
  }
}
