import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/domain/repository/posts_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class DeletePostUseCase {
  final PostsRepository _repository;

  DeletePostUseCase(this._repository);

  Future<Either<Failure, Unit>> execute(int id) async {
    return await _repository.deletePost(id);
  }
}
