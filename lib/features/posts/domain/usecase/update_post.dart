import 'package:dartz/dartz.dart';
import '../../../../../features/posts/domain/repository/posts_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class UpdatePostUseCase {
  final PostsRepository _repository;

  UpdatePostUseCase(this._repository);

  Future<Either<Failure, Unit>> execute(Post post) async {
    return await _repository.updatePost(post);
  }
}
