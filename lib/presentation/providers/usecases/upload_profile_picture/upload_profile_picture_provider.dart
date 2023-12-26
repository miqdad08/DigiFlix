import 'package:digi_flix/domain/usecases/upload_profile_picture/upload_profile_picture.dart';
import 'package:digi_flix/presentation/providers/repository/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upload_profile_picture_provider.g.dart';

@riverpod
UploadProfilePicture uploadProfilePicture(UploadProfilePictureRef ref)=>
    UploadProfilePicture(userRepository: ref.watch(userRepositoryProvider));