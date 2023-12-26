import 'package:digi_flix/domain/usecases/get_transactions/get_transactions.dart';
import 'package:digi_flix/presentation/providers/repository/transaction_repository_provider/transaction_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_transactions_provider.g.dart';

@riverpod
GetTransactions getTransactions(GetTransactionsRef ref)=>
    GetTransactions(transactionRepository: ref.watch(transactionRepositoryProvider));