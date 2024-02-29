import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Este repositorio es inmutable (solo lectura)
/// 
/// Su objetivo es proporcionar a todos los demás providers que tengo 
/// allá adentro la información necesaria para que puedan consultar
/// la información de éste repository implementation.
/// 
final movieRepositoryProvider = Provider( (ref) {

    return MovieRepositoryImpl(MoviedbDatasource());
  },
);
