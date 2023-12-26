import 'package:digi_flix/domain/usecases/create_transaction/create_transaction.dart';
import 'package:digi_flix/presentation/providers/repository/transaction_repository_provider/transaction_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_transaction_provider.g.dart';

@riverpod
CreateTransaction createTransaction(CreateTransactionRef ref)=>
    CreateTransaction(transactionRepository: ref.watch(transactionRepositoryProvider));