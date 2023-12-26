import 'package:digi_flix/domain/usecases/get_logger_in_user/get_logged_in_user.dart';
import 'package:digi_flix/presentation/providers/repository/authentication/authentication_provider.dart';
import 'package:digi_flix/presentation/providers/repository/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logged_in_user_provider.g.dart';

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) => GetLoggedInUser(
      authentication: ref.watch(authenticationProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
