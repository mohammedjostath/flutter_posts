import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_posts/features/posts/domain/entities/post.dart';
import 'package:flutter_posts/features/posts/domain/usecase/get_post.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPostsUseCase.execute();
        failureOrPosts.fold(
          (failure) {
            emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
          },
          (posts) {
            emit(PostsLoadedState(posts: posts));
          },
        );
      } /*else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
      }*/
    });
  }

  String _mapFailureToMessage(Failure f) {
    switch (f.runtimeType) {
      case ServerFailure _:
        return "Please try again later";
      case EmptyCacheFailure _:
        return "No data";
      case OfflineFailure _:
        return "Please check your internet connection";
      default:
        return "Unexpected error, please try again later";
    }
  }
}
