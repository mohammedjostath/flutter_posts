import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../../../../features/posts/domain/entities/post.dart';
import '../../../../../../../features/posts/domain/usecase/add_post.dart';
import '../../../../../../../features/posts/domain/usecase/delete_post.dart';
import '../../../../../../../features/posts/domain/usecase/update_post.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;

  AddUpdateDeletePostBloc(
     this.addPost,
     this.deletePost,
     this.updatePost,
   ) : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        Either<Failure, Unit> successOrFailure = await addPost.execute(
          event.post,
        );

        _eitherDoneMessageOrErrorState(
          successOrFailure,
          'Post added successfully',
        );

      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        Either<Failure, Unit> successOrFailure = await updatePost.execute(
          event.post,
        );

        _eitherDoneMessageOrErrorState(
          successOrFailure,
          'Post updated successfully',
        );

      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        Either<Failure, Unit> successOrFailure = await deletePost.execute(
          event.id,
        );

        _eitherDoneMessageOrErrorState(
          successOrFailure,
          'Post added successfully',
        );
      }
    });
  }

  AddUpdateDeletePostState _eitherDoneMessageOrErrorState(
    Either<Failure, Unit> either,
    String message,
  ) {
    return either.fold(
      (failure) =>
          ErrorAddDeleteUpdatePostState(message: _mapFailureToMessage(failure)),
      (_) => MessageAddDeleteUpdatePostState(message: message),
    );
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
