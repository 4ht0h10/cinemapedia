import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

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
        autoplay: false,
        viewportFraction: 0.8,
        scale: 0.9,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return _Slide(movie: movies[index]);
        },
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary, color: colors.secondary)),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

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

              return FadeIn(child: child);
            },
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              // TODO: Appropriate logging or analytics, e.g.
              // myAnalytics.recordError(
              //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
              //   exception,
              //   stackTrace,
              // );
              print('**** Ha petado la recuperación de la imagen ${movie.backdropPath}');
              return const Text('################');
            },
          ),
        ),
      ),
    );
  }
}
