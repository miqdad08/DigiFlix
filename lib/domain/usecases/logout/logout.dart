import 'package:digi_flix/data/repository/authentication.dart';
import 'package:digi_flix/domain/usecases/usecase.dart';

import '../../entities/result.dart';

class Logout implements UseCase<Result<void>, void> {
  final Authentication _authentication;

  Logout({required Authentication authentication})
      : _authentication = authentication;

  @override
  Future<Result<void>> call(void _) {
    return _authentication.logout();
  }
}
