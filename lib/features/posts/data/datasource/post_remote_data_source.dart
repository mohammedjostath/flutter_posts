import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/data/model/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int id);

  Future<Unit> updatePost(PostModel post);

  Future<Unit> addPost(PostModel post);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  Future<List<PostModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> addPost(PostModel post) {
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
