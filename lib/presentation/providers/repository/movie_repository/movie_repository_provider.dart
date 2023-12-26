import 'package:digi_flix/data/repository/movie_repository.dart';
import 'package:digi_flix/data/tmbd/tmdb_movie_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_repository_provider.g.dart';

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref)=>
    TmdbMovieRepository();