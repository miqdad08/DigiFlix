import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_flix/data/repository/transaction_repository.dart';
import 'package:digi_flix/domain/entities/result.dart';
import 'package:digi_flix/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:digi_flix/domain/usecases/usecase.dart';

class CreateTransaction
    implements UseCase<Result<void>, CreateTransactionParam> {
  final TransactionRepository _transactionRepository;

  CreateTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(CreateTransactionParam params) async {
    int transactionTime = DateTime.now().millisecondsSinceEpoch;
    var result = await _transactionRepository.createTransaction(
      transaction: params.transaction.copyWith(
        transactionTime: transactionTime,
        id: (params.transaction.id == null)
            ? 'dflx-$transactionTime-${params.transaction.uid}'
            : params.transaction.id,
      ),
    );

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed(message: final message) => Result.failed(message),
    };
  }
}
