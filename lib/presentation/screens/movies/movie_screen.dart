import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';
  final String movieId;


  const MovieScreen({Key? key, required this.movieId}) : super(key: key);


  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieInfoProvider);
    final movie = movies[widget.movieId];

    /// Mientras no tengamos película saco el loading..
    if (movie == null) {

      return Scaffold(body: const Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [

          _CustomSlieverAppBar(movie: movie),
          
          SliverList(
              delegate: SliverChildBuilderDelegate(
                        (context, index) => _MovieDetails(movie: movie),
                        childCount: 1,
                        )
          )
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

 

    return Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Imagen
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                                movie.posterPath,
                                width: size.width * 0.3,  
                      ), 
                    ),

                    const SizedBox( width: 10),

                    // Descripción
                    SizedBox(
                      width: (size.width - 40) * 0.7,
                      child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(movie.title, style: textStyles.titleLarge),
                                  Text(movie.overview),
                                ],
                              ),
                    ),

                  ],

                ),
              ),
                
              
                // Géneros de la película
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Wrap(
                      children: [
                        ...movie.genreIds.map((gender) => Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Chip(label: Text(gender), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                        ))
                      ],
                    ),
                    ),
                
                // TODO: Actores de la película

             
               SizedBox( height: 100),

            ],



          );
  }
}

class _CustomSlieverAppBar extends StatelessWidget {
  final Movie movie;

  _CustomSlieverAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
      expandedHeight: size.height * 0.7,
      flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      centerTitle: true,
                      title: Text(
                                  movie.title,
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.start,
                                ),
                      background: Stack(
                                    children: [
                                      SizedBox.expand(
                                        child: Image.network(
                                          movie.posterPath,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox.expand(
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black87,
                                                      Colors.transparent,
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    stops: [0.0, 0.3]))),
                                      ),
                                      SizedBox.expand(
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black87,
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    stops: [0.7, 1.0]))),
                                      ),
                                    ],
                                  ),
                    ),
    );
  }
}
