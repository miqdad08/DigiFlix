import 'package:digi_flix/data/firebase/firebase_authentication.dart';
import 'package:digi_flix/data/repository/authentication.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_provider.g.dart';

@riverpod
Authentication authentication(AuthenticationRef ref) =>
    FirebaseAuthentication();
