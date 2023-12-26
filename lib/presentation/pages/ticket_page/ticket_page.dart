import 'package:digi_flix/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/ticket.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ref.watch(transactionDataProvider).when(
                    data: (transactions) => (transactions
                            .where((element) =>
                                element.title != 'Top Up' &&
                                element.watchingTime! >=
                                    DateTime.now().millisecondsSinceEpoch)
                            .toList()
                          ..sort((a, b) =>
                              a.watchingTime!.compareTo(b.watchingTime!)))
                        .map((transaction) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Ticket(transaction: transaction),
                            ))
                        .toList(),
                    error: (error, st) => [],
                    loading: () => const [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
