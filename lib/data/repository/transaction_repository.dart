import 'package:digi_flix/domain/entities/transaction/transaction.dart';

import '../../domain/entities/result.dart';

abstract interface class TransactionRepository{
  Future<Result<Transaction>> createTransaction({required Transaction transaction});
  Future<Result<List<Transaction>>> getUserTrasactions({required String uid});
}