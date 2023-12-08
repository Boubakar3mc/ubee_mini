import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/utils/usecase.dart';
import 'package:ubee_mini/features/signin/domain/repository/user_repository.dart';


class UpdatePicture extends UseCase<bool, UpdatePictureParams>{
  final UserRepository repo;

  UpdatePicture(this.repo);
  @override
  Future<bool> call(UpdatePictureParams params) {
    return repo.updatePicture(params.file);
  }
  
}

class UpdatePictureParams extends Equatable{
  final File file;

  const UpdatePictureParams(this.file);
  
  @override
  List<Object?> get props => [file];
}