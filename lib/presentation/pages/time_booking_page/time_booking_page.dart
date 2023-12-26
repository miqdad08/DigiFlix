import 'package:digi_flix/presentation/extensions/build_context_extension.dart';
import 'package:digi_flix/presentation/misc/constants.dart';
import 'package:digi_flix/presentation/misc/methods.dart';
import 'package:digi_flix/presentation/pages/time_booking_page/methods/options.dart';
import 'package:digi_flix/presentation/providers/router/router_provider.dart';
import 'package:digi_flix/presentation/providers/user_data/user_data_provider.dart';
import 'package:digi_flix/presentation/widgets/back_navigation_bar.dart';
import 'package:digi_flix/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/movie_detail/movie_detail.dart';
import '../../../domain/entities/transaction/transaction.dart';

class TimeBookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;

  const TimeBookingPage(this.movieDetail, {super.key});

  @override
  ConsumerState<TimeBookingPage> createState() => _TimeBookingPageState();
}

class _TimeBookingPageState extends ConsumerState<TimeBookingPage> {
  final List<String> theaters = [
    'XXI Kramat Jati',
    'XXI Ciwalk',
    'CGV Paskal23',
    'CGV Kemang Village',
  ];

  final List<DateTime> dates = List.generate(7, (index) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date.add(Duration(days: index));
  });

  late List<int> hours = List.generate(8, (index) => index + 12);

  String? selectedTheather;
  DateTime? selectedDate;
  int? selectedHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: BackNavigationBar(
                  title: widget.movieDetail.title,
                  onTap: () {
                    ref.read(routerProvider).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: NetworkImageCard(
                  width: MediaQuery.of(context).size.width - 48,
                  height: (MediaQuery.of(context).size.width - 48) * 0.6,
                  borderRadius: 15,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500/${widget.movieDetail.backdropPath ?? widget.movieDetail.posterPath}',
                  boxFit: BoxFit.cover,
                ),
              ),
              ...options(
                title: 'Select  a Theather',
                options: theaters,
                selectedItem: selectedTheather,
                onTap: (object) => setState(() {
                  selectedTheather = object;
                }),
              ),
              verticalSpace(24),
              ...options(
                title: 'Select date',
                options: dates,
                selectedItem: selectedDate,
                converter: (date) => DateFormat('EEE, d MMMM y').format(date),
                onTap: (object) => setState(() {
                  selectedDate = object;
                }),
              ),
              verticalSpace(24),
              ...options(
                title: 'Select show time',
                options: hours,
                converter: (object) => '$object:00',
                selectedItem: selectedHour,
                isOptionEnable: (hour) =>
                    selectedDate != null &&
                    DateTime(selectedDate!.year, selectedDate!.month,
                            selectedDate!.day, hour)
                        .isAfter(DateTime.now()),
                onTap: (object) => setState(() {
                  selectedHour = object;
                }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedDate == null ||
                          selectedHour == null ||
                          selectedTheather == null) {
                        context.showSnackBar('Please select all option');
                      } else {
                        Transaction transaction = Transaction(
                          uid: ref.read(userDataProvider).value!.uid,
                          title: widget.movieDetail.title,
                          adminFee: 3000,
                          total: 0,
                          watchingTime: DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedHour!,
                          ).millisecondsSinceEpoch,
                          transactionImage: widget.movieDetail.posterPath,
                          theaterName: selectedTheather,
                        );
                        ref.read(routerProvider).pushNamed('seat-booking', extra: (widget.movieDetail, transaction));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Next",
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
