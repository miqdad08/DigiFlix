import 'package:digi_flix/presentation/misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie_detail/movie_detail.dart';

List<Widget> movieShortInfo({
  required AsyncValue<MovieDetail?> asyncMovieDetail,
  required BuildContext context,
}) =>
    [
      Row(
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/images/duration.png'),
          ),
          horizontalSpace(5),
          SizedBox(
            width: 95,
            child: Text(
              '${asyncMovieDetail.when(
                data: (movieDetail) =>
                    movieDetail != null ? movieDetail.runtime : '-',
                error: (error, stackTrace) => '-',
                loading: () => '-',
              )} minutes',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/images/genre.png'),
          ),
          horizontalSpace(5),
          SizedBox(
            width:
                MediaQuery.of(context).size.width - 48 - 95 - 14 - 14 - 5 - 5,
            child: asyncMovieDetail.when(
              data: (movieDetail) {
                String genre = movieDetail?.genres.join(", ") ?? '-';
                return Text(
                  genre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                );
              },
              error: (error, stackTrace) => const Text(
                '- ',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              loading: () => const Text(
                '- ',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
      verticalSpace(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: Image.asset('assets/images/star.png'),
          ),
          horizontalSpace(5),
          Text(
            (asyncMovieDetail.valueOrNull?.voteAverage ?? 0).toStringAsFixed(1),
          )
        ],
      )
    ];
