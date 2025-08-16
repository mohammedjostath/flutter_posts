import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/domain/repository/posts_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class GetAllPostsUseCase {
  final PostsRepository _repository;

  GetAllPostsUseCase(this._repository);

  Future<Either<Failure, List<Post>>> execute() async {
    return await _repository.getAllPosts();
  }
}
