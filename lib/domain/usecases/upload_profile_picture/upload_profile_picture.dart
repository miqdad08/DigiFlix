import 'package:digi_flix/data/repository/user_repository.dart';
import 'package:digi_flix/domain/entities/result.dart';
import 'package:digi_flix/domain/usecases/upload_profile_picture/upload_profile_picture_param.dart';
import 'package:digi_flix/domain/usecases/usecase.dart';

import '../../entities/user/user.dart';

class UploadProfilePicture
    implements UseCase<Result<User>, UploadProfilePictureParam> {
  final UserRepository _userRepository;

  UploadProfilePicture({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<User>> call(UploadProfilePictureParam params) => _userRepository
      .uploadProfilePicture(user: params.user, imageFile: params.imageFile );
}
