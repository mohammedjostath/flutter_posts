part of 'add_update_delete_post_bloc.dart';

@immutable
sealed class AddUpdateDeletePostState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class LoadingAddDeleteUpdatePostState extends AddUpdateDeletePostState {}

class ErrorAddDeleteUpdatePostState extends AddUpdateDeletePostState {
  final String message;

  ErrorAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdatePostState  extends AddUpdateDeletePostState {
  final String message;

  MessageAddDeleteUpdatePostState ({required this.message});

  @override
  List<Object> get props => [message];
}
