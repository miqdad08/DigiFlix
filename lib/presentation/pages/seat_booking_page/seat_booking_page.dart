import 'dart:math';

import 'package:digi_flix/presentation/extensions/build_context_extension.dart';
import 'package:digi_flix/presentation/misc/constants.dart';
import 'package:digi_flix/presentation/misc/methods.dart';
import 'package:digi_flix/presentation/pages/seat_booking_page/methods/movie_screen.dart';
import 'package:digi_flix/presentation/pages/seat_booking_page/methods/seat_section.dart';
import 'package:digi_flix/presentation/providers/router/router_provider.dart';
import 'package:digi_flix/presentation/widgets/back_navigation_bar.dart';
import 'package:digi_flix/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie_detail/movie_detail.dart';
import '../../../domain/entities/transaction/transaction.dart';
import 'methods/legend.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const SeatBookingPage({super.key, required this.transactionDetail});

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int> reservedSeats = [];

  @override
  void initState() {
    super.initState();
    Random random = Random();
    int reservedNumber = random.nextInt(36) + 1;

    while (reservedSeats.length < 8) {
      if (!reservedSeats.contains(reservedNumber)) {
        reservedSeats.add(reservedNumber);
      }
      reservedNumber = random.nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                BackNavigationBar(
                  title: movieDetail.title,
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                movieScreen(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    seatSection(
                      seatNumber: List.generate(18, (index) => index + 1),
                      onTap: onSeatTap,
                      seatStatusChecker: seatStatusChecker,
                    ),
                    horizontalSpace(30),
                    seatSection(
                      seatNumber: List.generate(18, (index) => index + 19),
                      onTap: onSeatTap,
                      seatStatusChecker: seatStatusChecker,
                    ),
                  ],
                ),
                verticalSpace(20),
                legend(),
                verticalSpace(40),
                Text(
                  '${selectedSeats.length} seats selected',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                verticalSpace(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (selectedSeats.isEmpty) {
                        context.showSnackBar('Please select at least one seat');
                      } else {
                        var updatedTransaction = transaction.copyWith(
                          ticketAmount: selectedSeats.length,
                          ticketPrice: 25000,
                          seats:
                              (selectedSeats..sort()).map((e) => '$e').toList(),
                        );
                        ref.read(routerProvider).pushNamed(
                            'booking-confirmation-page',
                            extra: (movieDetail, updatedTransaction));
                      }
                    },
                    child: const Text('Next'),
                  ),
                ),
                //button
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onSeatTap(int seatNumber) {
    if (!selectedSeats.contains(seatNumber)) {
      setState(() {
        selectedSeats.add(seatNumber);
      });
    } else {
      setState(() {
        selectedSeats.remove(seatNumber);
      });
    }
  }

  SeatStatus seatStatusChecker(seatNumber) => reservedSeats.contains(seatNumber)
      ? SeatStatus.reserved
      : selectedSeats.contains(seatNumber)
          ? SeatStatus.selected
          : SeatStatus.available;
}
