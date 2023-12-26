import 'package:digi_flix/data/firebase/firebase_transaction_repository.dart';
import 'package:digi_flix/data/repository/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'transaction_repository_provider.g.dart';

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref)=>
    FirebaseTransactionRepository();