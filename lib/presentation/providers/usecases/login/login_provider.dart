import 'package:digi_flix/presentation/providers/repository/authentication/authentication_provider.dart';
import 'package:digi_flix/presentation/providers/repository/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../domain/usecases/login/login.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
      authentication: ref.watch(authenticationProvider),
      userRepository: ref.watch(userRepositoryProvider));
