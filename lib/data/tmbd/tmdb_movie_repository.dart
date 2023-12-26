import 'package:digi_flix/data/repository/movie_repository.dart';
import 'package:digi_flix/domain/entities/actor/actor.dart';
import 'package:digi_flix/domain/entities/movie/movie.dart';
import 'package:digi_flix/domain/entities/movie_detail/movie_detail.dart';
import 'package:digi_flix/domain/entities/result.dart';
import 'package:dio/dio.dart';

class TmdbMovieRepository implements MovieRepository {
  final Dio? _dio;

  final String _accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZDI0ZWJkYWNiZDI1ZDE4NjUzNDM4N2YxYmY1MTk0OCIsInN1YiI6IjYyOGM3Yjk2MTI5NzBjMDA2NjBhNzQyMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KdrufiPnpO19eIAKdBgA7-xVgl6WIIoV2WAavYhmpnQ';

  late final Options _options = Options(headers: {
    'Authorization': 'Bearer $_accessToken',
    'accept': 'application/json',
  });

  TmdbMovieRepository({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<Result<List<Actor>>> getActors({required int id}) async {
    try {
      final response = await _dio!.get(
          'https://api.themoviedb.org/3/movie/$id/credits?language=en-US',
          options: _options);
      print('response ${response.data}');
      final result = List<Map<String, dynamic>>.from(response.data['cast']);
      print('result $result');
      return Result.success(result.map((e) => Actor.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<MovieDetail>> getDetail({required int id}) async {
    try {
      final response = await _dio!.get(
          'https://api.themoviedb.org/3/movie/$id?language=en-US',
          options: _options);
      return Result.success(MovieDetail.fromJSON(response.data));
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) async =>
      _getMovie(_MovieCategory.nowPlaying.toString(), page: page);

  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) async {
    return _getMovie(_MovieCategory.upcoming.toString(), page: page);
  }

  Future<Result<List<Movie>>> _getMovie(String category, {int page = 1}) async {
    try {
      final response = await _dio!.get(
        'https://api.themoviedb.org/3/movie/$category?language=en-US&page=$page',
        options: _options,
      );
      final result = List<Map<String, dynamic>>.from(response.data['results']);
      return Result.success(result.map((e) => Movie.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}

enum _MovieCategory {
  nowPlaying('now_playing'),
  upcoming('upcoming');

  final String _instring;

  const _MovieCategory(String inString) : _instring = inString;

  @override
  String toString() => _instring;
}
