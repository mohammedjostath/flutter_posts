part of 'add_update_delete_post_bloc.dart';

@immutable
sealed class AddUpdateDeletePostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddUpdateDeletePostEvent {
  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddUpdateDeletePostEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddUpdateDeletePostEvent {
  final int id;

  DeletePostEvent({required this.id});

  @override
  List<Object> get props => [id];
}
