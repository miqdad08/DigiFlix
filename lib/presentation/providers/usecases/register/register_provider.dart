import 'package:digi_flix/domain/usecases/register/register.dart';
import 'package:digi_flix/presentation/providers/repository/authentication/authentication_provider.dart';
import 'package:digi_flix/presentation/providers/repository/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'register_provider.g.dart';

@riverpod
Register register(RegisterRef ref) => Register(
      authentication: ref.watch(authenticationProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
