import 'package:digi_flix/domain/entities/movie_detail/movie_detail.dart';
import 'package:digi_flix/domain/entities/result.dart';
import 'package:digi_flix/domain/usecases/get_movie_detail/get_movie_detail_param.dart';
import 'package:digi_flix/presentation/providers/usecases/get_movie_detail/get_movie_detail_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/entities/movie/movie.dart';
import '../../../../domain/usecases/get_movie_detail/get_movie_detail.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail?> movieDetail(MovieDetailRef ref, {required Movie movie})async{
  GetMovieDetail getMovieDetail = ref.read(getMovieDetailProvider);

  var movieDetailResult = 
      await getMovieDetail(GetMovieDetailParam(movie: movie));
  
  return switch (movieDetailResult){
    Success(value : final movieDetail) => movieDetail,
    Failed(message : _) => null
  };
}