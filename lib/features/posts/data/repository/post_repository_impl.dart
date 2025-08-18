import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/internet_checker/network_info.dart';
import '../../../../../features/posts/data/model/post_model.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../features/posts/domain/entities/post.dart';
import '../../../../../features/posts/domain/repository/posts_repository.dart';

import '../datasource/post_local_data_source.dart';
import '../datasource/post_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return right(localPosts);
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    if (await networkInfo.isConnected) {
      return _getMessage(() {
        return remoteDataSource.deletePost(id);
      });
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
