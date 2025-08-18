import 'package:dartz/dartz.dart';
import '../../../../../features/posts/domain/repository/posts_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class AddPostUseCase {
  final PostsRepository _repository;

  AddPostUseCase(this._repository);

  Future<Either<Failure, Unit>> execute(Post post) async {
    return await _repository.addPost(post);
  }
}
