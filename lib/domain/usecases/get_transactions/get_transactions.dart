import 'package:digi_flix/data/repository/transaction_repository.dart';
import 'package:digi_flix/domain/usecases/get_transactions/get_transactions_param.dart';
import 'package:digi_flix/domain/usecases/usecase.dart';

import '../../entities/result.dart';
import '../../entities/transaction/transaction.dart';

class GetTransactions
    implements UseCase<Result<List<Transaction>>, GetTransactionParam> {
  final TransactionRepository _transactionRepository;

  GetTransactions({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<List<Transaction>>> call(GetTransactionParam params) async {
    var transactionResult =
        await _transactionRepository.getUserTrasactions(uid: params.uid);

    return switch (transactionResult) {
      Success(value: final transactionList) => Result.success(transactionList),
      Failed(:final message) => Result.failed(message),
    };
  }
}
