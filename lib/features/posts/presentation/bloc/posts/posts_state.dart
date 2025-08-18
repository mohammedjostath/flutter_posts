part of 'posts_bloc.dart';

@immutable
sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState {}

class PostsLoadedState extends PostsState {
  final List<Post> posts;

  const PostsLoadedState({required this.posts});

  @override
  List<Object> get props => posts;
}

class ErrorPostsState extends PostsState {
  final String message;

  const ErrorPostsState({required this.message});

  @override
  List<Object> get props => [message];
}
