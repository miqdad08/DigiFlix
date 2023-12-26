import 'package:digi_flix/data/repository/authentication.dart';
import 'package:digi_flix/data/repository/user_repository.dart';
import 'package:digi_flix/domain/entities/result.dart';
import 'package:digi_flix/domain/usecases/usecase.dart';

import '../../entities/user/user.dart';

class GetLoggedInUser implements UseCase<Result<User>, void> {
  final Authentication _authentication;
  final UserRepository _userRepository;

  GetLoggedInUser(
      {required Authentication authentication,
      required UserRepository userRepository})
      : _authentication = authentication,
        _userRepository = userRepository;

  @override
  Future<Result<User>> call(void _) async {
    String? loggedId = _authentication.getLoggedInUserId();
    if (loggedId != null) {
      var userResult = await _userRepository.getUser(uid: loggedId);
      if (userResult.isSuccess) {
        return Result.success(userResult.resultValue!);
      } else {
        return Result.failed('${userResult.errorMessage}');
      }
    } else {
      return const Result.failed('No user logged in');
    }
  }
}
