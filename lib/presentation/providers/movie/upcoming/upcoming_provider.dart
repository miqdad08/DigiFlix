import 'package:digi_flix/domain/entities/result.dart';
import 'package:digi_flix/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:digi_flix/domain/usecases/get_movie_list/get_movie_list_param.dart';
import 'package:digi_flix/presentation/providers/usecases/get_movie_list/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/entities/movie/movie.dart';

part 'upcoming_provider.g.dart';

@Riverpod(keepAlive: true)
class Upcoming extends _$Upcoming {
  @override
  FutureOr<List<Movie>> build() => const [];

  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();

    GetMovieList getMovieList = ref.read(getMovieListProvider);

    var result = await getMovieList(GetMovieListParam(
      category: MovieListCategory.upcoming,
      page: page,
    ));

    switch(result){
      case Success(value: final movies) : state = AsyncData(movies);
      case Failed(message: _) : state = const AsyncData([]);
    }
  }
}
